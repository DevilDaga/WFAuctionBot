/*
Navicat MySQL Data Transfer

Source Server         : wamp
Source Server Version : 50626
Source Host           : localhost:3306
Source Database       : wfab

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2016-08-15 17:49:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `kredits` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auctions
-- ----------------------------
DROP TABLE IF EXISTS `auctions`;
CREATE TABLE `auctions` (
  `id` int(11) unsigned NOT NULL,
  `item_id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `initial_price` int(11) NOT NULL,
  `last_offer` int(11) NOT NULL,
  `total_bids` int(11) unsigned zerofill DEFAULT NULL,
  `sold` binary(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_item_auction` (`item_id`),
  CONSTRAINT `fk_item_auction` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `durability` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_item_inventory` (`item_id`),
  KEY `fk_account_inventory` (`account_id`),
  CONSTRAINT `fk_account_inventory` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `fk_item_inventory` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `offer_type_id` int(11) DEFAULT NULL,
  `soldier_class_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `code` (`code_id`),
  KEY `fk_soldier_class_item` (`soldier_class_id`),
  KEY `fk_offer_type_items` (`offer_type_id`),
  KEY `fk_category_item` (`category_id`),
  CONSTRAINT `fk_category_item` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_code_item` FOREIGN KEY (`code_id`) REFERENCES `weapons` (`id`),
  CONSTRAINT `fk_offer_type_items` FOREIGN KEY (`offer_type_id`) REFERENCES `offer_type` (`id`),
  CONSTRAINT `fk_soldier_class_item` FOREIGN KEY (`soldier_class_id`) REFERENCES `soldier_class` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for offer_type
-- ----------------------------
DROP TABLE IF EXISTS `offer_type`;
CREATE TABLE `offer_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for selling
-- ----------------------------
DROP TABLE IF EXISTS `selling`;
CREATE TABLE `selling` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `auction_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_account_selling` (`account_id`),
  KEY `fk_auction_selling` (`auction_id`),
  CONSTRAINT `fk_account_selling` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `fk_auction_selling` FOREIGN KEY (`auction_id`) REFERENCES `auctions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for soldier_class
-- ----------------------------
DROP TABLE IF EXISTS `soldier_class`;
CREATE TABLE `soldier_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for weapons
-- ----------------------------
DROP TABLE IF EXISTS `weapons`;
CREATE TABLE `weapons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=511 DEFAULT CHARSET=utf8;

-- ----------------------------
-- View structure for all auctions
-- ----------------------------
DROP VIEW IF EXISTS `all auctions`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all auctions` auctions` AS select `accounts`.`username` AS `Nickname`,`weapons`.`name` AS `Weapon`,concat(timestampdiff(HOUR,now(),`auctions`.`end`),'h ',(timestampdiff(MINUTE,now(),`auctions`.`end`) % 60),'m ',(timestampdiff(SECOND,now(),`auctions`.`end`) % 60),'s ') AS `Time Left`,`auctions`.`total_bids` AS `Total Bids`,`auctions`.`last_offer` AS `Last Offer`,`auctions`.`initial_price` AS `Initial Price`,`auctions`.`sold` AS `Sold`,`auctions`.`status` AS `Status` from ((((`selling` join `accounts` on((`selling`.`account_id` = `accounts`.`id`))) join `auctions` on((`selling`.`auction_id` = `auctions`.`id`))) join `items` on((`auctions`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) order by `auctions`.`end` ;

-- ----------------------------
-- View structure for all weapons
-- ----------------------------
DROP VIEW IF EXISTS `all weapons`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all weapons` weapons` AS select `accounts`.`username` AS `Nickname`,`weapons`.`name` AS `Weapons`,if((`inventory`.`durability` = 0),'∞',if((`inventory`.`durability` = -(1)),'0%',concat(`inventory`.`durability`,'%'))) AS `Durability`,`accounts`.`kredits` AS `Kredits` from (((`inventory` join `accounts` on((`inventory`.`account_id` = `accounts`.`id`))) join `items` on((`inventory`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) order by `accounts`.`username` ;

-- ----------------------------
-- View structure for ongoing auctions
-- ----------------------------
DROP VIEW IF EXISTS `ongoing auctions`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ongoing auctions` auctions` AS select `accounts`.`username` AS `Nickname`,`weapons`.`name` AS `Weapon`,concat(timestampdiff(HOUR,now(),`auctions`.`end`),'h ',(timestampdiff(MINUTE,now(),`auctions`.`end`) % 60),'m ',(timestampdiff(SECOND,now(),`auctions`.`end`) % 60),'s ') AS `Time Left`,`auctions`.`total_bids` AS `Total Bids`,`auctions`.`last_offer` AS `Last Offer`,`auctions`.`initial_price` AS `Initial Price`,`auctions`.`sold` AS `Sold`,`auctions`.`status` AS `Status` from ((((`selling` join `accounts` on((`selling`.`account_id` = `accounts`.`id`))) join `auctions` on((`selling`.`auction_id` = `auctions`.`id`))) join `items` on((`auctions`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) where (`auctions`.`end` >= now()) order by `auctions`.`end` ;

-- ----------------------------
-- View structure for selling accounts
-- ----------------------------
DROP VIEW IF EXISTS `selling accounts`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `selling accounts` accounts` AS select `accounts`.`username` AS `Username`,`accounts`.`kredits` AS `Kredits`,count(`auctions`.`item_id`) AS `Total Auctioned`,count(`auctions`.`sold`) AS `Total Sold`,count(`auctions`.`total_bids`) AS `Total Bids`,sum(`auctions`.`last_offer`) AS `Total Earned` from ((`selling` join `accounts` on((`selling`.`account_id` = `accounts`.`id`))) join `auctions` on((`selling`.`auction_id` = `auctions`.`id`))) where (`auctions`.`sold` <> 0) group by `accounts`.`username`,`accounts`.`kredits` order by `Total Sold` desc ;
