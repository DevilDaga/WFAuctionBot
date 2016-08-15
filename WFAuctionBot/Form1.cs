﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web.Script.Serialization;
using System.Windows.Forms;

namespace WFAuctionBot
{
	public partial class formWFAB : Form
    {
        WFAuctionBot wfab;
		MyDB myDB;

        public formWFAB()
        {
            InitializeComponent();

			IniFile ini = new IniFile();
			string server = ini.Read("server", "MySQL");
			string database = ini.Read("database", "MySQL");
			string uid = ini.Read("uid", "MySQL");
			string pwd = ini.Read("password", "MySQL");
			myDB = new MyDB(server, pwd, uid, database);

			wfab = new WFAuctionBot(ConsoleFeed, myDB);
        }

        private void formWFAB_Load(object sender, EventArgs e)
        {
            var appName = Process.GetCurrentProcess().ProcessName + ".exe";
        }
		public struct Summary
		{
			public int totalKredits, totalSold, totalBid;
			public List<Info> accountsInfo;
		}

		private void buildSummary(List<Info> accountsInfo)
		{
			Summary summary = new Summary();
			summary.accountsInfo = accountsInfo;

			foreach (var account in accountsInfo)
			{
				summary.totalKredits += account.kredits;
				summary.totalSold += account.sellingItems.rsp.payload.Count;
				summary.totalBid += account.sellingItems.rsp.payload.Count(a => a.auction.total_bids != 0);
			}
			wfab.Log(string.Format("Total Kredits: {0}", summary.totalKredits));
			wfab.Log(string.Format("Total Selling: {0}", summary.totalSold));
			wfab.Log(string.Format("Total Bid: {0}", summary.totalBid));

			var json = new JavaScriptSerializer().Serialize(summary);
			string fileName = DateTime.Now.ToString("dd-MM-yyyy") + ".json";
			using (StreamWriter w = File.CreateText(fileName))
				w.Write(json);
			using (StreamWriter w = File.CreateText("latest.json"))
				w.Write(json);
		}

        private void StartStopBtn_Click(object sender, EventArgs e)
		{
			Stopwatch stopWatch = new Stopwatch();
			stopWatch.Start();
			List<Info> accountsInfo = new List<Info>();
			IniFile ini = new IniFile();

			Dictionary<string, string> accounts = new Dictionary<string, string>();
			var keys = ini.ReadKeys("Accounts");
			foreach (var key in keys)
				accounts[key] = ini.Read(key, "Accounts");
			foreach (var account in accounts)
			{
				if (!wfab.Login(account.Key, account.Value))
					continue;
				wfab.getKredits();
				wfab.getSellingItems();
				wfab.getInventoryItems();
				wfab.sellItems();
				accountsInfo.Add(wfab.getInfo());
				wfab.Logout();

				buildSummary(accountsInfo);
			}

			stopWatch.Stop();
			TimeSpan ts = stopWatch.Elapsed;
			string elapsedTime = String.Format("{0:00}:{1:00}.{2:00}",
			ts.Minutes, ts.Seconds, ts.Milliseconds / 10);
			wfab.Log("Executed in: " + elapsedTime);
		}

		private void btUpdate_Click(object sender, EventArgs e)
		{
			Stopwatch stopWatch = new Stopwatch();
			stopWatch.Start();
			var accounts = myDB.getAccounts();
			wfab = new WFAuctionBot(ConsoleFeed, myDB, true);
			List<Info> accountsInfo = new List<Info>();

			foreach (var account in accounts)
			{
				if (!wfab.Login(account.Item2, account.Item3))
					continue;
				wfab.getKredits();
				wfab.getSellingItems();
				wfab.getInventoryItems();
				wfab.sellItems();
				accountsInfo.Add(wfab.getInfo());
				wfab.Logout();

				buildSummary(accountsInfo);
			}

			stopWatch.Stop();
			TimeSpan ts = stopWatch.Elapsed;
			string elapsedTime = String.Format("{0:00}:{1:00}.{2:00}",
			ts.Minutes, ts.Seconds, ts.Milliseconds / 10);
			wfab.Log("Executed in: " + elapsedTime);
		}

		private void btUpdateAuctions_Click(object sender, EventArgs e)
		{
			wfab = new WFAuctionBot(ConsoleFeed, myDB, true);
			wfab.updateAuctions();
		}
	}
}
