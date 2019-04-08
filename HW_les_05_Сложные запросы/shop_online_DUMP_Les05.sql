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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Разделы интернет-магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,'Процессоры'),(2,'Мат.платы'),(12,'Видеокарты');
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Товарные позиции';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Intel Core i3-8100','Процессор для настольных ПК',7890.00,1,'2019-03-31 17:44:23','2019-03-31 17:44:23'),(2,'AMD FX-8320E','Процессор для настольных ПК',4780.00,1,'2019-03-31 17:44:23','2019-03-31 17:44:23'),(3,'AMD FX-8320','Процессор для настольных ПК',7120.00,1,'2019-03-31 17:44:23','2019-03-31 17:44:23'),(4,'Gigabyte H310M S2H, H310, Socket 1151-V2','Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2',4311.00,2,'2019-03-31 17:44:23','2019-04-06 14:59:31'),(5,'MSI B250M GAMING PRO','Материнская плата MSI B250M GAMING PRO',4098.60,2,'2019-03-31 17:44:23','2019-04-06 14:59:31'),(6,'One More prod','Good prod',8100.00,2,'2019-03-31 17:44:23','2019-04-06 14:59:31');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
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
-- Table structure for table `tab1`
--

DROP TABLE IF EXISTS `tab1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tab1` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT 'NoName',
  `collect` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab1`
--

LOCK TABLES `tab1` WRITE;
/*!40000 ALTER TABLE `tab1` DISABLE KEYS */;
INSERT INTO `tab1` VALUES (136,'Intel i7',NULL),(136,'NoName',NULL),(1,'Intel i7','{\"first\": \"Hello\", \"second\": \"World\"}');
/*!40000 ALTER TABLE `tab1` ENABLE KEYS */;
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
INSERT INTO `tbl1` VALUES ('fst1'),('fst2'),('fst3');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Покупатели';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Геннадий','1990-10-05','2019-03-25 20:21:11','2019-03-25 20:21:11'),(2,'Наталья','1984-11-12','2019-03-25 20:21:11','2019-03-25 20:21:11'),(3,'Александр','1985-05-20','2019-03-25 20:21:11','2019-03-25 20:21:11'),(4,'Сергей','1988-02-14','2019-03-25 20:21:11','2019-03-25 20:21:11'),(5,'Иван','1998-01-12','2019-03-25 20:21:11','2019-03-25 20:21:11'),(6,'Мария','2006-08-29','2019-03-25 20:21:11','2019-03-25 20:21:11'),(7,'Светлана','1988-02-04','2019-03-31 17:52:36','2019-03-31 17:52:36'),(8,'Олег','1998-03-20','2019-03-31 17:52:36','2019-03-31 17:52:36'),(9,'Юлия','2006-07-12','2019-03-31 17:52:36','2019-03-31 17:52:36'),(10,'user273','1993-10-10','2019-04-04 00:37:31','2019-04-04 00:37:31'),(11,'user17','1995-07-31','2019-04-04 00:37:31','2019-04-04 00:37:31'),(12,'user867','2017-03-22','2019-04-04 00:37:31','2019-04-04 00:37:31');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-09  0:32:06
