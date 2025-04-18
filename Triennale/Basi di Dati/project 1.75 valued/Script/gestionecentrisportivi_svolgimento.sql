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
-- Table structure for table `svolgimento`
--

DROP TABLE IF EXISTS `svolgimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `svolgimento` (
  `CodiceAttivita` int(11) NOT NULL,
  `NomeCentro` varchar(30) NOT NULL,
  `CodiceStruttura` int(11) NOT NULL,
  `Data` date NOT NULL,
  `Ora` time NOT NULL,
  `Durata` time NOT NULL,
  PRIMARY KEY (`CodiceAttivita`,`NomeCentro`,`CodiceStruttura`,`Data`,`Ora`),
  KEY `NomeCentro` (`NomeCentro`),
  KEY `CodiceStruttura` (`CodiceStruttura`),
  CONSTRAINT `svolgimento_ibfk_1` FOREIGN KEY (`CodiceAttivita`) REFERENCES `attivita` (`Codice`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `svolgimento_ibfk_2` FOREIGN KEY (`NomeCentro`) REFERENCES `struttura` (`NomeCentro`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `svolgimento_ibfk_3` FOREIGN KEY (`CodiceStruttura`) REFERENCES `struttura` (`Codice`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `svolgimento`
--

LOCK TABLES `svolgimento` WRITE;
/*!40000 ALTER TABLE `svolgimento` DISABLE KEYS */;
INSERT INTO `svolgimento` VALUES (2222,'atletic sport center',4,'2018-01-04','16:00:00','01:00:00'),(2222,'gold gym',7,'2019-01-03','22:00:00','03:00:00'),(2222,'gold gym',8,'2019-01-05','14:00:00','01:00:00'),(3333,'atletic sport center',4,'2019-04-04','18:00:00','03:45:00'),(3333,'atletic Sport Center',4,'2019-08-01','18:00:00','02:00:00'),(3333,'atletic Sport Center',4,'2019-11-16','15:30:00','01:30:00'),(6666,'Gold Gym',7,'2019-04-10','16:00:00','03:00:00');
/*!40000 ALTER TABLE `svolgimento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-15 11:59:21
