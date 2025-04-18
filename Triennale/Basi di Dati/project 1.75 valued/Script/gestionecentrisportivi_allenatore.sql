-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: gestionecentrisportivi
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `allenatore`
--

DROP TABLE IF EXISTS `allenatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `allenatore` (
  `Cf` varchar(16) NOT NULL,
  `Nome` varchar(20) NOT NULL,
  `Cognome` varchar(20) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `TipoContratto` varchar(30) NOT NULL,
  `AnniEsperienza` int(11) NOT NULL,
  `TipoAllenatore` varchar(30) NOT NULL,
  `DocumentoSpecializzazione` varchar(40) DEFAULT NULL,
  `TipoSpecializzazione` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`Cf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allenatore`
--

LOCK TABLES `allenatore` WRITE;
/*!40000 ALTER TABLE `allenatore` DISABLE KEYS */;
INSERT INTO `allenatore` VALUES ('ANCLTTCRL23','Carlo','Ancelotti','346356086','Tempo indeterminato',15,'Ginnastica Correttiva','Laurea Scienze Motorie','4444'),('BFFFDRC76','Federico ','Buffa','3402367389','Tempo indeterminato',30,'Allenatore Basket','','2222'),('CNTANT74','Antonio','Conte','345740203','Tempo indeterminato',6,'Allenatore Calcistico','','3333'),('MTTDRL','matteo','della roca','2353546','indetre',34,'','',''),('SMNNZG04','Simone','Inzaghi','3463523613','Tempo indeterminato',9,'Nuoto','','5555'),('SRRMRZ85','Maurizio','Sarri','3463512367','Tempo determinato',2,'','','3333');
/*!40000 ALTER TABLE `allenatore` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-15 11:59:20
