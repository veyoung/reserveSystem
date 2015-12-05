/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.6.21-log : Database - customize_form
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`customize_form` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `customize_form`;

/*Table structure for table `reserve_record` */

DROP TABLE IF EXISTS `reserve_record`;

CREATE TABLE `reserve_record` (
  `id` bigint(20) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `mobile` varchar(60) DEFAULT NULL,
  `id_number` varchar(60) DEFAULT NULL,
  `id_photo` mediumblob,
  `reserve_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `description` varchar(768) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `reserve_record` */


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;