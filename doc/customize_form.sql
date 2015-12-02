/*
SQLyog Ultimate v8.32 
MySQL - 5.6.22 : Database - customize_form
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `customize_form`;

/*Table structure for table `reserve_record` */

CREATE TABLE `reserve_record` (
  `id` bigint(20) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `mobile` varchar(60) DEFAULT NULL,
  `id_number` varchar(60) DEFAULT NULL,
  `id_photo_url` varchar(150) DEFAULT NULL,
  `reserve_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `description` varchar(768) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `reserve_record` */

insert  into `reserve_record`(`id`,`name`,`mobile`,`id_number`,`id_photo_url`,`reserve_time`,`create_time`,`description`) values (715048848264448,'young','13817479353','342425199009230591','http://www.baidu.com','2015-12-02 15:06:18',NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
