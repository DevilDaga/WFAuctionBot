-- phpMyAdmin SQL Dump
-- version 4.6.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 17, 2016 at 01:31 AM
-- Server version: 5.6.26-log
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wfab`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `kredits` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `all accounts`
-- (See below for the actual view)
--
CREATE TABLE `all accounts` (
`Nickname` varchar(255)
,`Kredits` int(11)
,`Total Auctioned` bigint(21)
,`Total Sold` bigint(21)
,`Total Earned` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `all auctions`
-- (See below for the actual view)
--
CREATE TABLE `all auctions` (
`Auction ID` int(11) unsigned
,`Nickname` varchar(255)
,`Weapon` varchar(255)
,`Duration` varchar(26)
,`Time Left` varchar(93)
,`Total Bids` int(11) unsigned zerofill
,`Last Offer` int(11)
,`Initial Price` int(11)
,`Sold` bit(1)
,`Status` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `all weapons`
-- (See below for the actual view)
--
CREATE TABLE `all weapons` (
`Nickname` varchar(255)
,`Weapon` varchar(255)
,`Durability` varchar(12)
,`Kredits` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `auctions`
--

CREATE TABLE `auctions` (
  `id` int(11) UNSIGNED NOT NULL,
  `item_id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `initial_price` int(11) NOT NULL,
  `last_offer` int(11) NOT NULL,
  `total_bids` int(11) UNSIGNED ZEROFILL DEFAULT NULL,
  `sold` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `auctions everyone`
-- (See below for the actual view)
--
CREATE TABLE `auctions everyone` (
`Auction ID` int(11) unsigned
,`Start Date` datetime
,`End Date` datetime
,`Duration` varchar(26)
,`Time Left` varchar(93)
,`Weapon` varchar(255)
,`Total Bids` int(11) unsigned zerofill
,`Last Offer` int(11)
,`Initial Price` int(11)
,`Sold` bit(1)
,`Status` varchar(255)
,`Category` varchar(255)
,`Offer Type` varchar(255)
,`Soldier Class` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `auctions with bids`
-- (See below for the actual view)
--
CREATE TABLE `auctions with bids` (
`Nickname` varchar(255)
,`Weapon` varchar(255)
,`Time Left` varchar(69)
,`Total Bids` int(11) unsigned zerofill
,`Last Offer` int(11)
,`Initial Price` int(11)
,`Sold` bit(1)
,`Status` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `auctions_all`
--

CREATE TABLE `auctions_all` (
  `id` int(11) UNSIGNED NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `initial_price` int(11) DEFAULT NULL,
  `last_offer` int(11) DEFAULT NULL,
  `total_bids` int(11) UNSIGNED ZEROFILL DEFAULT NULL,
  `sold` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auction_status`
--

CREATE TABLE `auction_status` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `auction_status`
--

TRUNCATE TABLE `auction_status`;
--
-- Dumping data for table `auction_status`
--

INSERT INTO `auction_status` (`id`, `name`) VALUES
(1, 'active'),
(2, 'closing'),
(3, 'closed'),
(4, 'canceled');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `category`
--

TRUNCATE TABLE `category`;
--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'assault_rifle'),
(2, 'shotgun'),
(3, 'sniper_rifle'),
(4, 'pistol'),
(5, 'knife'),
(6, 'machine_gun'),
(7, 'small_machine_gun');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `durability` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `inventory summary`
-- (See below for the actual view)
--
CREATE TABLE `inventory summary` (
`Weapon` varchar(255)
,`Durability` varbinary(34)
);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `code_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `offer_type_id` int(11) DEFAULT NULL,
  `soldier_class_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `items`
--

TRUNCATE TABLE `items`;
--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `code_id`, `category_id`, `offer_type_id`, `soldier_class_id`) VALUES
(1, 500, 1, 1, 1),
(2, 365, 2, 1, 2),
(3, 363, 3, 1, 3),
(4, 501, 1, 1, 4),
(5, 502, 1, 1, 3),
(6, 503, 1, 1, 2),
(7, 54, 4, 1, 5),
(8, 504, 5, 1, 5),
(9, 28, 6, 1, 4),
(10, 505, 5, 1, 5),
(11, 136, 3, 1, 3),
(12, 458, 2, 1, 2),
(13, 306, 4, 1, 5),
(14, 407, 3, 1, 3),
(15, 378, 3, 1, 3),
(16, 506, 5, 2, 5),
(17, 364, 3, 2, 3),
(18, 20, 1, 1, 4),
(19, 346, 7, 1, 1),
(20, 130, 3, 1, 3),
(21, 507, 5, 1, 5),
(22, 336, 3, 1, 3),
(23, 508, 5, 1, 5),
(24, 509, 5, 1, 5),
(25, 15, 1, 1, 4),
(26, 119, 7, 1, 1),
(27, 510, 5, 1, 5),
(28, 60, 4, 1, 5),
(29, 89, 2, 1, 2),
(30, 108, 7, 1, 1),
(31, 76, 2, 1, 2),
(32, 328, 2, 1, 2),
(33, 110, 7, 1, 1),
(34, 30, 6, 1, 4),
(35, 11, 1, 1, 4),
(36, 345, 2, 1, 2),
(37, 135, 3, 1, 3),
(38, 436, 7, 1, 1),
(39, 342, 3, 2, 3),
(40, 366, 2, 2, 2),
(41, 377, 4, 1, 5),
(42, 511, 4, 1, 5),
(43, 224, 2, 1, 2),
(44, 228, 7, 1, 1),
(45, 337, 1, 2, 4),
(46, 339, 6, 2, 4),
(47, 128, 3, 1, 3),
(48, 73, 2, 1, 2),
(49, 348, 2, 2, 2),
(50, 340, 1, 2, 4),
(51, 225, 3, 1, 3),
(52, 512, 5, 1, 5),
(53, 104, 7, 1, 1),
(54, 400, 4, 2, 5),
(55, 408, 3, 2, 3),
(56, 360, 7, 1, 1),
(57, 361, 4, 1, 5),
(58, 75, 2, 1, 2),
(59, 10, 1, 1, 4),
(60, 218, 1, 1, 4),
(61, 347, 7, 2, 1),
(62, 359, 2, 1, 2),
(63, 307, 2, 1, 2),
(64, 111, 7, 1, 1),
(65, 513, 5, 1, 5),
(66, 357, 1, 1, 4),
(67, 405, 3, 2, 3),
(68, 358, 3, 1, 3),
(69, 19, 1, 1, 4),
(70, 125, 3, 1, 3),
(71, 223, 4, 1, 5),
(72, 434, 4, 1, 5),
(73, 433, 2, 1, 2),
(74, 451, 3, 1, 3),
(75, 431, 7, 1, 1),
(76, 514, 5, 1, 5),
(77, 437, 7, 2, 1),
(78, 454, 2, 1, 2),
(79, 452, 1, 1, 4),
(80, 455, 3, 1, 3),
(81, 453, 7, 1, 1),
(82, 391, 3, 1, 3),
(83, 389, 2, 1, 2),
(84, 388, 4, 1, 5),
(85, 387, 1, 1, 4),
(86, 390, 7, 1, 1),
(87, 133, 3, 1, 3),
(88, 515, 7, 2, 1),
(89, 516, 2, 2, 2),
(90, 517, 5, 1, 5),
(91, 103, 7, 1, 1),
(92, 518, 5, 1, 5),
(93, 519, 5, 1, 5),
(94, 520, 1, 2, 4),
(95, 521, 5, 1, 5),
(96, 249, 3, 1, 3),
(97, 62, 4, 1, 5),
(98, 51, 4, 1, 5),
(99, 522, 3, 1, 3),
(100, 459, 2, 2, 2),
(101, 523, 1, 1, 4),
(102, 524, 2, 1, 2),
(103, 525, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `offer_type`
--

CREATE TABLE `offer_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `offer_type`
--

TRUNCATE TABLE `offer_type`;
--
-- Dumping data for table `offer_type`
--

INSERT INTO `offer_type` (`id`, `name`) VALUES
(1, 'permanent'),
(2, 'regular');

-- --------------------------------------------------------

--
-- Stand-in structure for view `ongoing auctions`
-- (See below for the actual view)
--
CREATE TABLE `ongoing auctions` (
`Auction ID` int(11) unsigned
,`Nickname` varchar(255)
,`Weapon` varchar(255)
,`Time Left` varchar(69)
,`Total Bids` int(11) unsigned zerofill
,`Last Offer` int(11)
,`Initial Price` int(11)
,`Sold` bit(1)
,`Status` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `selling`
--

CREATE TABLE `selling` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `auction_id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `selling accounts`
-- (See below for the actual view)
--
CREATE TABLE `selling accounts` (
`Username` varchar(255)
,`Kredits` int(11)
,`Total Auctioned` bigint(21)
,`Total Sold` bigint(21)
,`Total Bids` bigint(21)
,`Total Earned` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `soldier_class`
--

CREATE TABLE `soldier_class` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `soldier_class`
--

TRUNCATE TABLE `soldier_class`;
--
-- Dumping data for table `soldier_class`
--

INSERT INTO `soldier_class` (`id`, `name`) VALUES
(1, 'engineer'),
(2, 'medic'),
(3, 'sniper'),
(4, 'rifleman'),
(5, 'shared');

-- --------------------------------------------------------

--
-- Stand-in structure for view `sold weapons`
-- (See below for the actual view)
--
CREATE TABLE `sold weapons` (
`Weapon` varchar(255)
,`Total Auctioned` bigint(21)
,`Total Sold` decimal(23,0)
,`Total earned` decimal(32,0)
,`Average Value` decimal(36,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `weapons`
--

CREATE TABLE `weapons` (
  `id` int(11) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `weapons`
--

TRUNCATE TABLE `weapons`;
--
-- Dumping data for table `weapons`
--

INSERT INTO `weapons` (`id`, `code`, `name`) VALUES
(1, 'ar01_shop', 'Karkom'),
(2, 'ar02_shop', 'R4A1'),
(3, 'ar03_shop', 'A3-210'),
(4, 'ar05_shop', 'AC7'),
(5, 'ar06_shop', 'ZX84K'),
(6, 'ar07_shop', 'M95AR'),
(7, 'ar08_shop', 'AY 551'),
(8, 'ar09_shop', 'GU2'),
(9, 'ar10_shop', 'F2000'),
(10, 'ar11_shop', 'EXAR-H'),
(11, 'ar12_shop', 'R16A4'),
(12, 'ar13_shop', 'F1000'),
(13, 'ar14_shop', 'Assault rifle 14'),
(14, 'ar15_shop', 'T27 AS'),
(15, 'ar16_shop', 'T27'),
(16, 'ar17_shop', 'ST-AR'),
(17, 'ar18_shop', 'KF-86'),
(18, 'ar19_shop', 'CCR'),
(19, 'ar20_shop', 'CCR'),
(20, 'ar22_shop', 'FY-47'),
(21, 'ar23_shop', 'AR-GAR'),
(22, 'ar02_shop_c', 'Assault rifle 02 China'),
(23, 'mg01_shop', 'LMG240'),
(24, 'mg03_shop', 'GU3'),
(25, 'mg04_shop', 'FY LMG'),
(26, 'mg05_shop', 'AC7 MG'),
(27, 'mg06_shop', 'ZX84 MG'),
(28, 'mg07_shop', 'R249 Para'),
(29, 'mg08_shop', 'A3 H-bar'),
(30, 'mg09_shop', 'LMG3'),
(31, 'mg10_shop', 'Bumblebee'),
(32, 'mg11_shop', 'Machinegun 11'),
(33, 'mg12_shop', 'R60E4'),
(34, 'mg13_shop', 'Machinegun 13'),
(35, 'mg14_shop', 'Machinegun 14'),
(36, 'mg15_shop', 'Machinegun 15'),
(37, 'mg16_shop', 'Machinegun 16'),
(38, 'mg17_shop', 'Machinegun 17'),
(39, 'mg18_shop', 'LMG240'),
(40, 'mg19_shop', 'LMG4'),
(41, 'mg20_shop', 'TBD'),
(42, 'mg21_shop', 'R16A2 LMG'),
(43, 'pt02_shop', 'Python'),
(44, 'pt03_shop', 'ZX84 USP'),
(45, 'pt04_shop', 'M900'),
(46, 'pt05_shop', 'High Power Pistol'),
(47, 'pt06_shop', 'M9A1'),
(48, 'pt07_shop', 'MD9'),
(49, 'pt08_shop', 'GU5'),
(50, 'pt09_shop', 'Pistol 09'),
(51, 'pt10_shop', 'STCC'),
(52, 'pt11_shop', 'Bull 4510'),
(53, 'pt13_shop', 'Pistol 13'),
(54, 'pt14_shop', 'AY 226'),
(55, 'pt15_shop', 'M93R'),
(56, 'pt16_shop', 'R1911D1'),
(57, 'pt17_shop', 'Hi-Power Pistol'),
(58, 'pt18_shop', 'Eagle Eye'),
(59, 'pt19_shop', 'MD9'),
(60, 'pt21_shop', 'S18G'),
(61, 'pt22_shop', 'P-57'),
(62, 'pt23_shop', 'Q-92'),
(63, 'pt24_shop', 'M1895'),
(64, 'pt25_shop', 'Abada 266mm'),
(65, 'pt26_shop', 'HEX Autorevolver'),
(66, 'pt01_camo01_shop', 'Eagle Eye Camo'),
(67, 'pt21_camo01_shop', 'S18G Platinum'),
(68, 'pt66_shop', 'Gun-Glove!'),
(69, 'shg01_shop', 'Richmond 770'),
(70, 'shg02_shop', 'Piledriver'),
(71, 'shg03_shop', 'PEG'),
(72, 'shg04_shop', 'VIPER'),
(73, 'shg05_shop', 'US-12'),
(74, 'shg06_shop', 'PHS-12'),
(75, 'shg07_shop', 'PEG Bullpup'),
(76, 'shg08_shop', 'MSG 500 Custom'),
(77, 'shg09_shop', 'Richmond 870 CB'),
(78, 'shg10_shop', 'MC 255 12'),
(79, 'shg11_shop', 'Striker'),
(80, 'shg12_shop', 'Kite Pump'),
(81, 'shg12_clr01_shop', 'Kite Pump Navy Blue'),
(82, 'shg13_shop', 'PEG-KT'),
(83, 'shg14_shop', 'Shotgun 14'),
(84, 'shg15_shop', 'Richmond Nova tactical'),
(85, 'shg16_shop', 'Shotgun 16'),
(86, 'shg17_shop', 'PEG-KT'),
(87, 'shg18_shop', 'PHS-12'),
(88, 'shg20_shop', 'CQB combat shotgun'),
(89, 'shg21_shop', 'FAS-12'),
(90, 'shg22_shop', 'Richmond M4 Super 90'),
(91, 'shg26_shop', 'RST-14'),
(92, 'shg27_shop', 'SHG M1217'),
(93, 'shg30_shop', 'Boas Semi-Auto shotgun'),
(94, 'shg01_shop_c', 'Shotgun 01 China'),
(95, 'shg03_shop_c', 'Shotgun 03 China'),
(96, 'smg01_shop', 'MM28'),
(97, 'smg02_shop', 'Micro Oren'),
(98, 'smg04_shop', 'ZX84 SMG'),
(99, 'smg05_shop', 'M99AS'),
(100, 'smg06_shop', 'FY-9'),
(101, 'smg07_shop', 'ZX84C'),
(102, 'smg09_shop', 'PDW 19'),
(103, 'smg08_shop', 'AC7 SMG'),
(104, 'smg10_shop', 'Karkom SMG'),
(105, 'smg11_shop', 'A3 9mm XS'),
(106, 'smg12_shop', 'GU1'),
(107, 'smg13_shop', 'R4 CQB'),
(108, 'smg14_shop', 'GU7'),
(109, 'smg15_shop', 'MP .38'),
(110, 'smg16_shop', 'Metasoma 83'),
(111, 'smg17_shop', 'ZX84 UMP'),
(112, 'smg18_shop', 'Smg-19 Wisent'),
(113, 'smg19_shop', 'Sub-machinegun 19'),
(114, 'smg20_shop', 'Sub-machinegun 20'),
(115, 'smg21_shop', 'Vec. 5'),
(116, 'smg22_shop', 'GU1'),
(117, 'smg23_shop', 'AY 552'),
(118, 'smg24_shop', 'MT-19'),
(119, 'smg25_shop', 'CCR CQB'),
(120, 'smg30_shop', 'Ch 9mm'),
(121, 'smg01_shop_c', 'Sub-machinegun 01 China'),
(122, 'smg13_camo01_shop', 'R4 CQB Platinum'),
(123, 'sr01_shop', 'Garota'),
(124, 'sr03_shop', 'Everest'),
(125, 'sr04_shop', 'BT50'),
(126, 'sr05_shop', 'AC7 SNR'),
(127, 'sr06_shop', 'ZX84 SNR'),
(128, 'sr07_shop', 'M917-SR'),
(129, 'sr08_shop', 'M217'),
(130, 'sr09_shop', 'Miller AP6'),
(131, 'sr10_shop', 'Sniper rifle 10'),
(132, 'sr11_shop', 'TBD'),
(133, 'sr12_shop', 'Karkom SNR'),
(134, 'sr12_clr01_shop', 'Karkom SNR Navy Blue'),
(135, 'sr13_shop', 'RK14 EBR'),
(136, 'sr14_shop', 'TWM'),
(137, 'sr15_shop', 'R107'),
(138, 'sr16_shop', 'R98B'),
(139, 'sr17_shop', 'BNP SNR-1'),
(140, 'sr18_shop', 'Sniper rifle 18'),
(141, 'sr19_shop', 'Sniper rifle 19'),
(142, 'sr20_shop', 'BT50'),
(143, 'sr21_shop', 'Sniper rifle 21'),
(144, 'sr22_shop', 'AY 550'),
(145, 'sr23_shop', 'R16 SPR Custom'),
(146, 'sr24_shop', 'Sniper rifle 24'),
(147, 'sr25_shop', 'CCR SPR'),
(148, 'sr26_shop', 'Otto OT 3000'),
(149, 'sr27_shop', 'Sniper rifle 27'),
(150, 'sr03_shop_c', 'Sniper rifle 03 China'),
(151, 'kn02_shop', 'Ultra Marine'),
(152, 'kn03_shop', 'Black Hawk'),
(153, 'kn04_shop', 'Army Knife'),
(154, 'kn05_shop', 'Sapper shovel'),
(155, 'kn06_shop', 'Utility Knife'),
(156, 'kn07_shop', 'Kukri Machete'),
(157, 'kn08_shop', 'Neck Knife'),
(158, 'kn09_shop', 'kn09'),
(159, 'kn10_shop', 'Survival Tanto Knife'),
(160, 'kn13_shop', 'Katana'),
(161, 'kn14_shop', 'ICE-AXE'),
(162, 'kn15_shop', 'Cleaver'),
(163, 'kn15_hlw01_shop', 'Halloween Cleaver'),
(164, 'kn16_shop', 'Tactical Axe'),
(165, 'kn16_gold01_shop', 'Gold Tactical Axe'),
(166, 'ak02_shop', '“Plate” Armor Kit'),
(167, 'ak03_shop', '“Composite” Armor Kit'),
(168, 'ap02_shop', '“Platoon” Ammo Pack'),
(169, 'ap03_shop', '“Scout” Ammo Pack'),
(170, 'cm02_shop', 'Anti-Personnel Mine'),
(171, 'cm03_shop', 'Crywar Claymore'),
(172, 'fg02_shop', 'Crywar Grenade'),
(173, 'fl02_shop', 'Advanced Flashbang'),
(174, 'fl03_shop', 'Crywar Flash'),
(175, 'fg01_hlw01_shop', 'Halloween Grenade'),
(176, 'mk02_shop', '“Paramedic” Medkit'),
(177, 'mk03_shop', '“Adrenalin” Medkit'),
(178, 'sg01_md_shop', 'Green Smoke Grenade'),
(179, 'ar20_xmas_shop', 'Christmas CCR'),
(180, 'mg01_xmas_shop', 'Christmas LMG240'),
(181, 'pt01_xmas_shop', 'Christmas Eagle Eye'),
(182, 'pt07_xmas_shop', 'Christmas MD9'),
(183, 'shg06_xmas_shop', 'Christmas PHS-12'),
(184, 'shg11_xmas_shop', 'Christmas Striker'),
(185, 'smg03_xmas_shop', 'Christmas  Vec. 5'),
(186, 'smg12_xmas_shop', 'Christmas GU1'),
(187, 'sr03_xmas_shop', 'Christmas Everest'),
(188, 'sr04_xmas_shop', 'Christmas BT50'),
(189, 'kn02_xmas_shop', 'Icicle Knife'),
(190, 'kn03_xmas_shop', 'Candy Knife'),
(191, 'ak01_xmas_shop', 'Christmas Armor Kit'),
(192, 'ap01_xmas_shop', 'Christmas Ammo Pack'),
(193, 'mk01_xmas_shop', 'Christmas Medkit'),
(194, 'fg01_xmas_shop', 'Christmas Grenade'),
(195, 'ar20_cny01_shop', 'NY CCR'),
(196, 'pt01_cny01_shop', 'NY Eagle Eye'),
(197, 'shg11_cny01_shop', 'NY Striker'),
(198, 'smg12_cny01_shop', 'NY GU1'),
(199, 'sr04_cny01_shop', 'NY BT50'),
(200, 'kn02_cny01_shop', 'NY Ultra Marine'),
(201, 'fg01_cny01_shop', 'NY Grenade'),
(202, 'smg41_ww2_shop', 'MP 717'),
(203, 'pt41_ww2_shop', 'Bellum'),
(204, 'kn42_ww2_shop', 'Hammer'),
(205, 'fg05_zong_shop', 'Fireworks Grenade'),
(206, 'kn43_vdv_shop', 'Classic Soviet Knife'),
(207, 'ar11_crown_shop', 'EXAR-H Crown'),
(208, 'smg10_crown_shop', 'Karkom SMG Crown'),
(209, 'shg07_crown_shop', 'PEG Bullpup Crown'),
(210, 'pt01_crown_shop', 'Eagle Eye Crown'),
(211, 'pt07_crown_shop', 'MD9 Crown'),
(212, 'shg06_crown_shop', 'PHS-12 Crown'),
(213, 'ar20_crown_shop', 'CCR Crown'),
(214, 'smg03_crown_shop', 'Vec. 5 Crown'),
(215, 'smg12_crown_shop', 'GU1 Crown'),
(216, 'sr04_crown_shop', 'BT50 Crown'),
(217, 'mg01_crown_shop', 'LMG240 Crown'),
(218, 'ar02_camo02_shop', 'R4A1 Winter Camo'),
(219, 'ar07_camo02_shop', 'M9551 Winter Camo'),
(220, 'smg11_camo02_shop', 'A3 9mm XS Winter Camo'),
(221, 'shg10_camo02_shop', 'MC 255 12 Winter Camo'),
(222, 'smg04_camo02_shop', 'ZX84 SMG Winter Camo'),
(223, 'pt03_camo02_shop', 'ZX84 USP Winter Camo'),
(224, 'shg03_camo02_shop', 'PEG Winter Camo'),
(225, 'sr14_camo02_shop', 'TWM Winter Camo'),
(226, 'sr08_camo02_shop', 'M217 Winter Camo'),
(227, 'mg08_camo02_shop', 'A3 H-bar Winter Camo'),
(228, 'smg09_camo02_shop', 'PDW 19 Winter Camo'),
(229, 'shg15_camo02_shop', 'Richmond Nova tactical Winter Camo'),
(230, 'sr05_camo02_shop', 'AC7 SNR Winter Camo'),
(231, 'pt06_camo02_shop', 'M9A1 Winter Camo'),
(232, 'kn05_camo02_shop', 'Sapper shovel Winter Camo'),
(233, 'ar04_set01_shop', 'FY-103 Basic'),
(234, 'mg04_set01_shop', 'FY LMG Basic'),
(235, 'smg03_set01_shop', 'Vec. 5 Basic'),
(236, 'smg06_set01_shop', 'FY-9 Basic'),
(237, 'shg04_set01_shop', 'VIPER Basic'),
(238, 'shg11_set01_shop', 'Striker Basic'),
(239, 'sr01_set01_shop', 'Garota Basic'),
(240, 'sr14_set01_shop', 'TWM Basic'),
(241, 'ar02_set01_shop', 'R4A1 Basic'),
(242, 'ar04_camo04_shop', 'FY-103 City'),
(243, 'shg12_camo04_shop', 'Kite Pump City'),
(244, 'smg03_camo04_shop', 'Vec. 5 City'),
(245, 'sr22_camo04_shop', 'AY 550 City'),
(246, 'ar06_camo03_shop', 'ZX84K Jungle'),
(247, 'shg11_camo03_shop', 'Striker Jungle'),
(248, 'smg01_camo03_shop', 'MM28 Jungle'),
(249, 'sr02_camo03_shop', 'SVK Jungle'),
(250, 'ar04_camo05_shop', 'FY-103 Shiny metal set'),
(251, 'smg06_camo05_shop', 'FY-9 Shiny metal set'),
(252, 'sr02_camo05_shop', 'SVK Shiny metal set'),
(253, 'shg03_camo05_shop', 'PEG Shiny metal set'),
(254, 'pt10_camo05_shop', 'STCC Shiny metal set'),
(255, 'ar02_camo07_shop', 'R4A1 U.S. set'),
(256, 'pt07_camo07_shop', 'MD9 U.S. set'),
(257, 'shg01_camo07_shop', 'Richmond 770 U.S. set'),
(258, 'smg13_camo07_shop', 'R4 CQB U.S. set'),
(259, 'sr23_camo07_shop', 'R16 SPR Custom U.S. set'),
(260, 'ar16_camo06_shop', 'T27 Desert Camo'),
(261, 'pt23_camo06_shop', 'Q-92 Desert Camo'),
(262, 'shg12_camo06_shop', 'Kite Pump Desert Camo'),
(263, 'smg30_camo06_shop', 'Ch 9mm Desert Camo'),
(264, 'shg28_shop', 'PHS-15'),
(265, 'shg31_shop', 'Johnson 1957'),
(266, 'ar41_shop', 'AR 88'),
(267, 'ar01_steam01_shop', 'Karkom NeoN Punk'),
(268, 'shg09_steam01_shop', 'Richmond 870 CB NeoN Punk'),
(269, 'smg11_steam01_shop', 'A3 9mm XS NeoN Punk'),
(270, 'sr03_steam01_shop', 'Everest NeoN Punk'),
(271, 'gl01_shop', 'R32A1'),
(272, 'gl01_zsd01_shop', 'HMGL32A7 Oblivion'),
(273, 'rg01_shop', 'FCG-R3 K1'),
(274, 'rg01_zsd01_shop', 'FCG-R3'),
(275, 'shg21_zsd01_shop', 'FAS-12 Spec Ops Mk01'),
(276, 'kn03_zsd01_shop', 'Black Hawk Spec Ops Mk01'),
(277, 'mg04_zsd01_shop', 'The FY LMG Spec Ops Mk01'),
(278, 'mg09_zsd01_shop', 'LMG3 Spec Ops Mk01'),
(279, 'arl01_zsd01_shop', 'ZSD-11'),
(280, 'shg05_zsd01_shop', 'US-12 Special'),
(281, 'sr01_zsd01_shop', 'Garota Special'),
(282, 'kn13_zsd01_shop', 'Special Forces Katana'),
(283, 'shg04_zsd01_shop', 'VIPER Special'),
(284, 'shg02_zsd01_shop', 'Piledriver Special'),
(285, 'mg08_zsd01_shop', 'A3 H-bar Special'),
(286, 'mg06_zsd01_shop', 'ZX84 MG Special'),
(287, 'shg07_zsd01_shop', 'PEG Bullpup Mk.60 Mod'),
(288, 'kn13_zsd02_shop', 'Katana Mk.60 Mod'),
(289, 'mg12_zsd01_shop', 'R60E4 Mk.60 Mod'),
(290, 'smg30_zsd01_shop', 'Ch 9mm Mk.60 Mod'),
(291, 'sr13_zsd01_shop', 'RK14 EBR Mk.60 Mod'),
(292, 'sr13_crown02_shop', 'Rk14 EBR Elite Crown'),
(293, 'smg17_crown02_shop', 'ZX84 UMP Elite Crown'),
(294, 'shg08_crown02_shop', 'MSG 500 Custom Elite Crown'),
(295, 'pt21_crown02_shop', 'S18G Elite Crown'),
(296, 'ar16_crown02_shop', 'T27 Elite Crown'),
(297, 'sr04_crown02_shop', 'BT50 Elite Crown'),
(298, 'smg03_crown02_shop', 'Vec. 5 Elite Crown'),
(299, 'shg06_crown02_shop', 'PHS-12 Elite Crown'),
(300, 'shg07_crown02_shop', 'PEG Bullpup Elite Crown'),
(301, 'ar11_crown02_shop', 'EXAR-H Elite Crown'),
(302, 'ar20_crown02_shop', 'CCR Elite Crown'),
(303, 'pt01_crown02_shop', 'Eagle Eye Elite Crown'),
(304, 'pt07_crown02_shop', 'MD9 Elite Crown'),
(305, 'mg01_crown02_shop', 'LMG240 Elite Crown'),
(306, 'pt27_shop', 'Shark-443'),
(307, 'shg32_shop', 'Accuracy SEVEN'),
(308, 'ar10_set02_shop', 'F2000 Black Dragon'),
(309, 'shg02_set02_shop', 'Piledriver Black Dragon'),
(310, 'sr08_set02_shop', 'M217 Black Dragon'),
(311, 'pt26_set02_shop', 'HEX Autorevolver Black Dragon'),
(312, 'smg13_set02_shop', 'R4 CQB Black Dragon'),
(313, 'ar10_set03_shop', 'F2000 Jade Dragon'),
(314, 'shg02_set03_shop', 'Piledriver Jade Dragon'),
(315, 'sr08_set03_shop', 'M217 Jade Dragon'),
(316, 'pt26_set03_shop', 'HEX Autorevolver Jade Dragon'),
(317, 'smg13_set03_shop', 'R4 CQB Jade Dragon'),
(318, 'ar10_set04_shop', 'F2000 Scarlet Dragon'),
(319, 'shg02_set04_shop', 'Piledriver Scarlet Dragon'),
(320, 'sr08_set04_shop', 'M217 Scarlet Dragon'),
(321, 'pt26_set04_shop', 'HEX Autorevolver Scarlet Dragon'),
(322, 'smg13_set04_shop', 'R4 CQB Scarlet Dragon'),
(323, 'ar02_eua01_shop', 'R4A1 Anniversary'),
(324, 'shg09_eua01_shop', 'Richmond 870 CB Anniversary'),
(325, 'smg17_eua01_shop', 'ZX84 UMP Anniversary'),
(326, 'sr14_eua01_shop', 'TWM Anniversary'),
(327, 'pt07_eua01_shop', 'MD9 Anniversary'),
(328, 'shg33_shop', 'Richmond 870 RIS'),
(329, 'cm05_shop', 'Christmas Gift Box'),
(330, 'pt28_shop', 'Christmas Firecracker'),
(331, 'smg26_shop', 'MX4 Storm'),
(332, 'fg04_shop', 'Defensive grenade'),
(333, 'fg05_shop', 'Offensive grenade'),
(334, 'pt29_fld01_shop', 'Aquatic Assassinator'),
(335, 'kn44_fld01_shop', 'Digger of Doom'),
(336, 'sr32_shop', 'RBA SR58 SPR'),
(337, 'ar22_gold01_shop', 'Gold FY-47'),
(338, 'smg10_gold01_shop', 'Gold Karkom SMG'),
(339, 'mg07_gold01_shop', 'Gold R249 Para'),
(340, 'ar12_gold01_shop', 'Gold R16A4'),
(341, 'shg07_gold01_shop', 'Gold PEG Bullpup'),
(342, 'sr14_gold01_shop', 'Gold TWM'),
(343, 'sr04_gold01_shop', 'Gold BT50'),
(344, 'ar11_gold01_shop', 'Gold EXAR-H'),
(345, 'shg35_shop', 'Fararm S.A.T. 8 Pro'),
(346, 'smg31_shop', 'EXAR-L PDW'),
(347, 'smg31_gold01_shop', 'Gold EXAR-L PDW'),
(348, 'shg35_gold01_shop', 'Gold Fararm S.A.T. 8 Pro'),
(349, 'ar06_hlw01_shop', 'Halloween ZX84K'),
(350, 'kn04_hlw01_shop', 'Halloween Army Knife'),
(351, 'pt10_hlw01_shop', 'Halloween STCC'),
(352, 'shg06_hlw01_shop', 'Halloween PHS-12'),
(353, 'smg07_hlw01_shop', 'Halloween ZX84C'),
(354, 'sr06_hlw01_shop', 'Halloween ZX84 SNR'),
(355, 'mg06_hlw01_shop', 'Halloween ZX84 MG'),
(356, 'shg36_shop', 'Anatolia RK-102'),
(357, 'ar16_lava01_shop', 'Earth Shaker T27'),
(358, 'sr09_lava01_shop', 'Earth Shaker Miller AP6'),
(359, 'shg32_lava01_shop', 'Earth Shaker Accuracy SEVEN'),
(360, 'smg25_lava01_shop', 'Earth Shaker CCR CQB'),
(361, 'pt21_lava01_shop', 'Earth Shaker S18G'),
(362, 'kn07_lava01_shop', 'Earth Shaker Kukri Machete'),
(363, 'sr33_shop', 'Richmond S22 SAS'),
(364, 'sr33_gold01_shop', 'Gold Richmond S22 SAS'),
(365, 'shg37_shop', 'Fararm ATF 12'),
(366, 'shg37_gold01_shop', 'Gold Fararm ATF 12'),
(367, 'smg32_shop', 'SN-5G Sarosk'),
(368, 'pt12_shop', 'P199'),
(369, 'ar11_rua01_shop', 'FN-SCAR-H RU Anniversary'),
(370, 'sr15_rua01_shop', 'Barrett M107 RU Anniversary'),
(371, 'smg08_rua01_shop', 'XM8 Compact RU Anniversary'),
(372, 'shg22_rua01_shop', 'Benelli M4 Super 90 RU Anniversary'),
(373, 'ar11_bra02_shop', 'FN-SCAR-H BRA Anniversary'),
(374, 'sr15_bra02_shop', 'Barrett M107 BRA Anniversary'),
(375, 'smg08_bra02_shop', 'XM8 Compact BRA Anniversary'),
(376, 'shg22_bra02_shop', 'Benelli M4 Super 90 BRA Anniversary'),
(377, 'pt30_pink01_shop', 'Pink Micro Eagle Eye'),
(378, 'sr31_shop', 'TWM X308'),
(379, 'sr41_shop', 'MM1891/30'),
(380, 'sr30_camo06_shop', 'Q-88 Desert Camo'),
(381, 'kn42_viet_shop', 'Wooden Hammer'),
(382, 'ar09_kra01_shop', 'GU2 Korea Anniversary'),
(383, 'pt08_kra01_shop', 'GU5 Korea Anniversary'),
(384, 'shg05_kra01_shop', 'US-12 Korea Anniversary'),
(385, 'smg14_kra01_shop', 'GU7 Korea Anniversary'),
(386, 'sr14_kra01_shop', 'TWM Korea Anniversary'),
(387, 'ar01_bra01_shop', 'Karkom Brazilian World Cup'),
(388, 'pt01_bra01_shop', 'Eagle Eye Brazilian World Cup'),
(389, 'shg21_bra01_shop', 'FAS-12 Brazilian World Cup'),
(390, 'smg12_bra01_shop', 'GU1 Brazilian World Cup'),
(391, 'sr14_bra01_shop', 'TWM Brazilian World Cup'),
(392, 'sr30_shop', 'Q-88'),
(393, 'ar20_cny_shop', 'NY CCR'),
(394, 'pt01_cny_shop', 'NY Eagle Eye'),
(395, 'shg11_cny_shop', 'NY Striker'),
(396, 'smg12_cny_shop', 'NY GU1'),
(397, 'sr04_cny_shop', 'NY BT50'),
(398, 'kn02_cny_shop', 'NY Ultra Marine'),
(399, 'fg01_cny_shop', 'New Year\'s Grenade'),
(400, 'pt01_gold01_shop', 'Gold Eagle Eye'),
(401, 'ar11_gc01_shop', 'Gamescom EXAR-H'),
(402, 'shg22_gc01_shop', 'Gamescom M4 Super 90'),
(403, 'smg08_gc01_shop', 'Gamescom AC7 SMG'),
(404, 'sr15_gc01_shop', 'Gamescom R107'),
(405, 'sr31_gold01_shop', 'Gold TWM X308'),
(406, 'pt31_shop', 'Otto W77'),
(407, 'sr34_shop', 'Sae Scout'),
(408, 'sr34_gold01_shop', 'Gold Sae Scout'),
(409, 'ar23_pink02_shop', 'Sweet Vengeance Skin for AR-GAR'),
(410, 'ar23_set05_shop', 'Flor de Muerto Skin for AR-GAR'),
(411, 'ar23_camo07_shop', 'Wilderness Skin for AR-GAR'),
(412, 'shg26_pink02_shop', 'Sweet Vengeance Skin for RST-14'),
(413, 'shg26_set05_shop', 'Flor de Muerto Skin for RST-14'),
(414, 'shg26_camo07_shop', 'Wilderness Skin for RST-14'),
(415, 'smg26_pink02_shop', 'Sweet Vengeance Skin for MX4 Storm'),
(416, 'smg26_set05_shop', 'Flor de Muerto Skin for MX4 Storm'),
(417, 'smg26_camo07_shop', 'Wilderness Skin for MX4 Storm'),
(418, 'sr16_pink02_shop', 'Sweet Vengeance Skin for R98B'),
(419, 'sr16_set05_shop', 'Flor de Muerto Skin for R98B'),
(420, 'sr16_camo07_shop', 'Wilderness Skin for R98B'),
(421, 'pt16_pink02_shop', 'Sweet Vengeance Skin for R1911D1'),
(422, 'pt16_set05_shop', 'Flor de Muerto Skin for R1911D1'),
(423, 'pt16_camo07_shop', 'Wilderness Skin for R1911D1'),
(424, 'ar12_oc01_shop', 'R16A4 Hexagon'),
(425, 'shg32_oc01_shop', 'Accuracy SEVEN Hexagon'),
(426, 'smg31_oc01_shop', 'EXAR-L PDW Hexagon'),
(427, 'sr31_oc01_shop', 'TWM X308 Hexagon'),
(428, 'pt14_oc01_shop', 'AY 226 Hexagon'),
(429, 'kn16_oc01_shop', 'Tactical Axe Hexagon'),
(430, 'ar20_lava01_shop', 'Earth Shaker CCR'),
(431, 'smg31_lava01_shop', 'Earth Shaker EXAR-L PDW'),
(432, 'sr31_lava01_shop&#10;', 'Earth Shaker TWM X308'),
(433, 'shg08_lava01_shop', 'Earth Shaker MSG 500 Custom'),
(434, 'pt14_lava01_shop', 'Earth Shaker AY 226'),
(435, 'kn13_lava01_shop', 'Earth Shaker Katana'),
(436, 'smg33_shop', 'CCR Honey Badger'),
(437, 'smg33_gold01_shop', 'Gold CCR Honey Badger'),
(438, 'ar04_afro01_shop', 'Anubis Skin for the FY-103'),
(439, 'sr03_afro01_shop', 'Anubis Skin for the Everest'),
(440, 'shg04_afro01_shop', 'Anubis Skin for the Viper'),
(441, 'smg18_afro01_shop', 'Anubis Skin for Smg-19 Wisent'),
(442, 'pt02_afro01_shop', 'Anubis Skin for the Python'),
(443, 'ar04_rua02_shop', 'FY-103 RU Anniversary'),
(444, 'smg03_rua02_shop', 'Vec 5 RU Anniversary'),
(445, 'shg04_rua02_shop', 'VIPER RU Anniversary'),
(446, 'sr17_rua02_shop', 'BNP SNR-1 RU Anniversary'),
(447, 'ar04_bra03_shop', 'FY-103 BRA Anniversary'),
(448, 'smg03_bra03_shop', 'Vec 5 BRA Anniversary'),
(449, 'shg04_bra03_shop', 'VIPER BRA Anniversary'),
(450, 'sr17_bra03_shop', 'BNP SNR-1 BTA Anniversary'),
(451, 'sr31_lava01_shop', 'Earth Shaker TWM X308'),
(452, 'ar12_ec01_shop', 'R16A4 Winger'),
(453, 'smg33_ec01_shop', 'CCR Honey Badger Defender'),
(454, 'shg37_ec01_shop', 'Faram ATF 12 Keeper'),
(455, 'sr33_ec01_shop', 'Richmond S22 Striker'),
(456, 'kn17_shop', 'Jagdkommando'),
(457, 'ar24_shop', 'Fazil UE3'),
(458, 'shg38_shop', 'Fararm LTR6'),
(459, 'shg38_gold01_shop', 'Gold Fararm LTR6 Prestige'),
(460, 'ar02_camo07skin_shop', 'R4A1 U.S. set'),
(461, 'ar04_camo04skin_shop', 'FY-103 City'),
(462, 'ar04_camo05skin_shop', 'FY-103 Shiny metal set'),
(463, 'ar10_set02skin_shop', 'F2000 Black Dragon'),
(464, 'ar10_set03skin_shop', 'F2000 Jade Dragon'),
(465, 'ar10_set04skin_shop', 'F2000 Scarlet Dragon'),
(466, 'shg02_set02skin_shop', 'Piledriver Black Dragon'),
(467, 'shg02_set03skin_shop', 'Piledriver Jade Dragon'),
(468, 'shg02_set04skin_shop', 'Piledriver Scarlet Dragon'),
(469, 'smg13_set02skin_shop', 'R4 CQB Black Dragon'),
(470, 'smg13_set03skin_shop', 'R4 CQB Jade Dragon'),
(471, 'smg13_set04skin_shop', 'R4 CQB Scarlet Dragon'),
(472, 'sr08_set02skin_shop', 'M217 Black Dragon'),
(473, 'sr08_set03skin_shop', 'M217 Jade Dragon'),
(474, 'sr08_set04skin_shop', 'M217 Scarlet Dragon'),
(475, 'pt26_set02skin_shop', 'HEX Autorevolver Black Dragon'),
(476, 'pt26_set03skin_shop', 'HEX Autorevolver Jade Dragon'),
(477, 'pt26_set04skin_shop', 'HEX Autorevolver Scarlet Dragon'),
(478, 'shg12_camo04skin_shop', 'Kite Pump City'),
(479, 'smg03_camo04skin_shop', 'Vec. 5 City'),
(480, 'sr22_camo04skin_shop', 'AY 550 City'),
(481, 'shg01_camo07skin_shop', 'Richmond 770 U.S. set'),
(482, 'smg13_camo07skin_shop', 'R4 CQB U.S. set'),
(483, 'sr23_camo07skin_shop', 'R16 SPR Custom U.S. set'),
(484, 'smg06_camo05skin_shop', 'FY-9 Shiny metal set'),
(485, 'sr02_camo05skin_shop', 'SVK Shiny metal set'),
(486, 'shg03_camo05skin_shop', 'PEG Shiny metal set'),
(487, 'pt10_camo05skin_shop', 'STCC Shiny metal set'),
(488, 'smg13_camo01skin_shop', 'R4 CQB Platinum'),
(489, 'pt21_camo01skin_shop', 'S18G Platinum'),
(490, 'kn13_zsd01skin_shop', 'Special Forces Katana'),
(491, 'kn13_zsd02skin_shop', 'Katana Mk.60 Mod'),
(492, 'pt07_camo07skin_shop', 'MD9 U.S. set'),
(493, 'ar24_bra04_shop', 'Fazil UE3 Jogos 2016'),
(494, 'shg13_bra04_shop', 'PEG-KT Jogos 2016'),
(495, 'sr08_bra04_shop', 'M217 Jogos 2016'),
(496, 'smg32_bra04_shop', 'SN-5G Sarosk Jogos 2016'),
(497, 'ar25_shop', 'Dewnfield R65E4'),
(498, 'sr35_shop', 'S60B3'),
(499, 'ar25_gold01_shop', 'Gold Dewnfield R65E4'),
(500, 'engineer_helmet_lava_01', 'Earth Shaker Engineer Helmet'),
(501, 'soldier_helmet_lava_01', 'Earth Shaker Rifleman Helmet'),
(502, 'sniper_helmet_lava_01', 'Earth Shaker Sniper Helmet'),
(503, 'medic_helmet_lava_01', 'Earth Shaker Medic Helmet'),
(504, 'kn16', 'Tactical Axe'),
(505, 'kn07', 'Kukri Machete'),
(506, 'kn16_gold01', 'Gold Tactical Axe'),
(507, 'kn17', 'Jagdkommando'),
(508, 'kn03', 'Black Hawk'),
(509, 'kn14', 'ICE-AXE'),
(510, 'kn13', 'Katana'),
(511, 'pt01_default', 'Eagle Eye'),
(512, 'kn05_camo02', 'Sapper shovel Winter Camo'),
(513, 'kn07_lava01', 'Earth Shaker Kukri Machete'),
(514, 'kn13_lava01', 'Earth Shaker Katana'),
(515, 'ak01_xmas', 'Christmas Armor Kit'),
(516, 'mk01_xmas', 'Christmas Medkit'),
(517, 'kn43_vdv', 'Classic Soviet Knife'),
(518, 'kn15', 'Cleaver'),
(519, 'kn02_xmas', 'Icicle Knife'),
(520, 'ap01_xmas', 'Christmas Ammo Pack'),
(521, 'kn03_xmas', 'Candy Knife'),
(522, 'sniper_helmet_10', '"TOP DOG" SNIPER HELMET'),
(523, 'soldier_helmet_10', '"TOP DOG" RIFLEMAN HELMET'),
(524, 'medic_helmet_10', '"TOP DOG" MEDIC HELMET'),
(525, 'engineer_helmet_10', '"TOP DOG" ENGINEER HELMET');

-- --------------------------------------------------------

--
-- Structure for view `all accounts`
--
DROP TABLE IF EXISTS `all accounts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all accounts`  AS  select `accounts`.`username` AS `Nickname`,`accounts`.`kredits` AS `Kredits`,count(`auctions`.`id`) AS `Total Auctioned`,count(`auctions`.`sold`) AS `Total Sold`,sum(`auctions`.`last_offer`) AS `Total Earned` from ((`selling` join `accounts` on((`selling`.`account_id` = `accounts`.`id`))) join `auctions` on((`selling`.`auction_id` = `auctions`.`id`))) group by `accounts`.`username`,`accounts`.`kredits` ;

-- --------------------------------------------------------

--
-- Structure for view `all auctions`
--
DROP TABLE IF EXISTS `all auctions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all auctions`  AS  select `auctions`.`id` AS `Auction ID`,`accounts`.`username` AS `Nickname`,`weapons`.`name` AS `Weapon`,concat(timestampdiff(DAY,`auctions`.`start`,`auctions`.`end`),' days') AS `Duration`,concat(if((now() > `auctions`.`end`),'-',' '),abs(timestampdiff(DAY,now(),`auctions`.`end`)),'d ',abs((timestampdiff(HOUR,now(),`auctions`.`end`) % 24)),'h ',abs((timestampdiff(MINUTE,now(),`auctions`.`end`) % 60)),'m ',abs((timestampdiff(SECOND,now(),`auctions`.`end`) % 60)),'s ') AS `Time Left`,`auctions`.`total_bids` AS `Total Bids`,`auctions`.`last_offer` AS `Last Offer`,`auctions`.`initial_price` AS `Initial Price`,`auctions`.`sold` AS `Sold`,`auction_status`.`name` AS `Status` from (((((`selling` join `accounts` on((`selling`.`account_id` = `accounts`.`id`))) join `auctions` on((`selling`.`auction_id` = `auctions`.`id`))) join `items` on((`auctions`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) join `auction_status` on((`auctions`.`status_id` = `auction_status`.`id`))) order by `auctions`.`end` desc ;

-- --------------------------------------------------------

--
-- Structure for view `all weapons`
--
DROP TABLE IF EXISTS `all weapons`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `all weapons`  AS  select `accounts`.`username` AS `Nickname`,`weapons`.`name` AS `Weapon`,if((`inventory`.`durability` = 0),'∞',if((`inventory`.`durability` = -(1)),'0%',concat(`inventory`.`durability`,'%'))) AS `Durability`,`accounts`.`kredits` AS `Kredits` from (((`inventory` join `accounts` on((`inventory`.`account_id` = `accounts`.`id`))) join `items` on((`inventory`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) order by `accounts`.`username` ;

-- --------------------------------------------------------

--
-- Structure for view `auctions everyone`
--
DROP TABLE IF EXISTS `auctions everyone`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `auctions everyone`  AS  select `auctions_all`.`id` AS `Auction ID`,`auctions_all`.`start` AS `Start Date`,`auctions_all`.`end` AS `End Date`,concat(timestampdiff(DAY,`auctions_all`.`start`,`auctions_all`.`end`),' days') AS `Duration`,concat(if((now() > `auctions_all`.`end`),'-',' '),abs(timestampdiff(DAY,now(),`auctions_all`.`end`)),'d ',abs((timestampdiff(HOUR,now(),`auctions_all`.`end`) % 24)),'h ',abs((timestampdiff(MINUTE,now(),`auctions_all`.`end`) % 60)),'m ',abs((timestampdiff(SECOND,now(),`auctions_all`.`end`) % 60)),'s ') AS `Time Left`,`weapons`.`name` AS `Weapon`,`auctions_all`.`total_bids` AS `Total Bids`,`auctions_all`.`last_offer` AS `Last Offer`,`auctions_all`.`initial_price` AS `Initial Price`,`auctions_all`.`sold` AS `Sold`,`auction_status`.`name` AS `Status`,`category`.`name` AS `Category`,`offer_type`.`name` AS `Offer Type`,`soldier_class`.`name` AS `Soldier Class` from ((((((`auctions_all` join `items` on((`auctions_all`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) join `auction_status` on((`auctions_all`.`status_id` = `auction_status`.`id`))) join `category` on((`items`.`category_id` = `category`.`id`))) join `offer_type` on((`items`.`offer_type_id` = `offer_type`.`id`))) join `soldier_class` on((`items`.`soldier_class_id` = `soldier_class`.`id`))) order by `auctions_all`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `auctions with bids`
--
DROP TABLE IF EXISTS `auctions with bids`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `auctions with bids`  AS  select `accounts`.`username` AS `Nickname`,`weapons`.`name` AS `Weapon`,concat(timestampdiff(HOUR,now(),`auctions`.`end`),'h ',(timestampdiff(MINUTE,now(),`auctions`.`end`) % 60),'m ',(timestampdiff(SECOND,now(),`auctions`.`end`) % 60),'s ') AS `Time Left`,`auctions`.`total_bids` AS `Total Bids`,`auctions`.`last_offer` AS `Last Offer`,`auctions`.`initial_price` AS `Initial Price`,`auctions`.`sold` AS `Sold`,`auction_status`.`name` AS `Status` from (((((`selling` join `accounts` on((`selling`.`account_id` = `accounts`.`id`))) join `auctions` on((`selling`.`auction_id` = `auctions`.`id`))) join `items` on((`auctions`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) join `auction_status` on((`auctions`.`status_id` = `auction_status`.`id`))) where ((`auctions`.`end` >= now()) and (`auctions`.`total_bids` <> 0)) order by `auctions`.`end` ;

-- --------------------------------------------------------

--
-- Structure for view `inventory summary`
--
DROP TABLE IF EXISTS `inventory summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inventory summary`  AS  select `weapons`.`name` AS `Weapon`,if((sum(`inventory`.`durability`) = 0),'∞',concat(sum(`inventory`.`durability`),'%')) AS `Durability` from ((`inventory` join `items` on((`inventory`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) where (`inventory`.`durability` <> -(1)) group by `weapons`.`name` order by sum(`inventory`.`durability`) desc ;

-- --------------------------------------------------------

--
-- Structure for view `ongoing auctions`
--
DROP TABLE IF EXISTS `ongoing auctions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ongoing auctions`  AS  select `auctions`.`id` AS `Auction ID`,`accounts`.`username` AS `Nickname`,`weapons`.`name` AS `Weapon`,concat(timestampdiff(HOUR,now(),`auctions`.`end`),'h ',(timestampdiff(MINUTE,now(),`auctions`.`end`) % 60),'m ',(timestampdiff(SECOND,now(),`auctions`.`end`) % 60),'s ') AS `Time Left`,`auctions`.`total_bids` AS `Total Bids`,`auctions`.`last_offer` AS `Last Offer`,`auctions`.`initial_price` AS `Initial Price`,`auctions`.`sold` AS `Sold`,`auction_status`.`name` AS `Status` from (((((`selling` join `accounts` on((`selling`.`account_id` = `accounts`.`id`))) join `auctions` on((`selling`.`auction_id` = `auctions`.`id`))) join `items` on((`auctions`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) join `auction_status` on((`auctions`.`status_id` = `auction_status`.`id`))) where ((`auction_status`.`name` = 'active') or (`auction_status`.`name` = 'closing')) order by `auctions`.`end` desc ;

-- --------------------------------------------------------

--
-- Structure for view `selling accounts`
--
DROP TABLE IF EXISTS `selling accounts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `selling accounts`  AS  select `accounts`.`username` AS `Username`,`accounts`.`kredits` AS `Kredits`,count(`auctions`.`item_id`) AS `Total Auctioned`,count(`auctions`.`sold`) AS `Total Sold`,count(`auctions`.`total_bids`) AS `Total Bids`,sum(`auctions`.`last_offer`) AS `Total Earned` from ((`selling` join `accounts` on((`selling`.`account_id` = `accounts`.`id`))) join `auctions` on((`selling`.`auction_id` = `auctions`.`id`))) where (`auctions`.`sold` <> 0) group by `accounts`.`username`,`accounts`.`kredits` order by `Total Sold` desc ;

-- --------------------------------------------------------

--
-- Structure for view `sold weapons`
--
DROP TABLE IF EXISTS `sold weapons`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sold weapons`  AS  select `weapons`.`name` AS `Weapon`,count(`auctions`.`id`) AS `Total Auctioned`,sum(`auctions`.`sold`) AS `Total Sold`,sum(`auctions`.`last_offer`) AS `Total earned`,(sum(`auctions`.`last_offer`) / sum(`auctions`.`sold`)) AS `Average Value` from ((`items` join `auctions` on((`auctions`.`item_id` = `items`.`id`))) join `weapons` on((`items`.`code_id` = `weapons`.`id`))) group by `weapons`.`name` order by `Total Sold` desc ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`,`email`);

--
-- Indexes for table `auctions`
--
ALTER TABLE `auctions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_item_auction` (`item_id`),
  ADD KEY `fk_status_auction` (`status_id`);

--
-- Indexes for table `auctions_all`
--
ALTER TABLE `auctions_all`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_item_auction` (`item_id`),
  ADD KEY `fk_status_auctions_all` (`status_id`);

--
-- Indexes for table `auction_status`
--
ALTER TABLE `auction_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_item_inventory` (`item_id`),
  ADD KEY `fk_account_inventory` (`account_id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code_id`),
  ADD KEY `fk_soldier_class_item` (`soldier_class_id`),
  ADD KEY `fk_offer_type_items` (`offer_type_id`),
  ADD KEY `fk_category_item` (`category_id`);

--
-- Indexes for table `offer_type`
--
ALTER TABLE `offer_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `selling`
--
ALTER TABLE `selling`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_account_selling` (`account_id`),
  ADD KEY `fk_auction_selling` (`auction_id`);

--
-- Indexes for table `soldier_class`
--
ALTER TABLE `soldier_class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weapons`
--
ALTER TABLE `weapons`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `auction_status`
--
ALTER TABLE `auction_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;
--
-- AUTO_INCREMENT for table `offer_type`
--
ALTER TABLE `offer_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `selling`
--
ALTER TABLE `selling`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;
--
-- AUTO_INCREMENT for table `soldier_class`
--
ALTER TABLE `soldier_class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `weapons`
--
ALTER TABLE `weapons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=526;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `auctions`
--
ALTER TABLE `auctions`
  ADD CONSTRAINT `fk_item_auction` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `fk_status_auction` FOREIGN KEY (`status_id`) REFERENCES `auction_status` (`id`);

--
-- Constraints for table `auctions_all`
--
ALTER TABLE `auctions_all`
  ADD CONSTRAINT `fk_items_auctions_all` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  ADD CONSTRAINT `fk_status_auctions_all` FOREIGN KEY (`status_id`) REFERENCES `auction_status` (`id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_account_inventory` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `fk_item_inventory` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `fk_category_item` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `fk_code_item` FOREIGN KEY (`code_id`) REFERENCES `weapons` (`id`),
  ADD CONSTRAINT `fk_offer_type_items` FOREIGN KEY (`offer_type_id`) REFERENCES `offer_type` (`id`),
  ADD CONSTRAINT `fk_soldier_class_item` FOREIGN KEY (`soldier_class_id`) REFERENCES `soldier_class` (`id`);

--
-- Constraints for table `selling`
--
ALTER TABLE `selling`
  ADD CONSTRAINT `fk_account_selling` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `fk_auction_selling` FOREIGN KEY (`auction_id`) REFERENCES `auctions` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
