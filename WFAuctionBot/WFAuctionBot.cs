using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Windows.Forms;

namespace WFAuctionBot
{

	#region JSONResponse


	#region AuctionItem

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

	public class AuctionItem
	{
		public RspAuction rsp { get; set; }
	}

	public class PayloadAuction
	{
		public Auction auction { get; set; }
	}

	public class Playable
	{
		public int id { get; set; }
	}

	public class RspAuction
	{
		public List<PayloadAuction> payload { get; set; }
		public string stat { get; set; }
	}

	public class WarfaceItemAuction
	{
		public string category { get; set; }
		public string code { get; set; }
		public string offer_type { get; set; }
		public string soldier_class { get; set; }
		public string status { get; set; }
	}
	#endregion


	#region InventoryItem

	public class InventoryItem
	{
		public RspInventory rsp { get; set; }
	}

	public class PayloadInventory
	{
		public WarfaceItemInventory warface_item { get; set; }
	}

	public class RspInventory
	{
		public List<PayloadInventory> payload { get; set; }
		public string stat { get; set; }
	}

	public class WarfaceItemInventory : WarfaceItemAuction
	{
		public int durability { get; set; }
	}
	#endregion

	#region Wallet


	public class Commerce
	{
		public RspCommerce rsp { get; set; }
	}

	public class Credit
	{
		public int amount { get; set; }
		public string currency { get; set; }
	}

	public class PayloadCommerce
	{
		public Wallet wallet { get; set; }
	}

	public class ReservedCreditBalance
	{
		public int amount { get; set; }
		public string currency { get; set; }
	}

	public class RspCommerce
	{
		public List<PayloadCommerce> payload { get; set; }
		public string stat { get; set; }
	}

	public class Wallet
	{
		public List<Credit> credits { get; set; }
		public List<object> initial_credits { get; set; }
		public List<object> points { get; set; }
		public List<ReservedCreditBalance> reserved_credit_balances { get; set; }
		public int userid { get; set; }
	}
	#endregion


	#region Auth

	public class Auth
	{
		public AuthData data { get; set; }
		public object exception { get; set; }
		public int status { get; set; }
	}

	public class AuthData
	{
		public string affiliateid { get; set; }
		public string lang { get; set; }
		public string nickname { get; set; }
		public string presistentToken { get; set; }
		public string sessionToken { get; set; }
		public object steamid { get; set; }
	}
	#endregion
	
	#endregion


	public struct Info
	{
		public Auth auth;
		public Commerce commerce;
		public InventoryItem inventoryItems;
		public int kredits;
		public string nickname;
		public AuctionItem sellingItems;
	}
	
    class WFAuctionBot
    {
		private TextBox m_ConsoleFeed;

		#region AccountInfo
		private string login, password, token, nickname;
		private Auth m_Auth;
		private Commerce m_Commerce;
		private InventoryItem m_InventoryItems;
		private int m_Kredits;
		private AuctionItem m_SellingItems;
		private Dictionary<string, int> m_SellRules = new Dictionary<string, int>();
		private Dictionary<string, string> m_Weapons;
		private MyDB myDB;
		private bool m_Sold, m_NoSell;
		#endregion

		public WFAuctionBot(TextBox console, MyDB myDB, bool noSell = false) {
			m_Sold = false;
            m_ConsoleFeed = console;

			var ini = new IniFile();
			var keys = ini.ReadKeys("SellRules");
			foreach (var key in keys)
				m_SellRules[key] = Convert.ToInt32(ini.Read(key, "SellRules"));

			this.myDB = myDB;
			m_NoSell = noSell;
			m_Weapons = myDB.getWeapons();
        }

		#region Login
		public bool Login(string Login, string Password)
		{
			login = Login;
			password = Password;

			List<string> payload = new List<string>();
			payload.Add("email=" + HttpUtility.UrlEncode(login));
			payload.Add("password=" + HttpUtility.UrlEncode(password));

			string res = POST("https://launcher.warface.com/app/auth", payload);
			m_Auth = new JavaScriptSerializer().Deserialize<Auth>(res);
			if (m_Auth.status != 1)
			{;
				Log(string.Format("ERROR LOGGING INTO {0}:    CODE: {1}, EXCEPTION: {2}",
					login, m_Auth.status, m_Auth.exception.ToString()));
				return false;
			}
			token = m_Auth.data.sessionToken;
			nickname = m_Auth.data.nickname;
			Log("Nickname: " + nickname);
			Log("Token: " + token);
			
			myDB.addAccount(login, password, nickname);
			return true;
		}
		#endregion

		#region Kredits
		public void getKredits()
		{
			string req = string.Format("https://rest.api.gface.com/gface-rest/commerce/wallet/get/my.json?token={0}&gameid=101", token);
			string res = GET(req);
			m_Commerce = new JavaScriptSerializer().Deserialize<Commerce>(res);
			m_Kredits = m_Commerce.rsp.payload.First().wallet.credits.First().amount;
			Log("Kredits: " + m_Kredits);

			myDB.addAccount(login, password, nickname, m_Kredits);
		}

		#endregion

		#region Logout
		public void Logout()
		{
			Log(nickname + " logged out.");
			Log(new string('-', 114));
		} 
		#endregion

		#region SellingItems
		public void getSellingItems()
		{
			string req = string.Format("https://rest.api.gface.com/gface-rest/games/warface/auction/get.json?token={0}&playableid=102&usertype=seller", token);
			string res = GET(req);
			m_SellingItems = new JavaScriptSerializer().Deserialize<AuctionItem>(res);

			myDB.addSellingItems(m_SellingItems, login);

			if (m_SellingItems.rsp.payload.Count == 0)
				Log("Not selling any items.");
			else
			{
				Log("Selling Items:");
				foreach (var item in m_SellingItems.rsp.payload)
					Log(string.Format("{0,-32}: {1} bids, {2} Kredits",
						m_Weapons[item.auction.warface_item.code],
						item.auction.total_bids,
						item.auction.last_offer != 0 ? item.auction.last_offer : item.auction.initial_price)
						);
			}
		}
		
		#endregion

		#region InventoryItems
		public void getInventoryItems()
		{
			string req = string.Format("https://rest.api.gface.com/gface-rest/games/warface/auction/inventory/my.json?token={0}&playableid=102", token);
			string res = GET(req);
			m_InventoryItems = new JavaScriptSerializer().Deserialize<InventoryItem>(res);
			m_InventoryItems.rsp.payload.Sort((item1, item2) => item2.warface_item.durability - item1.warface_item.durability);

			myDB.removeInventoryItems(login);
			myDB.addInventoryItems(m_InventoryItems.rsp.payload, login);

			if (m_InventoryItems.rsp.payload.Count == 0)
				Log("No items to sell.");
			else
			{
				Log("Inventory Items:");
				foreach (var item in m_InventoryItems.rsp.payload)
					Log(string.Format(
						"{0,-32} {1}",
						m_Weapons[item.warface_item.code],
						item.warface_item.durability)
						);
			}
		}
		#endregion
		
		#region SellItems
		public void sellItems()
		{
			int soldItems = m_SellingItems.rsp.payload.Count;
			var sellableItems = m_InventoryItems.rsp.payload.Where(
				i => m_SellRules.ContainsKey(m_Weapons[i.warface_item.code])
				&& (i.warface_item.durability > 100 || i.warface_item.durability == 0)
				).ToList();
			sellableItems.Sort(
				(item1, item2) =>
				m_SellRules[m_Weapons[item2.warface_item.code]] - m_SellRules[m_Weapons[item1.warface_item.code]]
				);
			foreach (var item in sellableItems.Where(
					i => m_SellingItems.rsp.payload.Find(
					j => j.auction.warface_item.code == i.warface_item.code
					) == null)
					)
			{
				if (soldItems >= 3)
					break;
				List<string> payload = new List<string>(
					new string[]
					{
						"days=1",
						"initialprice=" + m_SellRules[m_Weapons[item.warface_item.code]].ToString(),
						"itemcode=" + item.warface_item.code,
						"playableid=102", "token=" + token
					}
					);
				string res = POST("https://rest.api.gface.com/gface-rest/games/warface/auction/create.json",
					payload);
				Log(string.Format("Selling {0,-32}: {1}",
					m_Weapons[item.warface_item.code],
					m_SellRules[m_Weapons[item.warface_item.code]]));
				++soldItems;
				m_Sold = true;
			}
		}
		#endregion

		public void updateAuctions()
		{
			var auctions = myDB.getAuctions().Where(x => x.Item2 == "active");
			int i = 1;
			foreach (var auction in auctions)
			{
				int id = auction.Item1;
				string req = string.Format("https://rest.api.gface.com/gface-rest/games/warface/auction/{0}.json?playableid=102", id);
				string res = GET(req);
				var updatedAuction = new JavaScriptSerializer().Deserialize<AuctionItem>(res);
				string email = myDB.getSellerEmail(updatedAuction);
				myDB.addSellingItems(updatedAuction, email);
				Log(string.Format("Updated {0}/{1} auctions.", i++, auctions.Count()));
			}
			Log("Finished updating auctions.");
		}

		public string CalculateMD5Hash(string input)
		{
			// step 1, calculate MD5 hash from input
			MD5 md5 = System.Security.Cryptography.MD5.Create();
			byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
			byte[] hash = md5.ComputeHash(inputBytes);

			// step 2, convert byte array to hex string
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < hash.Length; i++)
				sb.Append(hash[i].ToString("X2"));
			return sb.ToString();

		}

		public Info getInfo()
		{
			if (m_Sold)
			{
				getSellingItems();
				getInventoryItems();
			}
			Info myInfo = new Info();
			myInfo.nickname = nickname;
			myInfo.kredits = m_Kredits;
			myInfo.sellingItems = m_SellingItems;
			myInfo.inventoryItems = m_InventoryItems;
			myInfo.commerce = m_Commerce;
			myInfo.auth = m_Auth;
			return myInfo;
		}

		#region JSON
		private string GET(string url)
		{
			var request = (HttpWebRequest)WebRequest.Create(url);

			request.Method = "GET";
			request.Accept = "application/json";
			request.UserAgent = "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36";
			var response = (HttpWebResponse)request.GetResponse();
			var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
			response.Close();

			return responseString;
		}

		private string POST(string url, List<string> payload)
		{
			var request = (HttpWebRequest)WebRequest.Create(url);

			var postData = (payload.First());
			for (int i = 1; i < payload.Count; ++i)
				postData += string.Format("&{0}", (payload[i]));
			var data = Encoding.ASCII.GetBytes(postData);

			request.Method = "POST";
			request.ContentType = "application/x-www-form-urlencoded";
			request.ContentLength = data.Length;

			Stream stream = null;
			while (stream == null)
			{
				try
				{
					stream = request.GetRequestStream();
				}
				catch (Exception e)
				{
					Log(e.Message);
					continue;
				}
				stream.Write(data, 0, data.Length);
				stream.Close();
			}
			//using (var stream = request.GetRequestStream())
			//{
			//	stream.Write(data, 0, data.Length);
			//}

			var response = (HttpWebResponse)request.GetResponse();
			var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();

			//CookieContainer myContainer = new CookieContainer();
			//foreach (Cookie cookie in response.Cookies)
			//	myContainer.Add(cookie);

			response.Close();

			return responseString;
		}
		#endregion
		public void Log(string msg)
        {
			msg = string.Format("{0}{1}", msg, (msg.EndsWith("\n") ? "" : "\r\n"));
            m_ConsoleFeed.AppendText(msg);
			using (StreamWriter w = File.AppendText("Log.log"))
				w.Write("{0} {1} : {2}", DateTime.Now.ToLongTimeString(), DateTime.Now.ToLongDateString(), msg);
        }
    }
}
