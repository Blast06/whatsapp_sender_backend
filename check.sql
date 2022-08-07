CREATE DATABASE  IF NOT EXISTS `checkdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `checkdb`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: checkdb
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aplicativo`
--

DROP TABLE IF EXISTS `aplicativo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aplicativo` (
  `id_aplicativo` int NOT NULL,
  `aplicativo` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `restringir` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Cuando no se restringe la agencia y se quiere notificar solicitudes solo entre mismos clientes de la misma app. ',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `id_registro` int DEFAULT NULL,
  `id_actualizo` int DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_aplicativo`),
  KEY `fk_aplicativo__clienteRegistro_idx` (`id_registro`),
  KEY `fk_aplicativo__clienteActualizo_idx` (`id_actualizo`),
  CONSTRAINT `fk_aplicativo__clienteActualizo` FOREIGN KEY (`id_actualizo`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_aplicativo__clienteRegistro` FOREIGN KEY (`id_registro`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aplicativo`
--

/*!40000 ALTER TABLE `aplicativo` DISABLE KEYS */;
INSERT  IGNORE INTO `aplicativo` VALUES (1000001,'Check',0,1,NULL,NULL,'2021-09-12 16:24:03','2021-09-12 16:24:13');
/*!40000 ALTER TABLE `aplicativo` ENABLE KEYS */;

--
-- Table structure for table `archivo`
--

DROP TABLE IF EXISTS `archivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archivo` (
  `id_archivo` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `detalle` varchar(125) NOT NULL,
  `archivo` varchar(45) NOT NULL,
  `eliminada` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `orden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_archivo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivo`
--

/*!40000 ALTER TABLE `archivo` DISABLE KEYS */;
INSERT  IGNORE INTO `archivo` VALUES (1,233634,'App Delivery UDEMY','233634-1631463932735.jpeg',0,'2021-09-12 16:25:32','2021-09-12 16:26:44',0),(2,233634,'Chatbot ','233634-1631463992166.jpeg',0,'2021-09-12 16:26:32','2021-09-12 16:26:32',0);
/*!40000 ALTER TABLE `archivo` ENABLE KEYS */;

--
-- Table structure for table `campania`
--

DROP TABLE IF EXISTS `campania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campania` (
  `id_campania` bigint NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `fecha` date NOT NULL,
  `alias` varchar(45) NOT NULL,
  `celular` varchar(45) NOT NULL,
  `etiqueta` text NOT NULL,
  `campania` text NOT NULL,
  `a_enviar` int NOT NULL,
  `enviadas` int NOT NULL DEFAULT '0',
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_campania`),
  KEY `indx_id_cliente__fecha` (`id_cliente`,`fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campania`
--

/*!40000 ALTER TABLE `campania` DISABLE KEYS */;
/*!40000 ALTER TABLE `campania` ENABLE KEYS */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `campania_BEFORE_INSERT` BEFORE INSERT ON `campania` FOR EACH ROW BEGIN
    UPDATE `checkdb`.`whatsapp` SET `enviadas` = enviadas + 1 WHERE `id_cliente` = NEW.id_cliente AND `celular` = NEW.celular LIMIT 1;
	UPDATE `checkdb`.`cliente` SET `registros` = registros + 1 WHERE `id_cliente` = NEW.id_cliente LIMIT 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `id_aplicativo` int NOT NULL,
  `id_plataforma` int NOT NULL,
  `perfil` tinyint(1) NOT NULL DEFAULT '0',
  `history` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'History del perfil',
  `idFacebook` varchar(60) DEFAULT NULL,
  `idGoogle` varchar(60) DEFAULT NULL,
  `idApple` varchar(60) DEFAULT NULL,
  `codigoPais` varchar(5) NOT NULL DEFAULT '+593',
  `simCountryCode` varchar(5) NOT NULL DEFAULT 'EC',
  `celular` varchar(20) DEFAULT NULL,
  `smn` varchar(30) DEFAULT NULL,
  `celularValidado` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 celular no validado\n1 celular validado',
  `correo` varchar(125) NOT NULL,
  `correoValidado` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 correo no validado\n1 correo validado',
  `clave` varchar(45) DEFAULT NULL,
  `nombres` varchar(65) NOT NULL,
  `apellidos` varchar(65) NOT NULL,
  `sexo` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 no definido\n1 Mujer\n2 Hombre',
  `cedula` varchar(11) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `cambiarClave` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 cuando no es necesario que el usuario cambie su contraseña\\n2 cuando se debe obligar al usuario a cambiar la contraseña',
  `claveTemporal` varchar(45) DEFAULT NULL COMMENT 'sera la calve que se usara para ingresar al sistema, esto cuando el cliente recupera la clave varias veces',
  `link` varchar(125) NOT NULL DEFAULT '',
  `url` varchar(45) DEFAULT NULL COMMENT 'has para validar el correo electronico de un usuario mediante el uso de un link de validacion',
  `personalidad` varchar(125) DEFAULT NULL,
  `img` varchar(300) NOT NULL DEFAULT '',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `beta` json DEFAULT NULL,
  `id_registro` int DEFAULT NULL,
  `id_actualizo` int DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fecha_recupero` datetime DEFAULT NULL,
  `puntos` int unsigned NOT NULL DEFAULT '0',
  `direcciones` int unsigned NOT NULL DEFAULT '0',
  `calificaciones` int unsigned NOT NULL DEFAULT '0',
  `calificacion` double(10,2) unsigned NOT NULL DEFAULT '0.00',
  `likes` int unsigned NOT NULL DEFAULT '0',
  `views` int unsigned NOT NULL DEFAULT '0',
  `header` json DEFAULT NULL,
  `registros` int unsigned NOT NULL DEFAULT '0',
  `confirmados` int unsigned NOT NULL DEFAULT '0',
  `correctos` int unsigned NOT NULL DEFAULT '0',
  `canceladas` int unsigned NOT NULL DEFAULT '0',
  `meta` json NOT NULL,
  `on_line` tinyint(1) NOT NULL DEFAULT '0',
  `cio` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_ultima` datetime DEFAULT NULL,
  `bloqueado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_bloqueado` datetime DEFAULT NULL,
  `motivo_bloqueado` varchar(45) DEFAULT NULL,
  `id_urbe` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `unico_correo_aplicativo` (`id_aplicativo`,`correo`) /*!80000 INVISIBLE */,
  UNIQUE KEY `unico_celular_aplicativo` (`id_aplicativo`,`celular`) /*!80000 INVISIBLE */,
  UNIQUE KEY `unico_facebook_aplicativo` (`id_aplicativo`,`idFacebook`) /*!80000 INVISIBLE */,
  UNIQUE KEY `unico_cedula_aplicativo` (`id_aplicativo`,`cedula`) /*!80000 INVISIBLE */,
  UNIQUE KEY `unico_google_aplicativo` (`id_aplicativo`,`idGoogle`),
  UNIQUE KEY `unico_apple_aplicativo` (`id_aplicativo`,`idApple`),
  KEY `fk_cliente_aplicativo_idx` (`id_aplicativo`),
  KEY `fk_cliente_plataforma_idx` (`id_plataforma`),
  KEY `fk_cliente__clienteRegistro_idx` (`id_registro`),
  KEY `fk_cliente__clienteActualizo_idx` (`id_actualizo`),
  CONSTRAINT `fk_cliente__clienteActualizo` FOREIGN KEY (`id_actualizo`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cliente__clienteRegistro` FOREIGN KEY (`id_registro`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cliente_aplicativo` FOREIGN KEY (`id_aplicativo`) REFERENCES `aplicativo` (`id_aplicativo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_cliente_plataforma` FOREIGN KEY (`id_plataforma`) REFERENCES `plataforma` (`id_plataforma`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=233635 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT  IGNORE INTO `cliente` VALUES (233634,1000001,1,0,0,NULL,'113679206587049194172',NULL,'+593','EC','+593969901641',NULL,0,'juanpa.desert@gmail.com',1,'23e3666f2fb0e6042a94b8b3feaec3ed','Juan Pablo','',0,NULL,NULL,0,'2cb272adba6c6af5197be1da5b4c625e','','49bd271929e9a8835ff7cfa8825ea5ed',NULL,'https://lh3.googleusercontent.com/a-/AOh14GiJDVYQ7s9l1hyuZe_V3wRvcn0DO_KOV5FBwWzjbA',1,NULL,NULL,NULL,'2021-09-12 16:23:02','2021-09-12 16:32:07',NULL,0,0,0,0.00,0,11,'{\"headers\": {\"so\": \"28\", \"vs\": \"0.0.101\", \"iph\": \"true\", \"key\": \"f51787c3d20e2a2a9dbf0306a5dcc2ac\", \"red\": \"x\", \"host\": \"192.168.1.13\", \"imei\": \"763f897b3350a0bd6f130d64e8786fd5\", \"marca\": \"HUAWEI\", \"modelo\": \"ANELX3 910355C605E4R1P3\", \"system\": \"android\", \"referencia\": \"12.03.91\", \"user-agent\": \"Dart/2.13 (dart:io)\", \"content-type\": \"application/x-www-form-urlencoded; charset=utf-8\", \"idaplicativo\": \"1000001\", \"idplataforma\": \"1\", \"content-length\": \"102\", \"accept-encoding\": \"gzip\"}}',0,0,0,0,'{\"ipInfo\": {\"ip\": \"::ffff:192.168.1.13\", \"error\": \"Error occured while trying to process the information\"}, \"headers\": {\"so\": \"28\", \"vs\": \"0.0.101\", \"iph\": \"false\", \"key\": \"68517f2f6b7b2c96c4ea1b76a6b48f5a\", \"red\": \"x\", \"host\": \"192.168.1.13\", \"imei\": \"afcd1cbe8049845890f60e7ba4ef3625\", \"marca\": \"Google\", \"modelo\": \"PSR1180720075\", \"system\": \"android\", \"referencia\": \"12.03.91\", \"user-agent\": \"Dart/2.13 (dart:io)\", \"content-type\": \"application/x-www-form-urlencoded; charset=utf-8\", \"idaplicativo\": \"1000001\", \"idplataforma\": \"1\", \"content-length\": \"381\", \"accept-encoding\": \"gzip\"}}',0,0,NULL,0,NULL,NULL,0);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

--
-- Table structure for table `cliente_session`
--

DROP TABLE IF EXISTS `cliente_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_session` (
  `id_cliente` int NOT NULL,
  `imei` varchar(33) NOT NULL,
  `id_aplicativo` int NOT NULL,
  `id_plataforma` int NOT NULL,
  `on_line` tinyint(1) NOT NULL DEFAULT '1',
  `id_rastreo` int NOT NULL DEFAULT '0',
  `id` varchar(45) DEFAULT NULL,
  `auth` varchar(33) NOT NULL,
  `token` varchar(400) DEFAULT NULL,
  `activado` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 Iniciada,\\\\n0 Cerrada.',
  `marca` varchar(125) NOT NULL,
  `modelo` varchar(125) NOT NULL,
  `so` varchar(45) NOT NULL,
  `vs` varchar(45) NOT NULL,
  `meta` json DEFAULT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_cerrado` datetime DEFAULT NULL,
  `fecha_cambio_token` datetime DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `id_registro` int DEFAULT NULL,
  `id_actualizo` int DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rastrear` tinyint(1) NOT NULL DEFAULT '0',
  `lt` double(10,6) NOT NULL DEFAULT '0.000000',
  `lg` double(10,6) NOT NULL DEFAULT '0.000000',
  `utc` datetime DEFAULT NULL,
  PRIMARY KEY (`id_cliente`,`imei`),
  UNIQUE KEY `token_UNIQUE` (`token`),
  KEY `index_id_rastreo` (`id_rastreo`),
  CONSTRAINT `fk_clientePush_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_session`
--

/*!40000 ALTER TABLE `cliente_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente_session` ENABLE KEYS */;

--
-- Table structure for table `contacto`
--

DROP TABLE IF EXISTS `contacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacto` (
  `id_cliente` int NOT NULL,
  `celular` varchar(45) NOT NULL,
  `nombre` text NOT NULL,
  `etiqueta` text NOT NULL,
  `envio` int unsigned NOT NULL DEFAULT '0',
  `roto` int unsigned NOT NULL DEFAULT '0',
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`,`celular`),
  KEY `id_cliente` (`id_cliente`),
  FULLTEXT KEY `etiqueta` (`etiqueta`),
  FULLTEXT KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacto`
--

/*!40000 ALTER TABLE `contacto` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacto` ENABLE KEYS */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `contacto_AFTER_UPDATE` AFTER UPDATE ON `contacto` FOR EACH ROW BEGIN
	UPDATE `checkdb`.`cliente` SET `correctos` = correctos + 1 WHERE `id_cliente` = NEW.id_cliente LIMIT 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `enviada`
--

DROP TABLE IF EXISTS `enviada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enviada` (
  `id_campania` bigint NOT NULL,
  `celular` varchar(45) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_campania`,`celular`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enviada`
--

/*!40000 ALTER TABLE `enviada` DISABLE KEYS */;
/*!40000 ALTER TABLE `enviada` ENABLE KEYS */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `enviada_BEFORE_INSERT` BEFORE INSERT ON `enviada` FOR EACH ROW BEGIN
	UPDATE `checkdb`.`campania` SET `enviadas` = enviadas + 1 WHERE `id_campania` = NEW.id_campania LIMIT 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `etiqueta`
--

DROP TABLE IF EXISTS `etiqueta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etiqueta` (
  `id_cliente` int NOT NULL,
  `etiqueta` varchar(45) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`,`etiqueta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etiqueta`
--

/*!40000 ALTER TABLE `etiqueta` DISABLE KEYS */;
/*!40000 ALTER TABLE `etiqueta` ENABLE KEYS */;

--
-- Table structure for table `plataforma`
--

DROP TABLE IF EXISTS `plataforma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plataforma` (
  `id_plataforma` int NOT NULL,
  `plataforma` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `id_registro` int DEFAULT NULL,
  `id_actualizo` int DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_plataforma`),
  KEY `fk_plataforma__clienteRegistro_idx` (`id_registro`),
  KEY `fk_plataforma__clienteActualizo_idx` (`id_actualizo`),
  CONSTRAINT `fk_plataforma__clienteActualizo` FOREIGN KEY (`id_actualizo`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_plataforma__clienteRegistro` FOREIGN KEY (`id_registro`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plataforma`
--

/*!40000 ALTER TABLE `plataforma` DISABLE KEYS */;
INSERT  IGNORE INTO `plataforma` VALUES (1,'ANDROID',0,NULL,NULL,'2020-01-24 17:26:14','2020-01-24 17:26:14'),(2,'iOS',0,NULL,NULL,'2020-01-24 17:26:29','2020-01-24 17:26:29'),(932418999,'WEB',0,NULL,NULL,'2020-07-25 15:30:07','2020-07-25 15:39:17');
/*!40000 ALTER TABLE `plataforma` ENABLE KEYS */;

--
-- Table structure for table `whatsapp`
--

DROP TABLE IF EXISTS `whatsapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `whatsapp` (
  `id_cliente` bigint NOT NULL,
  `celular` varchar(45) NOT NULL,
  `alias` varchar(45) NOT NULL DEFAULT 'whatsapp',
  `session` json NOT NULL,
  `enviadas` int NOT NULL DEFAULT '0',
  `eliminada` bit(1) NOT NULL DEFAULT b'0',
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizo` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cliente`,`celular`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `whatsapp`
--

/*!40000 ALTER TABLE `whatsapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `whatsapp` ENABLE KEYS */;

--
-- Dumping events for database 'checkdb'
--

--
-- Dumping routines for database 'checkdb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-13 11:13:07
CREATE DATABASE  IF NOT EXISTS `checkdb_notificacion` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `checkdb_notificacion`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: checkdb_notificacion
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `mensaje`
--

DROP TABLE IF EXISTS `mensaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensaje` (
  `id_mensaje` int unsigned NOT NULL AUTO_INCREMENT,
  `id_aplicativo` int NOT NULL DEFAULT '1000001',
  `id_urbe` int NOT NULL DEFAULT '-1',
  `id_plataforma` int NOT NULL DEFAULT '-1',
  `perfil` tinyint(1) NOT NULL DEFAULT '-1' COMMENT '-1 todos, demas se usa el valor del perfil',
  `min_vs` smallint NOT NULL DEFAULT '0',
  `min_correctos` smallint NOT NULL DEFAULT '0',
  `isLista` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Descarta min_correctos en la lista',
  `hint` varchar(125) NOT NULL,
  `detalle` varchar(325) NOT NULL,
  `omitir` varchar(15) NOT NULL DEFAULT 'OMITIR',
  `boton` varchar(15) NOT NULL DEFAULT 'REVISAR',
  `img` varchar(255) NOT NULL,
  `datos` json NOT NULL COMMENT 'Tipo: 1//UrlLaunch\nTipo: 2//Navigator\nTipo: 3//Local',
  `desde` date NOT NULL,
  `hasta` date NOT NULL,
  `views` int NOT NULL DEFAULT '0',
  `ac_omitir` int NOT NULL DEFAULT '0',
  `ac_aceptar` int NOT NULL DEFAULT '0',
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `fehca-registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_mensaje`),
  KEY `desde` (`desde`),
  KEY `hasta` (`hasta`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensaje`
--

/*!40000 ALTER TABLE `mensaje` DISABLE KEYS */;
INSERT  IGNORE INTO `mensaje` VALUES (10000,1000001,-1,-1,-1,0,0,_binary '','Canjea tu SUPER descuento!','En tu propia APP de delivery','','ACEPTAR','https://firebasestorage.googleapis.com/v0/b/check-5d840.appspot.com/o/nt%2Fapp.jpeg?alt=media','{\"url\": \"https://store.planck.biz/app-delivery-udemy\", \"tipo\": \"1\"}','2021-09-11','2050-01-01',0,0,0,0,'2021-09-12 16:20:40'),(10001,1000001,-1,-1,-1,0,0,_binary '','Encuentrame en YouTube','Encuentra cupones exclusivos','','SUSCRIBIRSE','https://firebasestorage.googleapis.com/v0/b/check-5d840.appspot.com/o/nt%2Fyoutube.jpg?alt=media','{\"url\": \"https://www.youtube.com/channel/UCvKngBf-qMe1P9-Hwh1hk0g\", \"tipo\": \"1\"}','2021-09-11','2050-01-01',0,0,0,1,'2021-09-12 16:20:40');
/*!40000 ALTER TABLE `mensaje` ENABLE KEYS */;

--
-- Table structure for table `mensaje_leido`
--

DROP TABLE IF EXISTS `mensaje_leido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensaje_leido` (
  `id_mensaje` int unsigned NOT NULL,
  `id_cliente` int NOT NULL,
  `omitir` tinyint(1) DEFAULT NULL,
  `aceptar` tinyint(1) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_mensaje`,`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensaje_leido`
--

/*!40000 ALTER TABLE `mensaje_leido` DISABLE KEYS */;
/*!40000 ALTER TABLE `mensaje_leido` ENABLE KEYS */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mensaje_leido_AFTER_INSERT` AFTER INSERT ON `mensaje_leido` FOR EACH ROW BEGIN
	UPDATE `checkdb_notificacion`.`mensaje` SET `views` = views + 1 WHERE (`id_mensaje` = NEW.id_mensaje);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mensaje_leido_AFTER_UPDATE` AFTER UPDATE ON `mensaje_leido` FOR EACH ROW BEGIN

	IF OLD.omitir IS NULL AND NEW.omitir = 1 THEN
		UPDATE `checkdb_notificacion`.`mensaje` SET `ac_omitir` = ac_omitir + 1 WHERE (`id_mensaje` = NEW.id_mensaje);
	ELSEIF OLD.aceptar IS NULL AND NEW.aceptar = 1 THEN
		UPDATE `checkdb_notificacion`.`mensaje` SET `ac_aceptar` = ac_aceptar + 1 WHERE (`id_mensaje` = NEW.id_mensaje);
	END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'checkdb_notificacion'
--

--
-- Dumping routines for database 'checkdb_notificacion'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-13 11:13:07
