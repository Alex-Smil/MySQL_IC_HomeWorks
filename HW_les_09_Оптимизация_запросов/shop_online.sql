-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: shop_online
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `accounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL COMMENT 'Счет',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Счета пользователей и интернет магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,4,1000.00,'2019-04-09 17:17:06','2019-04-09 21:07:49'),(2,3,0.00,'2019-04-09 17:17:06','2019-04-09 17:55:05'),(3,2,200.00,'2019-04-09 17:17:06','2019-04-09 17:55:22'),(4,NULL,31000.00,'2019-04-09 17:17:06','2019-04-09 21:07:59');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `cat2`
--

DROP TABLE IF EXISTS `cat2`;
/*!50001 DROP VIEW IF EXISTS `cat2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `cat2` AS SELECT 
 1 AS `id`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `catalogs`
--

DROP TABLE IF EXISTS `catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `catalogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Разделы интернет-магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,'Процессоры'),(2,'Мат.платы'),(12,'Видеокарты'),(13,'Оперативная память'),(14,'Куллера'),(15,'Аксессуары');
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `watchlog_catalogs` AFTER INSERT ON `catalogs` FOR EACH ROW BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cities` (
  `label` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'en',
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'ru',
  PRIMARY KEY (`label`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES ('Moscow','Москва'),('Omsk','Омск'),('Saint Petersburg','Санкт-Петербург'),('Tomsk','Томск'),('Ufa','Уфа');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datetbl`
--

DROP TABLE IF EXISTS `datetbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `datetbl` (
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datetbl`
--

LOCK TABLES `datetbl` WRITE;
/*!40000 ALTER TABLE `datetbl` DISABLE KEYS */;
INSERT INTO `datetbl` VALUES ('2018-08-17'),('2018-08-23'),('2018-08-27'),('2018-08-29'),('2018-08-31');
/*!40000 ALTER TABLE `datetbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `discounts` float unsigned DEFAULT NULL COMMENT 'Величина скидки от 0.00 до 1.0',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_user_id` (`user_id`),
  KEY `index_of_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Скидки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flights`
--

DROP TABLE IF EXISTS `flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `flights` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'en',
  `to` varchar(50) COLLATE utf8_bin NOT NULL COMMENT 'en',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_from_label` (`from`),
  KEY `fk_to_label` (`to`),
  CONSTRAINT `fk_from_label` FOREIGN KEY (`from`) REFERENCES `cities` (`label`),
  CONSTRAINT `fk_to_label` FOREIGN KEY (`to`) REFERENCES `cities` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flights`
--

LOCK TABLES `flights` WRITE;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` VALUES (1,'Moscow','Saint Petersburg'),(2,'Saint Petersburg','Omsk'),(3,'Omsk','Tomsk'),(4,'Tomsk','Ufa'),(5,'Ufa','Moscow');
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integers`
--

DROP TABLE IF EXISTS `integers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `integers` (
  `value` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`value`),
  UNIQUE KEY `value` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integers`
--

LOCK TABLES `integers` WRITE;
/*!40000 ALTER TABLE `integers` DISABLE KEYS */;
INSERT INTO `integers` VALUES (1),(2),(3),(4),(5),(6);
/*!40000 ALTER TABLE `integers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `last5str`
--

DROP TABLE IF EXISTS `last5str`;
/*!50001 DROP VIEW IF EXISTS `last5str`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `last5str` AS SELECT 
 1 AS `created_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `logs` (
  `created_at` datetime NOT NULL,
  `table_name` varchar(45) COLLATE utf8_bin NOT NULL,
  `str_id` bigint(20) NOT NULL,
  `name_value` varchar(45) COLLATE utf8_bin NOT NULL
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES ('2019-04-30 12:32:28','users',16,'Кнехт'),('2019-04-30 12:36:34','users',17,'Liu Kangh'),('2019-04-30 12:36:34','users',18,'Sub-Zero'),('2019-04-30 12:36:34','users',19,'Scorpion'),('2019-04-30 12:36:34','users',20,'Raiden'),('2019-04-30 12:53:34','catalogs',13,'Оперативная память'),('2019-04-30 12:53:34','catalogs',14,'Куллера'),('2019-04-30 12:53:34','catalogs',15,'Аксессуары'),('2019-04-30 13:00:14','products',16,'PATRIOT PSD34G13332'),('2019-04-30 13:00:14','products',17,'DARK ROCK PRO 4 (BK022)'),('2019-04-30 13:00:14','products',18,'Коврик');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Заказы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2019-04-07 12:32:51','2019-04-07 12:32:51'),(2,3,'2019-04-07 12:36:22','2019-04-07 12:36:22'),(4,8,'2019-04-07 18:44:58','2019-04-07 18:44:58'),(5,1,'2019-04-07 19:28:13','2019-04-07 19:28:13');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders_products` (
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `total` int(10) unsigned DEFAULT '1' COMMENT 'Количество заказов',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_product_id` (`product_id`),
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Состав заказов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (1,1,1,'2019-04-07 18:38:39','2019-04-07 18:38:39'),(1,2,1,'2019-04-07 18:38:39','2019-04-07 18:38:39'),(2,1,1,'2019-04-07 18:42:00','2019-04-07 18:42:00'),(2,2,1,'2019-04-07 18:42:00','2019-04-07 18:42:00'),(4,1,1,'2019-04-07 18:58:51','2019-04-07 18:58:51'),(4,4,3,'2019-04-07 18:58:51','2019-04-07 18:58:51'),(4,5,2,'2019-04-07 18:58:51','2019-04-07 18:58:51'),(5,3,1,'2019-04-07 19:29:27','2019-04-07 19:29:27'),(5,4,1,'2019-04-07 19:29:27','2019-04-07 19:29:27');
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `prods_desc`
--

DROP TABLE IF EXISTS `prods_desc`;
/*!50001 DROP VIEW IF EXISTS `prods_desc`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `prods_desc` AS SELECT 
 1 AS `prod_id`,
 1 AS `prod_name`,
 1 AS `cat_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Название',
  `description` text COLLATE utf8_bin COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `index_of_catalog_catalog_id` (`catalog_id`),
  CONSTRAINT `fk_catalog_id` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Товарные позиции';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Intel Core i3-8100','Процессор для настольных ПК',7890.00,1,'2019-03-31 17:44:23','2019-03-31 17:44:23'),(2,'AMD FX-8320E','Процессор для настольных ПК',4780.00,1,'2019-03-31 17:44:23','2019-03-31 17:44:23'),(3,'AMD FX-8320','Процессор для настольных ПК',7120.00,1,'2019-03-31 17:44:23','2019-03-31 17:44:23'),(4,'Gigabyte H310M S2H, H310, Socket 1151-V2','Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2',4311.00,2,'2019-03-31 17:44:23','2019-04-06 14:59:31'),(5,'MSI B250M GAMING PRO','Материнская плата MSI B250M GAMING PRO',4098.60,2,'2019-03-31 17:44:23','2019-04-06 14:59:31'),(6,'One More prod','Good prod',12150.00,2,'2019-03-31 17:44:23','2019-04-11 17:22:19'),(12,'GeForce GTX 1080','Мощная видеокарта',15000.00,12,'2019-04-23 18:52:56','2019-04-23 18:52:56'),(13,'GeForce GTX 1080',NULL,15000.00,12,'2019-04-23 18:54:33','2019-04-23 18:54:33'),(15,'NoName','No Desc',20000.00,12,'2019-04-23 19:08:30','2019-04-23 19:08:30'),(16,'PATRIOT PSD34G13332','Оперативная память',3000.00,13,'2019-04-30 13:00:14','2019-04-30 13:00:14'),(17,'DARK ROCK PRO 4 (BK022)','Куллера',500.00,14,'2019-04-30 13:00:14','2019-04-30 13:00:14'),(18,'Коврик','Коврик для мыши',150.00,15,'2019-04-30 13:00:14','2019-04-30 13:00:14');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nullTrigger` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
	IF(ISNULL(NEW.name)) THEN
		SET NEW.name = 'NoName';
	END IF;
	IF(ISNULL(NEW.description)) THEN
		SET NEW.description = 'No Desc';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `watchlog_products` AFTER INSERT ON `products` FOR EACH ROW BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rainbow`
--

DROP TABLE IF EXISTS `rainbow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `rainbow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `color` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rainbow`
--

LOCK TABLES `rainbow` WRITE;
/*!40000 ALTER TABLE `rainbow` DISABLE KEYS */;
INSERT INTO `rainbow` VALUES (1,'red'),(2,'orange'),(3,'yellow'),(4,'green'),(5,'blue'),(6,'indigo'),(7,'violet');
/*!40000 ALTER TABLE `rainbow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storehouses`
--

DROP TABLE IF EXISTS `storehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `storehouses` (
  `id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Название',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Склады';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouses`
--

LOCK TABLES `storehouses` WRITE;
/*!40000 ALTER TABLE `storehouses` DISABLE KEYS */;
/*!40000 ALTER TABLE `storehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storehouses_products`
--

DROP TABLE IF EXISTS `storehouses_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарный позиции на складке',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Запасы на складе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storehouses_products`
--

LOCK TABLES `storehouses_products` WRITE;
/*!40000 ALTER TABLE `storehouses_products` DISABLE KEYS */;
INSERT INTO `storehouses_products` VALUES (1,1,1,15,'2019-03-26 21:36:33','2019-03-26 21:36:33'),(2,1,3,0,'2019-03-26 21:36:33','2019-03-26 21:36:33'),(3,1,5,10,'2019-03-26 21:36:33','2019-03-26 21:36:33'),(4,1,7,5,'2019-03-26 21:36:33','2019-03-26 21:36:33'),(5,1,8,0,'2019-03-26 21:36:33','2019-03-26 21:36:33');
/*!40000 ALTER TABLE `storehouses_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl1`
--

DROP TABLE IF EXISTS `tbl1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl1` (
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl1`
--

LOCK TABLES `tbl1` WRITE;
/*!40000 ALTER TABLE `tbl1` DISABLE KEYS */;
INSERT INTO `tbl1` VALUES ('fst1'),('fst2'),('fst3'),('fst4');
/*!40000 ALTER TABLE `tbl1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl2`
--

DROP TABLE IF EXISTS `tbl2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tbl2` (
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl2`
--

LOCK TABLES `tbl2` WRITE;
/*!40000 ALTER TABLE `tbl2` DISABLE KEYS */;
INSERT INTO `tbl2` VALUES ('snd1'),('snd2'),('snd3');
/*!40000 ALTER TABLE `tbl2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_users`
--

DROP TABLE IF EXISTS `test_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `test_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `birthday_at` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_users`
--

LOCK TABLES `test_users` WRITE;
/*!40000 ALTER TABLE `test_users` DISABLE KEYS */;
INSERT INTO `test_users` VALUES (1,'user_0','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(2,'user_1','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(3,'user_2','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(4,'user_3','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(5,'user_4','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(6,'user_5','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(7,'user_6','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(8,'user_7','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(9,'user_8','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(10,'user_9','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(11,'user_10','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(12,'user_11','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(13,'user_12','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(14,'user_13','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(15,'user_14','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(16,'user_15','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(17,'user_16','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(18,'user_17','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(19,'user_18','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(20,'user_19','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(21,'user_20','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(22,'user_21','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(23,'user_22','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(24,'user_23','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(25,'user_24','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(26,'user_25','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(27,'user_26','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(28,'user_27','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(29,'user_28','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(30,'user_29','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(31,'user_30','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(32,'user_31','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(33,'user_32','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(34,'user_33','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(35,'user_34','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(36,'user_35','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(37,'user_36','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(38,'user_37','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(39,'user_38','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(40,'user_39','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(41,'user_40','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(42,'user_41','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(43,'user_42','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(44,'user_43','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(45,'user_44','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(46,'user_45','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(47,'user_46','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(48,'user_47','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(49,'user_48','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(50,'user_49','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(51,'user_50','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(52,'user_51','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(53,'user_52','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(54,'user_53','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(55,'user_54','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(56,'user_55','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(57,'user_56','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(58,'user_57','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(59,'user_58','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(60,'user_59','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(61,'user_60','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(62,'user_61','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(63,'user_62','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(64,'user_63','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(65,'user_64','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(66,'user_65','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(67,'user_66','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(68,'user_67','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(69,'user_68','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(70,'user_69','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(71,'user_70','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(72,'user_71','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(73,'user_72','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(74,'user_73','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(75,'user_74','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(76,'user_75','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(77,'user_76','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(78,'user_77','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(79,'user_78','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(80,'user_79','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(81,'user_80','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(82,'user_81','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(83,'user_82','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(84,'user_83','2019-04-30','2019-04-30 13:56:56','2019-04-30 13:56:56'),(85,'user_84','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(86,'user_85','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(87,'user_86','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(88,'user_87','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(89,'user_88','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(90,'user_89','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(91,'user_90','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(92,'user_91','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(93,'user_92','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(94,'user_93','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(95,'user_94','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(96,'user_95','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(97,'user_96','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(98,'user_97','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(99,'user_98','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57'),(100,'user_99','2019-04-30','2019-04-30 13:56:57','2019-04-30 13:56:57');
/*!40000 ALTER TABLE `test_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Геннадий','1990-10-05','2019-03-25 20:21:11','2019-03-25 20:21:11'),(2,'Наталья','1984-11-12','2019-03-25 20:21:11','2019-03-25 20:21:11'),(3,'Александр','1985-05-20','2019-03-25 20:21:11','2019-03-25 20:21:11'),(4,'Сергей','1988-02-14','2019-03-25 20:21:11','2019-03-25 20:21:11'),(5,'Иван','1998-01-12','2019-03-25 20:21:11','2019-03-25 20:21:11'),(6,'Мария','2006-08-29','2019-03-25 20:21:11','2019-03-25 20:21:11'),(7,'Светлана','1988-02-04','2019-03-31 17:52:36','2019-03-31 17:52:36'),(8,'Олег','1998-03-20','2019-03-31 17:52:36','2019-03-31 17:52:36'),(9,'Юлия','2006-07-12','2019-03-31 17:52:36','2019-03-31 17:52:36'),(10,'user273','1993-10-10','2019-04-04 00:37:31','2019-04-04 00:37:31'),(11,'user17','1995-07-31','2019-04-04 00:37:31','2019-04-04 00:37:31'),(12,'user867','2017-03-22','2019-04-04 00:37:31','2019-04-04 00:37:31'),(16,'Кнехт','1900-01-01','2019-04-30 12:32:28','2019-04-30 12:32:28'),(17,'Liu Kangh','1900-01-01','2019-04-30 12:36:34','2019-04-30 12:36:34'),(18,'Sub-Zero','1103-01-01','2019-04-30 12:36:34','2019-04-30 12:36:34'),(19,'Scorpion','1103-01-01','2019-04-30 12:36:34','2019-04-30 12:36:34'),(20,'Raiden','0000-00-01','2019-04-30 12:36:34','2019-04-30 12:36:34');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `watchlog_users` AFTER INSERT ON `users` FOR EACH ROW BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `cat2`
--

/*!50001 DROP VIEW IF EXISTS `cat2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=TEMPTABLE */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cat2` AS select `catalogs`.`id` AS `id`,`catalogs`.`name` AS `name` from `catalogs` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `last5str`
--

/*!50001 DROP VIEW IF EXISTS `last5str`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `last5str` AS select `datetbl`.`created_at` AS `created_at` from `datetbl` order by `datetbl`.`created_at` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `prods_desc`
--

/*!50001 DROP VIEW IF EXISTS `prods_desc`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp866 */;
/*!50001 SET character_set_results     = cp866 */;
/*!50001 SET collation_connection      = cp866_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `prods_desc` (`prod_id`,`prod_name`,`cat_name`) AS select `p`.`id` AS `prod_id`,`p`.`name` AS `name`,`cat`.`name` AS `name` from (`products` `p` left join `catalogs` `cat` on((`p`.`catalog_id` = `cat`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-30 23:24:21
