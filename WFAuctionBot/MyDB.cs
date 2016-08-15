using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace WFAuctionBot
{
	public class MyDB
	{
		public string server, password, uid, database;
		private MySqlConnection connection;
		private string connection_string;
		public MyDB(string server, string password, string uid, string database)
		{
			this.server = server;
			this.password = password;
			this.uid = uid;
			this.database = database;
			connection_string = "SERVER=" + server + ";" + "DATABASE=" +
			database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

			connection = new MySqlConnection(connection_string);
		}

		private MySqlCommand getCmd(string cmd = "")
		{
			connection.Close();
			connection = new MySqlConnection(connection_string);
			connection.Open();
			var ret = connection.CreateCommand();
			ret.CommandText = cmd;
			return ret;
			/*
			var conn = new MySqlConnection(connection_string);
			conn.Open();
			var ret = conn.CreateCommand();
			ret.CommandText = cmd;
			return ret;
			*/
		}

		private async Task<MySqlCommand> getCmdAsync(string cmd = "")
		{
			var conn = new MySqlConnection(connection_string);
			await conn.OpenAsync();
			var ret = conn.CreateCommand();
			ret.CommandText = cmd;
			return ret;
		}

		long insert(string table, string cols_csv, params object[] values)
		{
			string cmdText = "INSERT INTO " + table + "(" + cols_csv + ") VALUES(";
			cols_csv = cols_csv.Replace(" ", "");
			cols_csv = "@" + cols_csv.Replace(",", ",@");
			cmdText += cols_csv + ")";
			var p = cols_csv.Split(',');
			var cmd = getCmd(cmdText);
			for (int i = 0; i != values.Length; ++i)
				cmd.Parameters.AddWithValue(p[i], values[i]);
			cmd.ExecuteNonQuery();
			return cmd.LastInsertedId;
		}

		long update(string table, string where_clause, string cols_csv, params object[] values)
		{
			string cmdText = "UPDATE " + table + " SET";
			cols_csv = cols_csv.Replace(" ", "");
			var p = cols_csv.Split(',');
			foreach (var param in p)
				cmdText += " " + param + " = @" + param + ",";
			cmdText = cmdText.Remove(cmdText.Length - 1) + " WHERE " + where_clause;
			var cmd = getCmd(cmdText);
			for (int i = 0; i != values.Length; ++i)
				cmd.Parameters.AddWithValue("@" + p[i], values[i]);
			cmd.ExecuteNonQuery();
			return cmd.LastInsertedId;
		}

		MySqlDataReader select(string table, string cols = "*", string where = "", string order = "")
		{
			string cmdText = string.Format("SELECT {0} from {1}", cols, table);
			if (where != "")
				cmdText = string.Format("{0} WHERE {1}", cmdText, where);
			if (order != "")
				cmdText = string.Format("{0} ORDER BY {1}", cmdText, order);
			var cmd = getCmd(cmdText);
			var reader = cmd.ExecuteReader();
			return reader;
		}

		public long addAccount(string email, string password, string username, int kredits = 0)
		{
			var cmd = getCmd("SELECT COUNT(*) FROM accounts WHERE `email`='" + email + "'");
			long result = (long)cmd.ExecuteScalar();
			if (result == 0)
				return insert("accounts", "email,password,username,kredits", email, password, username, kredits);
			else
				return update("accounts", "email='" + email + "'", "username,password,kredits", username, password, kredits);
		}

		public void removeInventoryItems(string email)
		{
			var reader = select("accounts", "id", "email='" + email + "'");
			if (reader.Read())
			{
				int account_id = reader.GetInt32(0);
				update("inventory", "account_id='" + account_id + "'", "durability", -1);
			}
		}

		public void addInventoryItems(List<PayloadInventory> items, string email)
		{
			var reader = select("accounts", "id", "email='" + email + "'");
			int account_id = 0;
			if (reader.Read())
				account_id = reader.GetInt32(0);
			else
				return;
			foreach (var item in items)
			{
				int item_id = addItem(item.warface_item);
				reader = select("inventory", "*", "`item_id`='" + item_id + "' AND `account_id`='"
					+ account_id + "'");
				if (reader.Read())
				{
					int id = reader.GetInt32(0);
					update("inventory", "id='" + id + "'", "durability", item.warface_item.durability);
				}
				else
				{
					insert("inventory", "account_id,item_id,durability", account_id, item_id,
						item.warface_item.durability);
				}
			}
		}

		public void addSellingItems(AuctionItem auctions, string email)
		{
			List<int> auction_ids = new List<int>();
			foreach (var item in auctions.rsp.payload)
				auction_ids.Add(addAuction(item));

			foreach (int auction_id in auction_ids)
			{
				var reader = select("selling", "*", "`auction_id`='" + auction_id + "'");
				if (!reader.Read())
				{
					reader = select("accounts", "id", "`email`='" + email + "'");
					if (reader.Read())
					{
						int account_id = reader.GetInt32(0);
						insert("selling", "account_id,auction_id", account_id, auction_id);
					}
				}
			}
		}

		public Dictionary<string, string> getWeapons()
		{
			Dictionary<string, string> weapons = new Dictionary<string, string>();
			var reader = select("weapons");
			while (reader.Read())
			{
				string code = reader.GetString(1);
				string name = reader.GetString(2);
				weapons[code] = name;
			}
			return weapons;
		}

		private int addAuction(PayloadAuction item)
		{
			int item_id = addItem(item.auction.warface_item);
			var reader = select("auctions", "*", "`id`='" + item.auction.id + "'");
			if (reader.Read())
			{
				update("auctions", "id='" + item.auction.id + "'",
					"item_id,status,start,end,initial_price,last_offer,total_bids,sold",
					item_id, item.auction.status, item.auction.start, item.auction.end,
					item.auction.initial_price, item.auction.last_offer, item.auction.total_bids,
					item.auction.sold);
			}
			else
			{
				insert("auctions",
					"id,item_id,status,start,end,initial_price,last_offer,total_bids,sold",
					item.auction.id, item_id, item.auction.status, item.auction.start, item.auction.end,
					item.auction.initial_price, item.auction.last_offer, item.auction.total_bids,
					item.auction.sold);
			}
			return item.auction.id;
		}

		private int addCategory(string name)
		{
			var reader = select("category", "*", "`name`='" + name + "'");
			if (reader.Read())
				return reader.GetInt32(0);
			else
				return (int)insert("category", "name", name);
		}

		private int addItem(WarfaceItemAuction item)
		{
			int code_id = addWeapon(item.code);
			int soldier_class_id = addSoldierClass(item.soldier_class);
			int category_id = addCategory(item.category);
			int offer_type_id = addOfferType(item.offer_type);
			var reader = select("items", "*", "`code_id`='" + code_id + "'");
			if (reader.Read())
			{
				update("items", "code_id='" + code_id + "'",
					"soldier_class_id,category_id,offer_type_id",
					soldier_class_id, category_id, offer_type_id);
				reader = select("items", "*", "`code_id`='" + code_id + "'");
				if (reader.Read())
					return reader.GetInt32(0);
				else
					return 0;
			}
			else
			{
				return (int)insert("items", "code_id,soldier_class_id,category_id,offer_type_id",
					code_id, soldier_class_id, category_id, offer_type_id);
			}
		}

		private int addOfferType(string name)
		{
			var reader = select("offer_type", "*", "`name`='" + name + "'");
			if (reader.Read())
				return reader.GetInt32(0);
			else
				return (int)insert("offer_type", "name", name);
		}

		private int addSoldierClass(string name)
		{
			var reader = select("soldier_class", "*", "`name`='" + name + "'");
			if (reader.Read())
				return reader.GetInt32(0);
			else
				return (int)insert("soldier_class", "name", name);
		}

		private int addWeapon(string code, string name = "Unknown")
		{
			var reader = select("weapons", "*", "`code`='" + code + "'");
			if (reader.Read())
				return reader.GetInt32(0);
			else
				return (int)insert("weapons", "code,name", code, name);
		}

		public List<Tuple<int, string, string, string, int>> getAccounts()
		{
			List<Tuple<int, string, string, string, int>> accounts = new List<Tuple<int, string, string, string, int>>();
			var reader = select("accounts");
			while (reader.Read())
			{
				int id = reader.GetInt32(0);
				string email = reader.GetString(1);
				string password = reader.GetString(2);
				string nickname = reader.GetString(3);
				int kredits = reader.GetInt32(4);
				accounts.Add(new Tuple<int, string, string, string, int>(id, email, password, nickname, kredits));
			}

			return accounts;
		}

		public List<Tuple<int, string>> getAuctions()
		{
			List<Tuple<int, string>> auctions = new List<Tuple<int, string>>();

			var reader = select("auctions", "*", "", "`end` DESC");
			while (reader.Read())
			{
				int id = reader.GetInt32(0);
				string status = reader.GetString("status");
				auctions.Add(new Tuple<int, string>(id, status));
			}

			return auctions;
		}

		public Auction getAuction(int auction_id)
		{
			Auction auction = new Auction();

			var reader = select("auctions", "*", "id=" + auction_id);
			if (reader.Read())
			{
				auction.id = auction_id;
				auction.initial_price = reader.GetInt32("initial_price");
				auction.last_offer = reader.GetInt32("last_offer");
				auction.status = reader.GetString("status");
				auction.total_bids = reader.GetInt32("total_bids");
				auction.start = reader.GetDateTime("start");
				auction.end = reader.GetDateTime("end");
				auction.sold = reader.GetBoolean("sold");
				auction.warface_item = null;
			}

			return auction;
		}

		public string getSellerEmail(AuctionItem item)
		{
			var cmd = getCmd("SELECT accounts.email FROM selling INNER JOIN auctions ON selling.auction_id = auctions.id INNER JOIN accounts ON selling.account_id = accounts.id WHERE auctions.id = " + item.rsp.payload[0].auction.id);
			var reader = cmd.ExecuteReader();
			if (reader.Read())
				return reader.GetString(0);
			return null;
		}
	}
}
