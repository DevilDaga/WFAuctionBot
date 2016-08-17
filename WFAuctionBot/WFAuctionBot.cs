using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;

namespace WFAuctionBot
{

	#region JSON Response


	#region AuctionItem

	public class Err
	{
		public string code { get; set; }
		public string msg { get; set; }
	}

	public class WarfaceItemAuction
	{
		public string category { get; set; }
		public string code { get; set; }
		public string offer_type { get; set; }
		public string soldier_class { get; set; }
		public string status { get; set; }
	}

	public class Playable
	{
		public int id { get; set; }
	}

	public class Auction
	{
		public DateTime end { get; set; }
		public int id { get; set; }
		public int initial_price { get; set; }
		public bool is_user_owner { get; set; }
		public int last_offer { get; set; }
		public Playable playable { get; set; }
		public bool sold { get; set; }
		public DateTime start { get; set; }
		public string status { get; set; }
		public int total_bids { get; set; }
		public WarfaceItemAuction warface_item { get; set; }
	}

	public class PayloadAuction
	{
		public Auction auction { get; set; }
		public Err err { get; set; }
	}

	public class RspAuction
	{
		public List<PayloadAuction> payload { get; set; }
		public string stat { get; set; }
	}

	public class AuctionItem
	{
		public RspAuction rsp { get; set; }
	}

	#endregion AuctionItem


	#region InventoryItem

	public class WarfaceItemInventory : WarfaceItemAuction
	{
		public int durability { get; set; }
	}

	public class PayloadInventory
	{
		public WarfaceItemInventory warface_item { get; set; }
		public Err err { get; set; }
	}

	public class RspInventory
	{
		public List<PayloadInventory> payload { get; set; }
		public string stat { get; set; }
	}

	public class InventoryItem
	{
		public RspInventory rsp { get; set; }
	}

	#endregion InventoryItem

	#region Wallet

	public class ReservedCreditBalance
	{
		public int amount { get; set; }
		public string currency { get; set; }
	}

	public class Credit
	{
		public int amount { get; set; }
		public string currency { get; set; }
	}

	public class Wallet
	{
		public List<Credit> credits { get; set; }
		public List<object> initial_credits { get; set; }
		public List<object> points { get; set; }
		public List<ReservedCreditBalance> reserved_credit_balances { get; set; }
		public int userid { get; set; }
	}

	public class PayloadCommerce
	{
		public Wallet wallet { get; set; }
	}

	public class RspCommerce
	{
		public List<PayloadCommerce> payload { get; set; }
		public string stat { get; set; }
	}

	public class Commerce
	{
		public RspCommerce rsp { get; set; }
	}

	#endregion Wallet


	#region Auth

	public class AuthData
	{
		public string affiliateid { get; set; }
		public string lang { get; set; }
		public string nickname { get; set; }
		public string presistentToken { get; set; }
		public string sessionToken { get; set; }
		public object steamid { get; set; }
	}

	public class Auth
	{
		public AuthData data { get; set; }
		public object exception { get; set; }
		public int status { get; set; }
	}

	#endregion Auth

	#endregion JSON Response

	public struct Info
	{
		public Auth auth;
		public Commerce commerce;
		public InventoryItem inventoryItems;
		public int kredits;
		public string nickname;
		public AuctionItem sellingItems;
	}

	internal class WFAuctionBot
	{
		private MyDB myDB;
		private FormWFAB formWFAB;

		#region Account Info

		private string login, password, token, nickname;
		private Auth m_Auth;
		private Commerce m_Commerce;
		private InventoryItem m_InventoryItems;
		private int m_Kredits;
		private AuctionItem m_SellingItems;
		private Dictionary<string, int> m_SellRules;
		private Dictionary<string, string> m_Weapons;
		private bool m_Sold, m_NoSell;

		#endregion Account Info

		public WFAuctionBot ( MyDB myDB, bool noSell = false )
		{
			m_Sold = false;

			var ini = new IniFile ( );
			var keys = ini.ReadKeys ( "SellRules" );
			m_SellRules = new Dictionary<string, int> ( );
			foreach ( var key in keys )
				m_SellRules[key] = Convert.ToInt32 ( ini.Read ( key, "SellRules" ) );

			this.myDB = myDB;
			this.formWFAB = FormWFAB.Instance;
			m_NoSell = noSell;
			m_Weapons = myDB.getWeapons ( );
		}

		#region Public Methods

		public bool Login ( string Login, string Password )
		{
			login = Login;
			password = Password;

			List<string> payload = new List<string> ( );
			payload.Add ( "email=" + HttpUtility.UrlEncode ( login ) );
			payload.Add ( "password=" + HttpUtility.UrlEncode ( password ) );

			string res = POST ( "https://launcher.warface.com/app/auth", payload );
			m_Auth = new JavaScriptSerializer ( ).Deserialize<Auth> ( res );
			if ( m_Auth.status != 1 )
			{
				Log ( "ERROR LOGGING INTO {0}:    CODE: {1}, EXCEPTION: {2}",
					login, m_Auth.status, m_Auth.exception.ToString ( ) );
				return false;
			}
			token = m_Auth.data.sessionToken;
			nickname = m_Auth.data.nickname;
			Log ( "Nickname: " + nickname );
			Log ( "Token: " + token );

			myDB.addAccount ( login, password, nickname );
			return true;
		}

		public void getKredits ( )
		{
			string req = string.Format ( "https://rest.api.gface.com/gface-rest/commerce/wallet/get/my.json?token={0}&gameid=101", token );
			string res = GET ( req );
			m_Commerce = new JavaScriptSerializer ( ).Deserialize<Commerce> ( res );
			m_Kredits = m_Commerce.rsp.payload.First ( ).wallet.credits.First ( ).amount;
			Log ( "Kredits: " + m_Kredits );

			myDB.addAccount ( login, password, nickname, m_Kredits );
		}

		public void Logout ( )
		{
			Log ( nickname + " logged out." );
			Log ( new string ( '-', 114 ) );
		}

		public void getSellingItems ( )
		{
			string req = string.Format ( "https://rest.api.gface.com/gface-rest/games/warface/auction/get.json?token={0}&playableid=102&usertype=seller", token );
			string res = GET ( req );
			m_SellingItems = new JavaScriptSerializer ( ).Deserialize<AuctionItem> ( res );

			myDB.addSellingItems ( m_SellingItems, login );

			if ( m_SellingItems.rsp.payload.Count == 0 )
				Log ( "Not selling any items." );
			else
			{
				Log ( "Selling Items:" );
				foreach ( var item in m_SellingItems.rsp.payload )
					Log ( "{0,-32}: {1} bids, {2} Kredits",
						m_Weapons[item.auction.warface_item.code],
						item.auction.total_bids,
						item.auction.last_offer != 0 ? item.auction.last_offer : item.auction.initial_price
						);
			}
		}

		public void getInventoryItems ( )
		{
			string req = string.Format ( "https://rest.api.gface.com/gface-rest/games/warface/auction/inventory/my.json?token={0}&playableid=102", token );
			string res = GET ( req );
			m_InventoryItems = new JavaScriptSerializer ( ).Deserialize<InventoryItem> ( res );
			m_InventoryItems.rsp.payload.Sort ( ( item1, item2 ) => item2.warface_item.durability - item1.warface_item.durability );

			myDB.removeInventoryItems ( login );
			myDB.addInventoryItems ( m_InventoryItems.rsp.payload, login );

			if ( m_InventoryItems.rsp.payload.Count == 0 )
				Log ( "No items to sell." );
			else
			{
				Log ( "Inventory Items:" );
				foreach ( var item in m_InventoryItems.rsp.payload )
					Log ( "{0,-32} {1}",
						m_Weapons[item.warface_item.code],
						item.warface_item.durability
						);
			}
		}

		public void sellItems ( )
		{
			if ( m_NoSell )
				return;
			int soldItems = m_SellingItems.rsp.payload.Count;
			var sellableItems = m_InventoryItems.rsp.payload.Where (
				i => m_SellRules.ContainsKey ( m_Weapons[i.warface_item.code] )
				&& ( i.warface_item.durability > 100 || i.warface_item.durability == 0 )
				).ToList ( );
			sellableItems.Sort (
				( item1, item2 ) =>
				m_SellRules[m_Weapons[item2.warface_item.code]] - m_SellRules[m_Weapons[item1.warface_item.code]]
				);
			foreach ( var item in sellableItems.Where (
					i => m_SellingItems.rsp.payload.Find (
					j => j.auction.warface_item.code == i.warface_item.code
					) == null )
					)
			{
				if ( soldItems >= 3 )
					break;
				List<string> payload = new List<string> (
					new string[]
					{
						"days=1",
						"initialprice=" + m_SellRules[m_Weapons[item.warface_item.code]].ToString(),
						"itemcode=" + item.warface_item.code,
						"playableid=102", "token=" + token
					}
					);
				string res = POST ( "https://rest.api.gface.com/gface-rest/games/warface/auction/create.json",
					payload );
				Log ( "Selling {0,-32}: {1}",
					m_Weapons[item.warface_item.code],
					m_SellRules[m_Weapons[item.warface_item.code]] );
				++soldItems;
				m_Sold = true;
			}
		}

		public void updateAllAuctions ( bool useFiles = false )
		{
			var req = "https://rest.api.gface.com/gface-rest/games/warface/auction/get.json?orderby=fresh_first&playableid=102";
			var res = GET ( req );
			var latest = new JavaScriptSerializer ( ).Deserialize<AuctionItem> ( res );
			var end = latest.rsp.payload.Max ( x => x.auction.id );
			Log ( "Latest Auction ID: {0}", end );
			var badAuctions = myDB.getNullAuctions ( 50 );
			if ( useFiles )
				updateFromFiles ( 1, end );
			fetchAuctions ( 1, end, badAuctions );
		}

		public void updateMyAuctions ( )
		{
			var auctions = myDB.getAuctions ( ).Where ( x => x.Item2 == "active" || x.Item2 == "closing" );
			int i = 1, items_bid_new = 0, items_bid_first = 0;
			formWFAB.setMaxProgress ( auctions.Count ( ) * ( 2 + 1 ) );
			foreach ( var auction in auctions )
			{
				int id = auction.Item1;
				var req = string.Format ( "https://rest.api.gface.com/gface-rest/games/warface/auction/{0}.json?playableid=102", id );
				var res = GET ( req );
				formWFAB.incProgress ( 2 );
				var updatedAuction = new JavaScriptSerializer ( ).Deserialize<AuctionItem> ( res );
				string email = myDB.getSellerEmail ( updatedAuction );
				var oldAuction = myDB.getAuction ( updatedAuction.rsp.payload[0].auction.id );
				myDB.addSellingItems ( updatedAuction, email );
				formWFAB.incProgress ( 1 );
				Log ( "Updated {0}/{1} auctions.", i++, auctions.Count ( ) );
				if ( oldAuction.total_bids < updatedAuction.rsp.payload[0].auction.total_bids )
				{
					++items_bid_new;
					if ( oldAuction.total_bids == 0 )
						++items_bid_first;
				}
			}
			Log ( "Finished updating auctions. {0} items received a new bid. {1} auctions received their first bid.", items_bid_new, items_bid_first );
		}

		public Info getInfo ( )
		{
			if ( m_Sold )
			{
				getSellingItems ( );
				getInventoryItems ( );
			}
			Info myInfo = new Info ( );
			myInfo.nickname = nickname;
			myInfo.kredits = m_Kredits;
			myInfo.sellingItems = m_SellingItems;
			myInfo.inventoryItems = m_InventoryItems;
			myInfo.commerce = m_Commerce;
			myInfo.auth = m_Auth;
			return myInfo;
		}


		#endregion Public Methods

		#region JSON

		private string GET ( string url )
		{
			var request = (HttpWebRequest) WebRequest.Create ( url );

			request.Method = "GET";
			request.Accept = "application/json";
			request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36";
			var response = (HttpWebResponse) request.GetResponse ( );
			var responseString = new StreamReader ( response.GetResponseStream ( ) ).ReadToEnd ( );
			response.Close ( );

			return responseString;
		}

		private string POST ( string url, List<string> payload )
		{
			var request = (HttpWebRequest) WebRequest.Create ( url );

			var postData = ( payload.First ( ) );
			for ( int i = 1; i < payload.Count; ++i )
				postData += string.Format ( "&{0}", ( payload[i] ) );
			var data = Encoding.ASCII.GetBytes ( postData );

			request.Method = "POST";
			request.ContentType = "application/x-www-form-urlencoded";
			request.ContentLength = data.Length;

			Stream stream = null;
			while ( stream == null )
			{
				try
				{
					stream = request.GetRequestStream ( );
				}
				catch ( Exception e )
				{
					Log ( e.Message );
					continue;
				}
				stream.Write ( data, 0, data.Length );
				stream.Close ( );
			}

			var response = (HttpWebResponse) request.GetResponse ( );
			var responseString = new StreamReader ( response.GetResponseStream ( ) ).ReadToEnd ( );

			response.Close ( );

			return responseString;
		}

		#endregion JSON

		#region Fetch Auction History

		private void addAuctionsToDB ( ConcurrentQueue<AuctionItem> q, ref bool finished )
		{
			while ( !finished || !q.IsEmpty )
			{
				while ( q.IsEmpty )
					Thread.Sleep ( 10 );
				Thread.Sleep ( 10 );
				AuctionItem auction;
				if ( !q.TryDequeue ( out auction ) )
					continue;
				if ( auction == null )
					if ( Debugger.IsAttached )
						Debugger.Break ( );
				myDB.addAuctionAll ( auction, auction.rsp.payload[0].auction.id );
				Log ( "Finished adding: {0}", auction.rsp.payload[0].auction.id );
			}
		}

		private AuctionItem fetchAuctionByIDHelper ( string res, int id )
		{
			var auction = new JavaScriptSerializer ( ).Deserialize<AuctionItem> ( res );
			if ( auction.rsp.stat == "fail" )
			{
				myDB.addAuctionAll ( null, id );
				Log ( "{0}: {1}", auction.rsp.payload[0].err.code, auction.rsp.payload[0].err.msg );
				return null;
			}
			if ( auction.rsp.payload == null )
			{
				myDB.addAuctionAll ( null, id );
				Log ( "{0}: Payload was null!", id );
				return null;
			}
			return auction;
		}

		private void fetchAuctionByID ( ConcurrentQueue<AuctionItem> q, int id )
		{
			string req = string.Format ( "https://rest.api.gface.com/gface-rest/games/warface/auction/{0}.json?playableid=102", id );
			string res = GET ( req );
			var auction = fetchAuctionByIDHelper ( res, id );
			if ( auction != null )
				q.Enqueue ( auction );
		}

		private void fetchAuctions ( int start, int end, List<int> redo )
		{
			var auctions = myDB.getAuctionIDs ( );
			ConcurrentQueue<AuctionItem> q = new ConcurrentQueue<AuctionItem> ( );
			bool finished = false;
			Thread thConsume = new Thread ( ( ) => addAuctionsToDB ( q, ref finished ) );
			thConsume.Start ( );
			List<Task> tasks = new List<Task> ( );
			List<int> ids = new List<int> ( );
			ids.AddRange ( redo );
			for ( int id = start; id != end; ++id )
				if ( !auctions.Contains ( id ) )
					ids.Add ( id );
			Log ( "Number of new auctions to fetch: {0}", ids.Count - redo.Count );
			Log ( "Number of missing auctions to update: {0}", redo.Count );
			formWFAB.setMaxProgress ( ids.Count );
			const int pool_size = 4;
			foreach ( int id in ids )
			{
				while ( tasks.Count == pool_size )
				{
					Task.WaitAny ( tasks.ToArray ( ) );
					tasks = tasks.Where ( x => !x.IsCompleted ).ToList ( );
				}
				{
					Task task = Task.Run ( ( ) => fetchAuctionByID ( q, id ) );
					tasks.Add ( task );
					Thread.Sleep ( 50 );
				}
				formWFAB.incProgress ( 1 );
			}
			Task.WaitAll ( tasks.ToArray ( ), 10000 );
			finished = true;
			Log ( "Finished fetching all auctions." );
		}

		private void updateFromFiles ( int start, int end )
		{
			formWFAB.resetProgress ( );
			formWFAB.setMaxProgress ( end - start );
			var auctions = myDB.getAuctionIDs ( );
			for ( int id = start; id != end; ++id )
			{
				formWFAB.incProgress ( 1 );
				if ( auctions.Contains ( id ) )
					continue;
				string fname = id.ToString ( ) + ".json";
				string path = "auctions\\" + fname;
				if ( File.Exists ( path ) )
				{
					string json = File.ReadAllText ( path );
					var auction = new JavaScriptSerializer ( ).Deserialize<AuctionItem> ( json );
					if ( auction.rsp.stat == "fail" )
					{
						myDB.addAuctionAll ( null, id );
						Log ( "{0}: {1}", auction.rsp.payload[0].err.code, auction.rsp.payload[0].err.msg );
						continue;
					}
					if ( auction.rsp.payload == null )
					{
						myDB.addAuctionAll ( null, id );
						Log ( "{0}: Payload was null!", id );
						continue;
					}
					myDB.addAuctionAll ( auction, auction.rsp.payload[0].auction.id );
					Log ( "Finished adding: {0}", auction.rsp.payload[0].auction.id );
				}
				else
					Log ( "Not found: {0}", fname );
			}
			formWFAB.resetProgress ( );
		}

		#endregion Fetch Auction History

		private string CalculateMD5Hash ( string input )
		{
			// step 1, calculate MD5 hash from input
			MD5 md5 = System.Security.Cryptography.MD5.Create ( );
			byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes ( input );
			byte[] hash = md5.ComputeHash ( inputBytes );

			// step 2, convert byte array to hex string
			StringBuilder sb = new StringBuilder ( );
			for ( int i = 0; i < hash.Length; i++ )
				sb.Append ( hash[i].ToString ( "X2" ) );
			return sb.ToString ( );

		}

		private void Log ( string text, params object[] args )
		{
			formWFAB.Log ( text, args );
		}
	}
}