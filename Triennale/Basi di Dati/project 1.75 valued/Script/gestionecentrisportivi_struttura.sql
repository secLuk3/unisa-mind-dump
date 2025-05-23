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
-- Table structure for table `struttura`
--

DROP TABLE IF EXISTS `struttura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `struttura` (
  `Codice` int(11) NOT NULL,
  `NomeCentro` varchar(30) NOT NULL,
  `Area` int(11) NOT NULL,
  `Tipo` varchar(20) NOT NULL,
  `TipoCampo` varchar(15) DEFAULT NULL,
  `Attrezzatura` bit(1) DEFAULT NULL,
  PRIMARY KEY (`Codice`,`NomeCentro`),
  KEY `NomeCentro` (`NomeCentro`),
  CONSTRAINT `struttura_ibfk_1` FOREIGN KEY (`NomeCentro`) REFERENCES `centro` (`Nome`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `struttura`
--

LOCK TABLES `struttura` WRITE;
/*!40000 ALTER TABLE `struttura` DISABLE KEYS */;
INSERT INTO `struttura` VALUES (1,'Atletic Sport Center',135,'Campo','All\'aperto',_binary '\0'),(2,'Atletic Sport Center',150,'Sala','',_binary ''),(3,'Verdi\'s Fitness Center',675,'Sala','',_binary '\0'),(4,'Atletic Sport Center',235,'Sala','',_binary ''),(5,'Atletic Sport Center',895,'Campo','Al chiuso',_binary '\0'),(6,'Verdi\'s Fitness Center',325,'Campo','Al chiuso',_binary '\0'),(7,'Gold Gym',1653,'Campo','Al chiuso',_binary ''),(8,'Gold Gym',1000,'Campo','All` aperto',_binary '\0'),(9,'Gold Gym',678,'Sala','Al chiuso',_binary '');
/*!40000 ALTER TABLE `struttura` ENABLE KEYS */;
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
