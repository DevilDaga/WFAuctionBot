namespace WFAuctionBot
{
    partial class formWFAB
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
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(formWFAB));
			this.btSell = new System.Windows.Forms.Button();
			this.ConsoleFeed = new System.Windows.Forms.TextBox();
			this.btUpdate = new System.Windows.Forms.Button();
			this.btUpdateAuctions = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// btSell
			// 
			this.btSell.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.btSell.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(177)))), ((int)(((byte)(177)))), ((int)(((byte)(177)))));
			this.btSell.FlatAppearance.BorderSize = 0;
			this.btSell.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.btSell.Font = new System.Drawing.Font("Consolas", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
			this.btSell.Location = new System.Drawing.Point(903, 13);
			this.btSell.Margin = new System.Windows.Forms.Padding(4);
			this.btSell.Name = "btSell";
			this.btSell.Size = new System.Drawing.Size(191, 114);
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
			this.ConsoleFeed.Location = new System.Drawing.Point(3, 164);
			this.ConsoleFeed.Margin = new System.Windows.Forms.Padding(0, 4, 0, 2);
			this.ConsoleFeed.Multiline = true;
			this.ConsoleFeed.Name = "ConsoleFeed";
			this.ConsoleFeed.ReadOnly = true;
			this.ConsoleFeed.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.ConsoleFeed.Size = new System.Drawing.Size(1106, 435);
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
			this.btUpdate.Size = new System.Drawing.Size(191, 114);
			this.btUpdate.TabIndex = 3;
			this.btUpdate.Text = "Update Info";
			this.btUpdate.UseVisualStyleBackColor = false;
			this.btUpdate.Click += new System.EventHandler(this.btUpdate_Click);
			// 
			// btUpdateAuctions
			// 
			this.btUpdateAuctions.Anchor = System.Windows.Forms.AnchorStyles.Top;
			this.btUpdateAuctions.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(177)))), ((int)(((byte)(177)))), ((int)(((byte)(177)))));
			this.btUpdateAuctions.FlatAppearance.BorderSize = 0;
			this.btUpdateAuctions.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
			this.btUpdateAuctions.Font = new System.Drawing.Font("Consolas", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
			this.btUpdateAuctions.Location = new System.Drawing.Point(456, 13);
			this.btUpdateAuctions.Margin = new System.Windows.Forms.Padding(4);
			this.btUpdateAuctions.Name = "btUpdateAuctions";
			this.btUpdateAuctions.Size = new System.Drawing.Size(191, 114);
			this.btUpdateAuctions.TabIndex = 4;
			this.btUpdateAuctions.Text = "Update Auctions";
			this.btUpdateAuctions.UseVisualStyleBackColor = false;
			this.btUpdateAuctions.Click += new System.EventHandler(this.btUpdateAuctions_Click);
			// 
			// formWFAB
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(35)))), ((int)(((byte)(35)))), ((int)(((byte)(35)))));
			this.ClientSize = new System.Drawing.Size(1107, 610);
			this.Controls.Add(this.btUpdateAuctions);
			this.Controls.Add(this.btUpdate);
			this.Controls.Add(this.ConsoleFeed);
			this.Controls.Add(this.btSell);
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.Margin = new System.Windows.Forms.Padding(4);
			this.Name = "formWFAB";
			this.Text = "WF Auction Bot";
			this.Load += new System.EventHandler(this.formWFAB_Load);
			this.ResumeLayout(false);
			this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.TextBox ConsoleFeed;
		private System.Windows.Forms.Button btSell;
		private System.Windows.Forms.Button btUpdate;
		private System.Windows.Forms.Button btUpdateAuctions;
	}
}

