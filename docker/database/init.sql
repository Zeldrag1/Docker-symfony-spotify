/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.24-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: database    Database: sportify
-- ------------------------------------------------------
-- Server version	10.6.24-MariaDB-ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spotify_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1599687A905FC5C` (`spotify_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'5wQ8DuXAlRz7HtLTjWnUyY','Kazzey'),(2,'4WovDiH9G00jE0PpFotav0','Under Kazzey'),(3,'5NM65Y5uGN6Z9X5Uh3w8iV','Mofak'),(4,'5RT1khA0pYyy3lWRuSrbpj','Kazzey'),(5,'66Ok6bgC570sHkw08N20pZ','OBOY'),(6,'44BwcqsS9V20HWSeql39ah','Inoxtag'),(7,'4reog9Hn84AuUWvGX5a2Yq','Zed'),(8,'6rIeSm25Y2fZollukgy3QA','Dj Kazteyano'),(9,'67saEtRbi6607iuCs0tqrK','KAZEY J'),(10,'1ntQKIMIgESKpKoNXVBvQg','Kaaris'),(11,'6jvRzmQ1J8Kr2QEi6JzQmh','XL Middleton');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist_user`
--

DROP TABLE IF EXISTS `artist_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_user` (
  `artist_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`artist_id`,`user_id`),
  KEY `IDX_312D50D6B7970CF8` (`artist_id`),
  KEY `IDX_312D50D6A76ED395` (`user_id`),
  CONSTRAINT `FK_312D50D6A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_312D50D6B7970CF8` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_user`
--

LOCK TABLES `artist_user` WRITE;
/*!40000 ALTER TABLE `artist_user` DISABLE KEYS */;
INSERT INTO `artist_user` VALUES (2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1);
/*!40000 ALTER TABLE `artist_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20251021130023','2025-12-24 12:49:45',48),('DoctrineMigrations\\Version20251103083236','2025-12-24 12:49:45',19),('DoctrineMigrations\\Version20251103102812','2025-12-24 12:49:45',100),('DoctrineMigrations\\Version20251103154232','2025-12-24 12:49:45',101);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `track` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disc_number` int(11) DEFAULT NULL,
  `duration_ms` int(11) DEFAULT NULL,
  `explicit` tinyint(1) DEFAULT NULL,
  `isrc` longtext DEFAULT NULL,
  `spotify_url` longtext NOT NULL,
  `href` longtext DEFAULT NULL,
  `spotify_id` longtext DEFAULT NULL,
  `is_local` tinyint(1) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `popularity` int(11) DEFAULT NULL,
  `preview_url` longtext DEFAULT NULL,
  `track_number` int(11) DEFAULT NULL,
  `type` longtext DEFAULT NULL,
  `uri` longtext DEFAULT NULL,
  `picture_link` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

LOCK TABLES `track` WRITE;
/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES (1,NULL,NULL,NULL,NULL,'#',NULL,'6uKrzeMSK1ZBO55HUMDBEQ',NULL,'Over',NULL,NULL,NULL,NULL,NULL,NULL),(2,NULL,NULL,NULL,NULL,'#',NULL,'2auWvIfCr5N2FMp8M80hP5',NULL,'Abdelhak',NULL,NULL,NULL,NULL,NULL,NULL),(3,NULL,NULL,NULL,NULL,'#',NULL,'2VU4wVMHblObJYz0IR52so',NULL,'Make Your Move',NULL,NULL,NULL,NULL,NULL,NULL),(4,NULL,NULL,NULL,NULL,'#',NULL,'5PBudmNkDPhNUAZM1vyU3d',NULL,'Motha Funk',NULL,NULL,NULL,NULL,NULL,NULL),(5,NULL,NULL,NULL,NULL,'#',NULL,'6v5Z0a4b3DmjIKA4htP8vl',NULL,'Zouk-la Sé Sel Médikaman Nou Ni',NULL,NULL,NULL,NULL,NULL,NULL),(6,NULL,NULL,NULL,NULL,'#',NULL,'0NVDBbz6iV49RgvCP2bMsd',NULL,'ALZ',NULL,NULL,NULL,NULL,NULL,NULL),(7,NULL,NULL,NULL,NULL,'#',NULL,'57FAvwePLy1PxLF3tglyac',NULL,'Snapchat',NULL,NULL,NULL,NULL,NULL,NULL),(8,NULL,NULL,NULL,NULL,'#',NULL,'6t84yOrkPAouma0bbGGYOO',NULL,'La main verte - Live',NULL,NULL,NULL,NULL,NULL,NULL),(9,NULL,NULL,NULL,NULL,'#',NULL,'2uxTJ3a5PfQK4YuWOXPwFm',NULL,'Serre-moi',NULL,NULL,NULL,NULL,NULL,NULL),(10,NULL,NULL,NULL,NULL,'#',NULL,'1zXuvkxCR9lLvnS7TppDMW',NULL,'Toi et moi',NULL,NULL,NULL,NULL,NULL,NULL),(11,NULL,NULL,NULL,NULL,'#',NULL,'06MTB7yqOYcJbzEZFyBk7Q',NULL,'Ce que l\'on s\'aime',NULL,NULL,NULL,NULL,NULL,NULL),(12,NULL,NULL,NULL,NULL,'#',NULL,'0UZtknI7pCLAVGtHPLIYXZ',NULL,'Marley',NULL,NULL,NULL,NULL,NULL,NULL),(13,NULL,NULL,NULL,NULL,'#',NULL,'0USQrLiSMnzlaoMKkgIaT6',NULL,'Désolé pour hier soir XXV - Remix 2020',NULL,NULL,NULL,NULL,NULL,NULL),(14,NULL,NULL,NULL,NULL,'#',NULL,'54mFoJPjiQkgCb3Ium4yoJ',NULL,'Au café du canal',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`)),
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'test@test.com','[]','$2y$13$GVHJfcLUvkOmf5aiWDgGsuk9WZbCG2H5KST6k9ruS2FbRsWQBKE82');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_favorites`
--

DROP TABLE IF EXISTS `user_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorites` (
  `user_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`track_id`),
  KEY `IDX_E489ED11A76ED395` (`user_id`),
  KEY `IDX_E489ED115ED23C43` (`track_id`),
  CONSTRAINT `FK_E489ED115ED23C43` FOREIGN KEY (`track_id`) REFERENCES `track` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_E489ED11A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_favorites`
--

LOCK TABLES `user_favorites` WRITE;
/*!40000 ALTER TABLE `user_favorites` DISABLE KEYS */;
INSERT INTO `user_favorites` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14);
/*!40000 ALTER TABLE `user_favorites` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-24 13:11:21
