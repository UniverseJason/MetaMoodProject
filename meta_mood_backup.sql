-- MySQL dump 10.13  Distrib 8.0.32, for macos13.0 (arm64)
--
-- Host: ls-249ad327ce44da9463f737ece7b6de0d2b258dc1.cjdpzq5pew4s.us-east-2.rds.amazonaws.com    Database: meta_mood
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `backup_reddit_comment`
--

DROP TABLE IF EXISTS `backup_reddit_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_reddit_comment` (
  `auto_index` int NOT NULL AUTO_INCREMENT,
  `body` text,
  `author` text,
  `controversiality` int DEFAULT NULL,
  `link_id` text,
  `id` text,
  PRIMARY KEY (`auto_index`),
  FULLTEXT KEY `author` (`author`)
) ENGINE=InnoDB AUTO_INCREMENT=44998892 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `counts`
--

DROP TABLE IF EXISTS `counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `counts` (
  `spotify-tracks` int DEFAULT NULL,
  `reddit-comments` int DEFAULT NULL,
  `tweets` int DEFAULT NULL,
  `entry` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `new_reddit_comment`
--

DROP TABLE IF EXISTS `new_reddit_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_reddit_comment` (
  `auto_index` int NOT NULL AUTO_INCREMENT,
  `body` text,
  `emotion` int DEFAULT NULL,
  PRIMARY KEY (`auto_index`),
  KEY `emotion` (`emotion`)
) ENGINE=InnoDB AUTO_INCREMENT=57119982 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_reddit_comment_AFTER_INSERT` AFTER INSERT ON `new_reddit_comment` FOR EACH ROW BEGIN
	CALL CALC_REDDIT_EMOTION_SUM();
    CALL COUNT_REDDIT_COMMENTS();
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_reddit_comment_AFTER_UPDATE` AFTER UPDATE ON `new_reddit_comment` FOR EACH ROW BEGIN
	CALL CALC_REDDIT_EMOTION_SUM();
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_reddit_comment_AFTER_DELETE` AFTER DELETE ON `new_reddit_comment` FOR EACH ROW BEGIN
	CALL CALC_REDDIT_EMOTION_SUM();
    CALL COUNT_REDDIT_COMMENTS();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `new_spotify_track`
--

DROP TABLE IF EXISTS `new_spotify_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_spotify_track` (
  `auto_index` int NOT NULL AUTO_INCREMENT,
  `track_id` varchar(64) DEFAULT NULL,
  `album_id` text,
  `name` text,
  `track_href` text,
  `cover_image_url` text,
  `release_date` text,
  `preview_url` text,
  `popularity` int DEFAULT NULL,
  `acousticness` double DEFAULT NULL,
  `danceability` double DEFAULT NULL,
  `energy` double DEFAULT NULL,
  `liveness` double DEFAULT NULL,
  `loudness` double DEFAULT NULL,
  `speechiness` double DEFAULT NULL,
  `tempo` double DEFAULT NULL,
  `instrumentalness` double DEFAULT NULL,
  `valence` double DEFAULT NULL,
  `emotion` int DEFAULT NULL,
  PRIMARY KEY (`auto_index`),
  FULLTEXT KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1805018 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_spotify_track_AFTER_INSERT` AFTER INSERT ON `new_spotify_track` FOR EACH ROW BEGIN
	CALL CALC_SPOTIFY_TRACK_METRIC_AVERAGES();
	CALL CALC_SPOTIFY_EMOTION_SUM();
    CALL COUNT_SPOTIFY_TRACKS();
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_spotify_track_AFTER_UPDATE` AFTER UPDATE ON `new_spotify_track` FOR EACH ROW BEGIN
	CALL CALC_SPOTIFY_TRACK_METRIC_AVERAGES();
	CALL CALC_SPOTIFY_EMOTION_SUM();
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_spotify_track_AFTER_DELETE` AFTER DELETE ON `new_spotify_track` FOR EACH ROW BEGIN
	CALL CALC_SPOTIFY_TRACK_METRIC_AVERAGES();
	CALL CALC_SPOTIFY_EMOTION_SUM();
    CALL COUNT_SPOTIFY_TRACKS();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `new_twitter_table`
--

DROP TABLE IF EXISTS `new_twitter_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_twitter_table` (
  `auto_index` int NOT NULL AUTO_INCREMENT,
  `tweet` text COMMENT 'comment on twitter',
  `emotion` int DEFAULT NULL,
  PRIMARY KEY (`auto_index`),
  FULLTEXT KEY `tweet` (`tweet`)
) ENGINE=InnoDB AUTO_INCREMENT=2538807 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_twitter_table_AFTER_INSERT` AFTER INSERT ON `new_twitter_table` FOR EACH ROW BEGIN
	CALL CALC_TWITTER_EMOTION_SUM();
    CALL COUNT_TWEETS();
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_twitter_table_AFTER_UPDATE` AFTER UPDATE ON `new_twitter_table` FOR EACH ROW BEGIN
	CALL CALC_TWITTER_EMOTION_SUM();
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `new_twitter_table_AFTER_DELETE` AFTER DELETE ON `new_twitter_table` FOR EACH ROW BEGIN
	CALL CALC_TWITTER_EMOTION_SUM();
    CALL COUNT_TWEETS();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reddit_emotion_sum`
--

DROP TABLE IF EXISTS `reddit_emotion_sum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reddit_emotion_sum` (
  `anger` int DEFAULT NULL,
  `fear` int DEFAULT NULL,
  `happy` int DEFAULT NULL,
  `love` int DEFAULT NULL,
  `sad` int DEFAULT NULL,
  `surprise` int DEFAULT NULL,
  `entry` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spotify_emotion_sum`
--

DROP TABLE IF EXISTS `spotify_emotion_sum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spotify_emotion_sum` (
  `anger` int DEFAULT NULL,
  `fear` int DEFAULT NULL,
  `happy` int DEFAULT NULL,
  `love` int DEFAULT NULL,
  `sad` int DEFAULT NULL,
  `surprise` int DEFAULT NULL,
  `entry` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spotify_metric_averages`
--

DROP TABLE IF EXISTS `spotify_metric_averages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spotify_metric_averages` (
  `acousticness` double DEFAULT NULL,
  `danceability` double DEFAULT NULL,
  `energy` double DEFAULT NULL,
  `liveness` double DEFAULT NULL,
  `speechiness` double DEFAULT NULL,
  `instrumentalness` double DEFAULT NULL,
  `valence` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spotify_track`
--

DROP TABLE IF EXISTS `spotify_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spotify_track` (
  `track_id` varchar(64) NOT NULL,
  `album_id` text,
  `name` text,
  `track_href` text,
  `cover_image_url` text,
  `release_date` text,
  `preview_url` text,
  `popularity` int DEFAULT NULL,
  `acousticness` double DEFAULT NULL,
  `danceability` double DEFAULT NULL,
  `energy` double DEFAULT NULL,
  `liveness` double DEFAULT NULL,
  `loudness` double DEFAULT NULL,
  `speechiness` double DEFAULT NULL,
  `tempo` double DEFAULT NULL,
  `instrumentalness` double DEFAULT NULL,
  `valence` double DEFAULT NULL,
  `auto_index` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`auto_index`),
  UNIQUE KEY `track_id` (`track_id`),
  FULLTEXT KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1805018 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `RECALC_SPOTIFY_TRACK_METRIC_AVERAGES_AFT_INSERT` AFTER INSERT ON `spotify_track` FOR EACH ROW BEGIN
	CALL CALC_SPOTIFY_TRACK_METRIC_AVERAGES();
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `RECOUNT_SPOTIFY_TRACKS_AFT_INSERT` AFTER INSERT ON `spotify_track` FOR EACH ROW BEGIN
	CALL COUNT_SPOTIFY_TRACKS();
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
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `RECALC_SPOTIFY_TRACK_METRIC_AVERAGES_AFT_UPDATE` AFTER UPDATE ON `spotify_track` FOR EACH ROW BEGIN
	CALL CALC_SPOTIFY_TRACK_METRIC_AVERAGES();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `twitter_emotion_sum`
--

DROP TABLE IF EXISTS `twitter_emotion_sum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `twitter_emotion_sum` (
  `anger` int DEFAULT NULL,
  `fear` int DEFAULT NULL,
  `happy` int DEFAULT NULL,
  `love` int DEFAULT NULL,
  `sad` int DEFAULT NULL,
  `surprise` int DEFAULT NULL,
  `entry` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'meta_mood'
--

--
-- Dumping routines for database 'meta_mood'
--
/*!50003 DROP PROCEDURE IF EXISTS `CALC_REDDIT_EMOTION_SUM` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `CALC_REDDIT_EMOTION_SUM`()
BEGIN
DECLARE anger, fear, happy, love, sad, surprise INT;

SELECT COUNT(emotion) FROM new_reddit_comment as t WHERE emotion=0 INTO anger;
SELECT COUNT(emotion) FROM new_reddit_comment as t WHERE emotion=1 INTO fear;
SELECT COUNT(emotion) FROM new_reddit_comment as t WHERE emotion=2 INTO happy;
SELECT COUNT(emotion) FROM new_reddit_comment as t WHERE emotion=3 INTO love;
SELECT COUNT(emotion) FROM new_reddit_comment as t WHERE emotion=4 INTO sad;
SELECT COUNT(emotion) FROM new_reddit_comment as t WHERE emotion=5 INTO surprise;

UPDATE reddit_emotion_sum
SET `anger`=anger, `fear`=fear, `happy`=happy, `love`=love, `sad`=sad, `surprise`=surprise WHERE entry=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CALC_SPOTIFY_EMOTION_SUM` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `CALC_SPOTIFY_EMOTION_SUM`()
BEGIN
DECLARE anger, fear, happy, love, sad, surprise INT;

SELECT COUNT(emotion) FROM new_spotify_track as t WHERE emotion=0 INTO anger;
SELECT COUNT(emotion) FROM new_spotify_track as t WHERE emotion=1 INTO fear;
SELECT COUNT(emotion) FROM new_spotify_track as t WHERE emotion=2 INTO happy;
SELECT COUNT(emotion) FROM new_spotify_track as t WHERE emotion=3 INTO love;
SELECT COUNT(emotion) FROM new_spotify_track as t WHERE emotion=4 INTO sad;
SELECT COUNT(emotion) FROM new_spotify_track as t WHERE emotion=5 INTO surprise;

UPDATE spotify_emotion_sum
SET `anger`=anger, `fear`=fear, `happy`=happy, `love`=love, `sad`=sad, `surprise`=surprise WHERE entry=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CALC_SPOTIFY_TRACK_METRIC_AVERAGES` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `CALC_SPOTIFY_TRACK_METRIC_AVERAGES`()
BEGIN

	DELETE FROM spotify_metric_averages;
    INSERT INTO spotify_metric_averages
    (
		acousticness,
        danceability,
        energy,
        liveness,
        speechiness,
        instrumentalness,
        valence
	)
    SELECT AVG(acousticness), AVG(danceability), AVG(energy), AVG(liveness), AVG(speechiness), AVG(instrumentalness), AVG(valence) FROM new_spotify_track;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CALC_TWITTER_EMOTION_SUM` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `CALC_TWITTER_EMOTION_SUM`()
BEGIN
DECLARE anger, fear, happy, love, sad, surprise INT;

SELECT COUNT(emotion) FROM new_twitter_table as t WHERE emotion=0 INTO anger;
SELECT COUNT(emotion) FROM new_twitter_table as t WHERE emotion=1 INTO fear;
SELECT COUNT(emotion) FROM new_twitter_table as t WHERE emotion=2 INTO happy;
SELECT COUNT(emotion) FROM new_twitter_table as t WHERE emotion=3 INTO love;
SELECT COUNT(emotion) FROM new_twitter_table as t WHERE emotion=4 INTO sad;
SELECT COUNT(emotion) FROM new_twitter_table as t WHERE emotion=5 INTO surprise;

UPDATE twitter_emotion_sum
SET `anger`=anger, `fear`=fear, `happy`=happy, `love`=love, `sad`=sad, `surprise`=surprise WHERE entry=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COUNT_REDDIT_COMMENTS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `COUNT_REDDIT_COMMENTS`()
BEGIN

DECLARE c INT;
SELECT COUNT(body) FROM new_reddit_comment INTO c;
UPDATE counts
SET `reddit-comments`=c WHERE entry=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COUNT_SPOTIFY_TRACKS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `COUNT_SPOTIFY_TRACKS`()
BEGIN
DECLARE c INT;
SELECT COUNT(track_id) FROM new_spotify_track INTO c;
UPDATE counts
SET `spotify-tracks`=c WHERE entry=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `COUNT_TWEETS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `COUNT_TWEETS`()
BEGIN

DECLARE c INT;
SELECT COUNT(*) FROM new_twitter_table INTO c;
UPDATE counts
SET `tweets`=c WHERE entry=1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_REDDIT_COMMENTS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `GET_REDDIT_COMMENTS`(
	IN PageSize INT,
    IN PageOffset INT,
    IN `Search` INT,
    IN SortBy VARCHAR(20))
BEGIN
	SELECT `t`.`body` AS `Body`, `t`.`emotion` AS `Emotion`
	FROM (
		SELECT `s`.`body`, `s`.`emotion`
		FROM `new_reddit_comment` AS `s`
		WHERE `s`.`emotion`=Search OR `Search`='' OR `Search` IS NULL
		LIMIT PageSize OFFSET PageOffset
	) AS `t`
	ORDER BY 
    CASE WHEN SortBy = 'Body' THEN t.Body END,
    CASE WHEN SortBy = 'Emotion' THEN t.Emotion END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_REDDIT_COMMENTS_COUNT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `GET_REDDIT_COMMENTS_COUNT`(
    IN `Search` INT
    )
BEGIN
	SELECT COUNT(*)
	FROM `new_reddit_comment` AS `s`
	WHERE emotion=`Search`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_SPOTIFY_TRACKS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `GET_SPOTIFY_TRACKS`(
	IN PageSize INT,
    IN PageOffset INT,
    IN `Search` TEXT,
    IN SortBy VARCHAR(20))
BEGIN
	SELECT `t`.`name` AS `Name`, `t`.`release_date` AS `ReleaseDate`, `t`.`popularity` AS `Popularity`, `t`.`acousticness` AS `Acousticness`, `t`.`danceability` AS `Danceability`, `t`.`energy` AS `Energy`, `t`.`liveness` AS `Liveness`, `t`.`loudness` AS `Loudness`, `t`.`speechiness` AS `Speechiness`, `t`.`tempo` AS `Tempo`, `t`.`instrumentalness` AS `Instrumentalness`, `t`.`valence` AS `Valence`, `t`.`emotion` AS `Emotion`, `t`.`cover_image_url` AS `CoverImageURL`
	FROM (
		SELECT `s`.`acousticness`, `s`.`danceability`, `s`.`energy`, `s`.`instrumentalness`, `s`.`liveness`, `s`.`loudness`, `s`.`name`, `s`.`popularity`, `s`.`release_date`, `s`.`speechiness`, `s`.`tempo`, `s`.`valence`, `s`.`emotion`, `s`.`cover_image_url`
		FROM `new_spotify_track` AS `s`
		WHERE MATCH(`s`.`name`) AGAINST (`Search`) OR `Search`='' OR `Search` IS NULL
		LIMIT PageSize OFFSET PageOffset
	) AS `t`
	ORDER BY 
    CASE WHEN SortBy = 'Name' THEN t.Name END,
    CASE WHEN SortBy = 'ReleaseDate' THEN ReleaseDate END,
    CASE WHEN SortBy = 'Popularity' THEN Popularity END,
    CASE WHEN SortBy = 'Acousticness' THEN Acousticness END,
    CASE WHEN SortBy = 'Danceability' THEN Danceability END,
    CASE WHEN SortBy = 'Energy' THEN Energy END,
    CASE WHEN SortBy = 'Liveness' THEN Liveness END,
    CASE WHEN SortBy = 'Loudness' THEN Loudness END,
    CASE WHEN SortBy = 'Speechiness' THEN Speechiness END,
    CASE WHEN SortBy = 'Tempo' THEN Tempo END,
    CASE WHEN SortBy = 'Instrumentalness' THEN Instrumentalness END,
    CASE WHEN SortBy = 'Valence' THEN Valence END,
    CASE WHEN SortBy = 'Emotion' THEN Emotion END,
    CASE WHEN SortBy = 'CoverImageUrl' THEN Emotion END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_SPOTIFY_TRACKS_COUNT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `GET_SPOTIFY_TRACKS_COUNT`(
    IN `Search` TEXT
    )
BEGIN
	SELECT COUNT(*)
	FROM `new_spotify_track` AS `s`
	WHERE MATCH(`s`.`name`) AGAINST (`Search`);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_TWEETS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `GET_TWEETS`(
	IN PageSize INT,
    IN PageOffset INT,
    IN `Search` TEXT,
    IN SortBy VARCHAR(20))
BEGIN
	SELECT `t`.`tweet` AS `Tweet`, `t`.`Emotion` AS `Emotion`
	FROM (
		SELECT `s`.`tweet`, `s`.`emotion`
		FROM `new_twitter_table` AS `s`
		WHERE MATCH(`s`.`tweet`) AGAINST (`Search`) OR `Search`='' OR `Search` IS NULL
		LIMIT PageSize OFFSET PageOffset
	) AS `t`
	ORDER BY 
    CASE WHEN SortBy = 'Tweet' THEN t.Tweet END,
    CASE WHEN SortBy = 'Emotion' THEN t.Emotion END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_TWEETS_COUNT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `GET_TWEETS_COUNT`(
    IN `Search` TEXT
    )
BEGIN
	SELECT COUNT(*)
	FROM `new_twitter_table` AS `s`
	WHERE MATCH(`s`.`tweet`) AGAINST (`Search`);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-01 11:57:44
