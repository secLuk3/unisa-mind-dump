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
-- Table structure for table `prenotazione`
--

DROP TABLE IF EXISTS `prenotazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenotazione` (
  `CodiceStruttura` int(11) NOT NULL,
  `NomeCentro` varchar(30) NOT NULL,
  `CfSegretario` varchar(16) NOT NULL,
  `Data` date NOT NULL,
  `Ora` time NOT NULL,
  PRIMARY KEY (`CodiceStruttura`,`NomeCentro`,`CfSegretario`,`Data`,`Ora`),
  KEY `NomeCentro` (`NomeCentro`),
  KEY `CfSegretario` (`CfSegretario`),
  CONSTRAINT `prenotazione_ibfk_1` FOREIGN KEY (`CodiceStruttura`) REFERENCES `struttura` (`Codice`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prenotazione_ibfk_2` FOREIGN KEY (`NomeCentro`) REFERENCES `struttura` (`NomeCentro`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prenotazione_ibfk_3` FOREIGN KEY (`CfSegretario`) REFERENCES `segretario` (`Cf`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenotazione`
--

LOCK TABLES `prenotazione` WRITE;
/*!40000 ALTER TABLE `prenotazione` DISABLE KEYS */;
INSERT INTO `prenotazione` VALUES (3,'Verdi\'s Fitness Center','ANGLALBT75','2019-11-22','13:30:00'),(8,'Gold Gym','ANGLALBT75','2019-04-01','18:45:00'),(4,'Atletic Sport Center','CBNKRT87','2019-06-06','19:10:00'),(1,'Atletic Sport Center','CR7RNDL','2019-05-13','10:00:00'),(2,'Atletic Sport Center','CR7RNDL','2019-11-20','20:30:00'),(3,'gold gym','cr7rndl','2019-01-01','17:00:00'),(4,'Atletic Sport Center','CR7RNDL','2018-02-26','21:30:00'),(7,'gold gym','cr7rndl','2019-01-01','18:00:00'),(7,'gold gym','cr7rndl','2019-01-06','15:00:00'),(7,'gold gym','cr7rndl','2019-01-23','16:00:00'),(7,'gold gym','cr7rndl','2019-08-09','12:00:00'),(7,'Gold Gym','CR7RNDL','2019-08-20','15:00:00'),(7,'gold gym','cr7rndl','2019-08-20','16:00:00'),(8,'gold gym','cr7rndl','2019-08-09','12:00:00');
/*!40000 ALTER TABLE `prenotazione` ENABLE KEYS */;
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
