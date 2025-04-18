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
-- Table structure for table `coinvolgimento`
--

DROP TABLE IF EXISTS `coinvolgimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coinvolgimento` (
  `CfAllenatore` varchar(16) NOT NULL,
  `CodiceAttivita` int(11) NOT NULL,
  PRIMARY KEY (`CfAllenatore`,`CodiceAttivita`),
  KEY `CodiceAttivita` (`CodiceAttivita`),
  CONSTRAINT `coinvolgimento_ibfk_1` FOREIGN KEY (`CfAllenatore`) REFERENCES `allenatore` (`Cf`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coinvolgimento_ibfk_2` FOREIGN KEY (`CodiceAttivita`) REFERENCES `corso` (`CodiceAttivita`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coinvolgimento`
--

LOCK TABLES `coinvolgimento` WRITE;
/*!40000 ALTER TABLE `coinvolgimento` DISABLE KEYS */;
INSERT INTO `coinvolgimento` VALUES ('SRRMRZ85',1111),('BFFFDRC76',2222),('CNTANT74',3333),('ANCLTTCRL23',4444),('SMNNZG04',5555),('CNTANT74',7777);
/*!40000 ALTER TABLE `coinvolgimento` ENABLE KEYS */;
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
