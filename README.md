# WFAuctionBot

#### Basic useful feature list:

 * Sell inventory items of multiple accounts based on user defined rules.
 * Update info of past auctions to know the current/closed bid count and value.
 * Log all inventory items and auction history of multiple accounts.
 * MySQL views to quickly look at accounts info and auction history.

#### Requirements:
 * Visual Studio 2013 or higher.
 * Microsoft .NET 4.6 or higher.
 * MySQL and MySQL connector for Visual Studio.

#### Usage:
 * Compile and place [WFAuctionBot.ini](../master/WFAuctionBot/WFAuctionBot.ini) in the same folder as the binary.
 * Create a MySQL Database and execute [wfab_structure.sql](../master/WFAuctionBot/wfab_structure.sql)
 * Edit [WFAuctionBot.ini](../master/WFAuctionBot/WFAuctionBot.ini) to add your accounts and selling rules and MySQL connection info.
