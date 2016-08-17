namespace WFAuctionBot
{
    partial class FormWFAB
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormWFAB));
			this.btSell = new System.Windows.Forms.Button();
			this.ConsoleFeed = new System.Windows.Forms.TextBox();
			this.btUpdate = new System.Windows.Forms.Button();
			this.btUpdateMyAuctions = new System.Windows.Forms.Button();
			this.btUpdateAllAuctions = new System.Windows.Forms.Button();
			this.pgbarCommon = new System.Windows.Forms.ProgressBar();
			this.SuspendLayout();
			// 
			// btSell
			// 
			this.btSell.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.btSell.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(177)))), ((int)(((byte)(177)))), ((int)(((byte)(177)))));
			this.btSell.FlatAppearance.BorderSize = 0;
			this.btSell.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.btSell.Font = new System.Drawing.Font("Consolas", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
			this.btSell.Location = new System.Drawing.Point(914, 13);
			this.btSell.Margin = new System.Windows.Forms.Padding(4);
			this.btSell.Name = "btSell";
			this.btSell.Size = new System.Drawing.Size(180, 120);
			this.btSell.TabIndex = 1;
			this.btSell.Text = "Sell";
			this.btSell.UseVisualStyleBackColor = false;
			this.btSell.Click += new System.EventHandler(this.StartStopBtn_Click);
			// 
			// ConsoleFeed
			// 
			this.ConsoleFeed.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.ConsoleFeed.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(65)))), ((int)(((byte)(65)))), ((int)(((byte)(65)))));
			this.ConsoleFeed.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.ConsoleFeed.Font = new System.Drawing.Font("Consolas", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
			this.ConsoleFeed.ForeColor = System.Drawing.SystemColors.Window;
			this.ConsoleFeed.Location = new System.Drawing.Point(3, 173);
			this.ConsoleFeed.Margin = new System.Windows.Forms.Padding(0, 4, 0, 2);
			this.ConsoleFeed.Multiline = true;
			this.ConsoleFeed.Name = "ConsoleFeed";
			this.ConsoleFeed.ReadOnly = true;
			this.ConsoleFeed.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.ConsoleFeed.Size = new System.Drawing.Size(1106, 426);
			this.ConsoleFeed.TabIndex = 2;
			// 
			// btUpdate
			// 
			this.btUpdate.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(177)))), ((int)(((byte)(177)))), ((int)(((byte)(177)))));
			this.btUpdate.FlatAppearance.BorderSize = 0;
			this.btUpdate.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.btUpdate.Font = new System.Drawing.Font("Consolas", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
			this.btUpdate.Location = new System.Drawing.Point(13, 13);
			this.btUpdate.Margin = new System.Windows.Forms.Padding(4);
			this.btUpdate.Name = "btUpdate";
			this.btUpdate.Size = new System.Drawing.Size(180, 120);
			this.btUpdate.TabIndex = 3;
			this.btUpdate.Text = "Update Info";
			this.btUpdate.UseVisualStyleBackColor = false;
			this.btUpdate.Click += new System.EventHandler(this.btUpdate_Click);
			// 
			// btUpdateMyAuctions
			// 
			this.btUpdateMyAuctions.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(177)))), ((int)(((byte)(177)))), ((int)(((byte)(177)))));
			this.btUpdateMyAuctions.FlatAppearance.BorderSize = 0;
			this.btUpdateMyAuctions.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.btUpdateMyAuctions.Font = new System.Drawing.Font("Consolas", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
			this.btUpdateMyAuctions.Location = new System.Drawing.Point(201, 13);
			this.btUpdateMyAuctions.Margin = new System.Windows.Forms.Padding(4);
			this.btUpdateMyAuctions.Name = "btUpdateMyAuctions";
			this.btUpdateMyAuctions.Size = new System.Drawing.Size(180, 120);
			this.btUpdateMyAuctions.TabIndex = 4;
			this.btUpdateMyAuctions.Text = "Update My Auctions";
			this.btUpdateMyAuctions.UseVisualStyleBackColor = false;
			this.btUpdateMyAuctions.Click += new System.EventHandler(this.btUpdateMyAuctions_Click);
			// 
			// btUpdateAllAuctions
			// 
			this.btUpdateAllAuctions.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(177)))), ((int)(((byte)(177)))), ((int)(((byte)(177)))));
			this.btUpdateAllAuctions.FlatAppearance.BorderSize = 0;
			this.btUpdateAllAuctions.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.btUpdateAllAuctions.Font = new System.Drawing.Font("Consolas", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
			this.btUpdateAllAuctions.Location = new System.Drawing.Point(389, 13);
			this.btUpdateAllAuctions.Margin = new System.Windows.Forms.Padding(4);
			this.btUpdateAllAuctions.Name = "btUpdateAllAuctions";
			this.btUpdateAllAuctions.Size = new System.Drawing.Size(180, 120);
			this.btUpdateAllAuctions.TabIndex = 5;
			this.btUpdateAllAuctions.Text = "Update All Auctions";
			this.btUpdateAllAuctions.UseVisualStyleBackColor = false;
			this.btUpdateAllAuctions.Click += new System.EventHandler(this.btUpdateAllAuctions_Click);
			// 
			// pgbarCommon
			// 
			this.pgbarCommon.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
			this.pgbarCommon.Location = new System.Drawing.Point(13, 140);
			this.pgbarCommon.MarqueeAnimationSpeed = 1000;
			this.pgbarCommon.Name = "pgbarCommon";
			this.pgbarCommon.Size = new System.Drawing.Size(1081, 23);
			this.pgbarCommon.Step = 1;
			this.pgbarCommon.TabIndex = 6;
			// 
			// FormWFAB
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(35)))), ((int)(((byte)(35)))), ((int)(((byte)(35)))));
			this.ClientSize = new System.Drawing.Size(1107, 610);
			this.Controls.Add(this.pgbarCommon);
			this.Controls.Add(this.btUpdateAllAuctions);
			this.Controls.Add(this.btUpdateMyAuctions);
			this.Controls.Add(this.btUpdate);
			this.Controls.Add(this.ConsoleFeed);
			this.Controls.Add(this.btSell);
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.Margin = new System.Windows.Forms.Padding(4);
			this.Name = "FormWFAB";
			this.Text = "WF Auction Bot";
			this.Load += new System.EventHandler(this.formWFAB_Load);
			this.ResumeLayout(false);
			this.PerformLayout();

        }

        #endregion
		private System.Windows.Forms.Button btSell;
		private System.Windows.Forms.Button btUpdate;
		private System.Windows.Forms.Button btUpdateMyAuctions;
		private System.Windows.Forms.Button btUpdateAllAuctions;
		public System.Windows.Forms.TextBox ConsoleFeed;
		private System.Windows.Forms.ProgressBar pgbarCommon;
	}
}

