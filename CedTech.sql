-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2024 at 03:58 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cedtech`
--
CREATE DATABASE IF NOT EXISTS `cedtech` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cedtech`;

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `ContactId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(400) NOT NULL,
  `message` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`ContactId`, `name`, `email`, `subject`, `message`) VALUES
(1, 'Cedrick', 'cedrick0311.2@gmail.com', 'e', 'sfg');

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `orderItemId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`orderItemId`, `orderId`, `productId`, `quantity`, `price`) VALUES
(7, 5, 1, 1, 199.00),
(8, 5, 3, 1, 119.95),
(9, 5, 9, 1, 99.95),
(10, 5, 10, 1, 129.95),
(11, 5, 13, 1, 209.00),
(14, 6, 1, 1, 199.00),
(15, 7, 9, 1, 99.95),
(16, 8, 23, 1, 1529.00),
(17, 9, 13, 1, 209.00);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `shippingAddress` varchar(255) NOT NULL,
  `paymentMethod` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderId`, `userId`, `shippingAddress`, `paymentMethod`) VALUES
(5, 37, 'test', 'paypal'),
(6, 37, 'test', 'creditCard'),
(7, 37, 'test', 'paypal'),
(8, 37, 'test', 'paypal'),
(9, 37, 'test', 'creditCard');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL COMMENT 'AUTO_INCREMENTS',
  `productName` varchar(255) NOT NULL,
  `productBrand` varchar(255) NOT NULL,
  `productQuantity` int(11) NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productCategory` varchar(255) NOT NULL,
  `productImage` varchar(1000) NOT NULL,
  `popular` int(1) NOT NULL,
  `recommended` int(1) NOT NULL,
  `description` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productId`, `productName`, `productBrand`, `productQuantity`, `productPrice`, `productCategory`, `productImage`, `popular`, `recommended`, `description`) VALUES
(1, '[Red Edition] X2 v2 Gaming Mouse', 'pulsar', 11, 199.00, 'mouse', '1720702093469-[Red Edition] X2H eS Gaming Mouse.webp,1720702093469-[Red Edition] X2H eS Gaming Mouse2.webp,1720702093469-[Red Edition] X2H eS Gaming Mouse3.webp,1720702093469-[Red Edition] X2H eS Gaming Mouse4.webp', 1, 1, 'best mouse ever test'),
(3, '[Demon Slayer] X2 v2 Tanjiro Gaming Mouse', 'pulsar', 10, 119.95, 'mouse', '1720702142888-[Demon Slayer] X2 v2 Tanjiro4.webp,1720702150934-[Demon Slayer] X2 v2 Tanjiro2.webp,1720702150935-[Demon Slayer] X2 v2 Tanjiro3.webp,1720702157574-[Demon Slayer] X2 v2 Tanjiro.webp', 0, 1, 'best mouse ever hello b'),
(8, 'X2 Pulsar white', 'pulsar', 23, 99.00, 'mouse', '1720702222325-[White Edition] X2A eS Gaming Mouse.webp,1720702222325-[White Edition] X2A eS Gaming Mouse2.webp,1720702222325-[White Edition] X2A eS Gaming Mouse3.webp,1720702222326-[White Edition] X2A eS Gaming Mouse4.webp', 1, 0, 'White mouse'),
(9, '[RRQ Edition] X2H Gaming Mouse', 'pulsar', 55, 99.95, 'mouse', '1720702260290-[RRQ Edition] X2H Gaming Mouse.webp,1720702260290-[RRQ Edition] X2H Gaming Mouse2.webp,1720702260290-[RRQ Edition] X2H Gaming Mouse3.webp,1720702260290-[RRQ Edition] X2H Gaming Mouse4.webp', 0, 1, 'Length: 4.72in (120mm) Width: 2.56in (65mm) Height: 1.54in (39mm) Weight: 55g (± 1g) / 1.94oz Designed for Competitive eSports Narrow Waist / High Hump Symmetrical Shape Recommended for Claw / Palm Claw Grip Ultra-light Weight 55g Fast and Double Click Free OPTICAL SWITCH Pulsar Blue Encoder Super Smooth ballbearing wheels Latest Flagship PAW3395 Sensor Fully customizable sensor setting Fully customizable keys and macros Superflex Paracord Cable Ultra Durable Lag free 2.4GHz Wireless technology Up to 100 hours of battery life at 1000Hz polling rate ±10% (Actual battery life may vary based on user\'s environment) X2H Gaming Mouse x 1 Wireless Receiver adapter x 1 Wireless Receiver x 1 USB-C Cable x 1'),
(10, '[White Edition] Xlite v3 eS Gaming Mouse', 'pulsar', 32, 129.95, 'mouse', '1720702331175-[White Edition] Xlite v3 eS Gaming Mouse.webp,1720702331175-[White Edition] Xlite v3 eS Gaming Mouse2.webp,1720702331175-[White Edition] Xlite v3 eS Gaming Mouse3.webp,1720702331175-[White Edition] Xlite v3 eS Gaming Mouse4.webp', 0, 1, 'Length: 4.8in (122mm) Width: 2.6in (66mm) Height: 1.7in (43mm) Weight: 65g (+- 1g) / 2.3oz Designed for Competitive eSports OLED Display on the bottom of the mouse. Driverless, Softwareless. Super high polling rate - 4K Wireless / 8K Wired. Ergonomic right hand Palm Grip Fast and Double Click Free OPTICAL SWITCH Pulsar Blue Encoder Aerospace-grade aluminum alloy wheel Latest Flagship PAW3395 Sensor Optimized 60g level balanced weight distribution Superflex Paracord Cable Ultra Durable 500mA battery for 70-100 hours of usage. Super rigid body structure PAW3395 26000 DPI 650 IPS 50g Acceleration 4000hz wireless / 8000hz wired 32bit ARM Processor Intel® Core™ i5 or higher CPU AMD Ryzen™ 5 or higher CPU USB 3.0 or Higher Port'),
(11, '[Super Clear Edition] X2H Gaming Mouse', 'pulsar', 26, 99.95, 'mouse', '1720702442658-[Super Clear Edition] X2H Gaming Mouse.webp,1720702442659-[Super Clear Edition] X2H Gaming Mouse2.webp,1720702442659-[Super Clear Edition] X2H Gaming Mouse3.webp,1720702442659-[Super Clear Edition] X2H Gaming Mouse4.webp', 0, 0, 'Length: 4.74in (120.4mm) Width: 2.56in (65mm) Height: 1.54in (39mm) Weight: 54g (± 1g) / 1.94oz Designed for Competitive eSports Narrow Waist / High Hump Symmetrical Shape Recommended for Claw / Palm Claw Grip Ultra-light Weight 54g Fast and Double Click Free OPTICAL SWITCH Pulsar Blue Encoder Super Smooth ballbearing wheels Latest Flagship PAW3395 Sensor Fully customizable sensor setting Fully customizable keys and macros Superflex Paracord Cable Ultra Durable Lag free 2.4GHz Wireless technology Up to 100 hours of battery life at 1000Hz polling rate ±10% (Actual battery life may vary based on user\'s environment) PAW3395 26000 DPI 650 IPS 50g Acceleration 1000Hz/1ms Polling Rate 32bit ARM Processor X2H Gaming Mouse x 1 Wireless Receiver adapter x 1 Wireless Receiver x 1 USB-C Cable x 1'),
(12, 'XBOARD QS Mechanical Gaming Keyboard', 'pulsar', 6, 299.00, 'keyboard', '1720702763044-XBOARD QS Mechanical Gaming Keyboard.webp,1720702774058-XBOARD QS Mechanical Gaming Keyboard2.webp', 0, 0, 'Length: 14.1in (360mm) Width: 6.4in (163mm) Height: 1.37in (35mm) Weight: 1480g (± 1g) / 52.2oz 88-key Tenkeyless Quick Switching Technology - Dedicated button for fast computer switching Perfect Windows/Mac Compatibility Precision CNC-machined aluminum body Gasket Mounting Volume and LED control knob Built-in USB-A 2-port hub Anti-ghosting 44-type RGB lighting effects PBT Double-shot keycaps Hot-swappable switches - compatible with most 3-pin / 5-pin MX mechanical switches South-facing RGB LED QMK/VIA Support 2 Button Keys for fast computer switching Volume Knob Win/Mac Switch key USB Type-C 2.0 x 2 USB Type-A 2.0 x 2 DC 5V / 500mA VIA REMAP Signal RGB Vial Windows 7 or higher Mac OS X v10.11 or higher Xboard QS Keyboard x 1 USB-C Cable (1.5m) x 2 Switch Puller x 1 Keycap Puller x 1 Extra switch x 5 Dust Bag x 1 User Manual x 1 Brand Sticker x 1'),
(13, 'KBD8X MKIII', 'kbdfans', 65, 209.00, 'keyboard', '1720703040703-KBD8X MKIII.webp,1720703040704-KBD8X MKIII2.webp', 1, 1, '1.2mm Hot-swap ANSI PCB+Foam kit'),
(14, 'TOFU FA', 'tofu', 54, 109.00, 'keyboard', '1720703185459-TOFU FA.webp,1720703185459-TOFU FA2.webp,1720703185459-TOFU FA3.webp,1720703185460-TOFU FA4.webp', 1, 0, '1.2mm Hot-swap ANSI PCB + foam kit'),
(15, 'Razer BlackWidow V4 X', 'razer', 74, 169.99, 'keyboard', '1720703674572-Razer BlackWidow V4 X.jpg,1720703674573-Razer BlackWidow V4 X2.jpg', 1, 0, 'Razer™ Green Mechanical Switches 6 Dedicated Macro Keys Multi-Function Roller and Secondary Media Keys'),
(17, 'MX MECHANICAL', 'logitech', 23, 299.00, 'keyboard', '1720703971093-MX MECHANICAL.webp,1720703971093-MX MECHANICAL2.webp', 0, 0, 'Wireless Illuminated Performance Keyboard'),
(18, 'PRISM+ W220v', 'prism', 53, 108.00, 'monitor', '1720705014914-PRISM+ W220v.webp,1720705014914-PRISM+ W220v4.webp', 0, 0, 'You\'ll never guess you\'re staring at a 22 inch screen with the sleek ZeroBezel design and full HD display to maximize screen estate on the W220v.'),
(19, 'PRISM+ W270', 'prism', 22, 158.00, 'monitor', '1720705140318-PRISM+ W270.webp,1720705140318-PRISM+ W2702.webp,1720705140318-PRISM+ W2703.webp,1720705140318-PRISM+ W2704.webp', 0, 0, 'Featuring crystal clear FHD resolution, premium IPS Panel Technology, 99% sRGB on a 27\" screen, the W270 is the best value display for colour work.'),
(20, 'PRISM+ C270', 'prism', 12, 178.00, 'monitor', '1720705287811-PRISM+ C270.webp,1720705287811-PRISM+ C2702.webp,1720705287811-PRISM+ C2703.webp,1720705287811-PRISM+ C2704.webp', 0, 0, 'Perfect for both work and play, the C270 boasts a beautiful 27\" curved display at 100Hz, prioritizing both performance and comfort.'),
(21, 'PRISM+ C315 MAX', 'prism', 23, 399.00, 'monitor', '1720705370949-PRISM+ C315 MAX.webp,1720705370949-PRISM+ C315 MAX2.webp,1720705370949-PRISM+ C315 MAX3.webp,1720705370949-PRISM+ C315 MAX4.webp', 0, 0, 'Work better in 4K across a wide 31.5\" screen with 120% sRGB that\'s perfect for creative work and watching movies or even a casual game or two.'),
(22, 'PRISM+ X240', 'prism', 23, 229.00, 'monitor', '1720705442302-PRISM+ X240.webp,1720705442302-PRISM+ X2402.webp,1720705442302-PRISM+ X2403.webp,1720705442302-PRISM+ X2404.webp', 0, 0, 'Top the scoreboards with the X240, this gaming essential comes packed with a refresh rate of 180Hz, quick 1ms response time and 120% sRGB.'),
(23, 'GHOST RTX4060 AMD', 'dreamcore', 23, 1529.00, 'computer', '1720705657173-GHOST RTX4060 AMD.jpg,1720705657173-GHOST RTX4060 AMD2.png,1720705657174-GHOST RTX4060 AMD3.png,1720705657175-GHOST RTX4060 AMD4.png', 0, 0, 'AMD Ryzen 5 5600 6-core  MSI B550M PRO-VDH WIFI  Stock CPU Cooler  16GB Vengeance RGB Pro SL DDR4 3600MHz  MSI RTX 4060 VENTUS 2X BLACK 8G OC  XPG S70 Blade 1TB Gen4 7400MB/s  Wi-Fi 6 & Bluetooth 5.2  MSI MAG A650 80+ BRONZE  MSI FORGE M100R'),
(24, 'GHOST RX7600 AMD', 'dreamcore', 22, 1529.00, 'computer', '1720705908078-GHOST RX7600 AMD.jpg,1720705908078-GHOST RX7600 AMD2.png,1720705908079-GHOST RX7600 AMD3.jpg,1720705908080-GHOST RX7600 AMD4.jpg', 0, 0, 'AMD Ryzen 5 5600 6-core  MSI B550M PRO-VDH WIFI  Stock CPU Cooler  16GB Vengeance RGB Pro SL DDR4 3600MHz  Sapphire Pulse RX 7600 Gaming 8GB  XPG S70 Blade 1TB Gen4 7400MB/s  Wi-Fi 6 & Bluetooth 5.2  MSI MAG A650 80+ BRONZE  ASUS Prime AP201 Tempered Glass (Black) – Customizable'),
(25, 'GHOST RTX4060 INTEL', 'dreamcore', 52, 1659.00, 'computer', '1720706037235-GHOST RTX4060 INTEL.jpg,1720706037235-GHOST RTX4060 INTEL2.png,1720706037236-GHOST RTX4060 INTEL3.png,1720706037237-GHOST RTX4060 INTEL4.png', 0, 0, 'INTEL® CORE™ i5-12400F 6-core  MSI B760M-A WIFI  Stock CPU Cooler  16GB Vengeance DDR5 5200MT/s  MSI RTX 4060 VENTUS 2X BLACK 8G OC  XPG S70 Blade 1TB Gen4 7400MB/s  Wi-Fi 6 & Bluetooth 5.2  MSI MAG A650 80+ BRONZE  MSI FORGE M100R'),
(26, 'RTX4070TI SUPER AMD Z: SPECTRE', 'dreamcore', 23, 3349.00, 'computer', '1720706115136-1.jpg,1720706115137-2.png,1720706115138-3.jpg,1720706115138-4.jpg', 0, 0, 'AMD Ryzen 7 7800X3D 8-core  ASUS TUF GAMING B650-E WIFI  DREAMCORE NEBULA 240MM AIO [BLACK]  32GB Vengeance RGB DDR5 6000MT/s  MSI RTX 4070 Ti SUPER 16G VENTUS 3X OC  XPG S70 Blade 1TB Gen4 7400MB/s  Wi-Fi 6 & Bluetooth 5.2  MSI MAG A850GL 80+ GOLD PCIE5  Spectre'),
(27, 'GHOST RX7800XT AMD Z', 'dreamcore', 12, 2589.00, 'computer', '1720706226437-GHOST RX7800XT AMD Z.jpg,1720706226438-GHOST RX7800XT AMD Z2.webp,1720706226438-GHOST RX7800XT AMD Z3.jpg,1720706226440-GHOST RX7800XT AMD Z4.jpg', 0, 0, 'AMD Ryzen 7 7800X3D 8-core  MSI PRO B650M-A WIFI  DREAMCORE NEBULA 240MM AIO [BLACK]  16GB Vengeance DDR5 5200MT/s  Sapphire Pulse RX 7800 XT Gaming 16GB  XPG S70 Blade 1TB Gen4 7400MB/s  Wi-Fi 6 & Bluetooth 5.2  MSI MAG A850GL 80+ GOLD PCIE5  ASUS Prime AP201 Tempered Glass (Black) - Customizable');

-- --------------------------------------------------------

--
-- Table structure for table `useraccount`
--

CREATE TABLE `useraccount` (
  `userId` int(11) NOT NULL COMMENT 'AUTO_INCREMENT',
  `username` varchar(255) NOT NULL COMMENT 'UNIQUE, NOT NULL',
  `email` varchar(255) NOT NULL COMMENT 'UNIQUE, NOT NULL',
  `contact` varchar(20) NOT NULL COMMENT 'UNIQUE, NOT NULL',
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `useraccount`
--

INSERT INTO `useraccount` (`userId`, `username`, `email`, `contact`, `password`) VALUES
(37, 'cedrick', 'cedrick@gmail.com', '11111111', 'cedrick'),
(38, 'cedrick2', 'cedrick2@gmail.com', '22222222', 'cedrick'),
(40, 'cedrick3', 'cedrick3@gmail.com', '33333333', 'cedrick'),
(41, 'cedrick4', 'cedrick4@gmail.com', '44444444', 'cedrick'),
(42, 'cedrick5', 'cedrick5@gmail.com', '55555555', 'cedrick');

-- --------------------------------------------------------

--
-- Table structure for table `usercart`
--

CREATE TABLE `usercart` (
  `cartId` int(11) NOT NULL COMMENT 'AUTO_INCREMENT',
  `userId` int(11) NOT NULL COMMENT 'FOREIGN KEY'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usercart`
--

INSERT INTO `usercart` (`cartId`, `userId`) VALUES
(2, 37),
(3, 38),
(4, 40),
(5, 41),
(6, 42);

-- --------------------------------------------------------

--
-- Table structure for table `usercartitems`
--

CREATE TABLE `usercartitems` (
  `usercartitemsId` int(11) NOT NULL,
  `cartId` int(11) NOT NULL COMMENT 'FOREIGN KEY',
  `productsId` int(11) NOT NULL,
  `quantity` int(255) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usercartitems`
--

INSERT INTO `usercartitems` (`usercartitemsId`, `cartId`, `productsId`, `quantity`, `price`) VALUES
(42, 2, 1, 2, 199.00),
(43, 2, 3, 1, 119.95),
(44, 2, 9, 1, 99.95),
(45, 2, 10, 1, 129.95),
(47, 3, 12, 1, 299.00),
(48, 3, 13, 1, 209.00),
(49, 3, 14, 1, 109.00),
(50, 3, 15, 1, 169.99),
(51, 3, 17, 1, 299.00),
(52, 4, 23, 1, 1529.00),
(53, 4, 24, 1, 1529.00),
(54, 4, 25, 1, 1659.00),
(55, 4, 26, 1, 3349.00),
(56, 4, 27, 1, 2589.00),
(57, 5, 18, 1, 108.00),
(58, 5, 19, 1, 158.00),
(59, 5, 20, 1, 178.00),
(60, 5, 21, 1, 399.00),
(61, 5, 22, 1, 229.00),
(62, 6, 1, 4, 199.00),
(63, 6, 8, 2, 99.00),
(64, 6, 13, 3, 209.00),
(65, 6, 14, 7, 109.00),
(66, 6, 15, 1, 169.99),
(67, 5, 10, 1, 129.95),
(68, 2, 13, 1, 209.00);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `wishlistId` int(11) NOT NULL COMMENT 'AUTO_INCREMENT',
  `userId` int(11) NOT NULL COMMENT 'FOREIGN KEY',
  `productsId` int(11) NOT NULL COMMENT 'FOREIGN KEY'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`wishlistId`, `userId`, `productsId`) VALUES
(9, 37, 1),
(10, 37, 3),
(11, 37, 9),
(12, 37, 10),
(13, 37, 13);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`ContactId`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`orderItemId`),
  ADD KEY `orderitems_productid` (`productId`),
  ADD KEY `orderitems_orderid` (`orderId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderId`),
  ADD KEY `orders_userid` (`userId`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`);

--
-- Indexes for table `useraccount`
--
ALTER TABLE `useraccount`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `contact` (`contact`) USING BTREE;

--
-- Indexes for table `usercart`
--
ALTER TABLE `usercart`
  ADD PRIMARY KEY (`cartId`),
  ADD KEY `userId_usercart` (`userId`);

--
-- Indexes for table `usercartitems`
--
ALTER TABLE `usercartitems`
  ADD PRIMARY KEY (`usercartitemsId`),
  ADD KEY `cartId_usercartitems` (`cartId`),
  ADD KEY `productId_usercartitems` (`productsId`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`wishlistId`),
  ADD KEY `productId_wishlist` (`productsId`),
  ADD KEY `userId_wishlist` (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `ContactId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `orderItemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'AUTO_INCREMENTS', AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `useraccount`
--
ALTER TABLE `useraccount`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'AUTO_INCREMENT', AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `usercart`
--
ALTER TABLE `usercart`
  MODIFY `cartId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'AUTO_INCREMENT', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `usercartitems`
--
ALTER TABLE `usercartitems`
  MODIFY `usercartitemsId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `wishlistId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'AUTO_INCREMENT', AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_orderid` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE CASCADE,
  ADD CONSTRAINT `orderitems_productid` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_userid` FOREIGN KEY (`userId`) REFERENCES `useraccount` (`userId`) ON DELETE CASCADE;

--
-- Constraints for table `usercart`
--
ALTER TABLE `usercart`
  ADD CONSTRAINT `userId_usercart` FOREIGN KEY (`userId`) REFERENCES `useraccount` (`userId`) ON DELETE CASCADE;

--
-- Constraints for table `usercartitems`
--
ALTER TABLE `usercartitems`
  ADD CONSTRAINT `cartId_usercartitems` FOREIGN KEY (`cartId`) REFERENCES `usercart` (`cartId`),
  ADD CONSTRAINT `productId_usercartitems` FOREIGN KEY (`productsId`) REFERENCES `products` (`productId`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `productId_wishlist` FOREIGN KEY (`productsId`) REFERENCES `products` (`productId`) ON DELETE CASCADE,
  ADD CONSTRAINT `userId_wishlist` FOREIGN KEY (`userId`) REFERENCES `useraccount` (`userId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
