-- MySQL dump 10.15  Distrib 10.0.31-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ut_pos
-- ------------------------------------------------------
-- Server version	10.0.31-MariaDB-0ubuntu0.16.04.2

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
-- Table structure for table `tbl_barang`
--

DROP TABLE IF EXISTS `tbl_barang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_barang` (
  `barang_id` varchar(255) NOT NULL,
  `barang_toko_id` varchar(255) NOT NULL,
  `barang_kategori` varchar(255) DEFAULT NULL,
  `barang_name` varchar(255) DEFAULT NULL,
  `barang_harga` double NOT NULL,
  `barang_gambar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`barang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_barang`
--

LOCK TABLES `tbl_barang` WRITE;
/*!40000 ALTER TABLE `tbl_barang` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_barang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_kasir`
--

DROP TABLE IF EXISTS `tbl_kasir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_kasir` (
  `kasir_id` varchar(255) NOT NULL,
  `kasir_toko_id` varchar(255) NOT NULL,
  `kasir_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`kasir_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_kasir`
--

LOCK TABLES `tbl_kasir` WRITE;
/*!40000 ALTER TABLE `tbl_kasir` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_kasir` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_toko`
--

DROP TABLE IF EXISTS `tbl_toko`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_toko` (
  `toko_id` varchar(255) NOT NULL,
  `toko_nama` varchar(255) NOT NULL,
  `toko_alamat` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`toko_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_toko`
--

LOCK TABLES `tbl_toko` WRITE;
/*!40000 ALTER TABLE `tbl_toko` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_toko` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_transaksi`
--

DROP TABLE IF EXISTS `tbl_transaksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_transaksi` (
  `transaksi_invoice` varchar(255) NOT NULL,
  `transaksi_tanggal` datetime NOT NULL,
  `transaksi_toko_id` varchar(255) NOT NULL,
  `transaksi_kasir_id` varchar(255) NOT NULL,
  `transaksi_barang_id` varchar(255) NOT NULL,
  `transaksi_jumlah` double NOT NULL,
  `transaksi_harga` double NOT NULL,
  `transaksi_pajak` double NOT NULL,
  `transaksi_potongan` double NOT NULL,
  `transaksi_total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_transaksi`
--

LOCK TABLES `tbl_transaksi` WRITE;
/*!40000 ALTER TABLE `tbl_transaksi` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_transaksi` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-14 13:05:43

DELIMITER $$
DROP procedure IF EXISTS `sp_transaksi` $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_transaksi`(
    IN p_invoice VARCHAR(255),
    IN p_tanggal datetime,
    IN p_toko VARCHAR(255),
    IN p_kasir VARCHAR(255),
    IN p_barang VARCHAR(255),
    IN p_jumlah double,
    IN p_harga double,
    IN p_pajak double,
    IN p_potongan double,
    IN p_total double
)
BEGIN
insert into tbl_transaksi(
            transaksi_invoice,
            transaksi_tanggal,
            transaksi_toko_id,
            transaksi_kasir_id,
            transaksi_barang_id,
            transaksi_jumlah,
            transaksi_harga,
            transaksi_pajak,
            transaksi_potongan,
            transaksi_total
        )
        values
        (
            p_invoice,
            p_tanggal,
            p_toko,
            p_kasir,
            p_barang,
            p_jumlah,
            p_harga,
            p_pajak,
            p_potongan,
            p_total
        );
END$$
DELIMITER ;

DELIMITER $$
DROP procedure IF EXISTS `sp_getkasir` $$
CREATE PROCEDURE `sp_getkasir` ()
BEGIN
    select kasir_id, kasir_name from tbl_kasir;
END$$
DELIMITER ;

DELIMITER $$
DROP procedure IF EXISTS `sp_gettoko` $$
CREATE PROCEDURE `sp_gettoko` ()
BEGIN
    select toko_id, toko_nama, toko_alamat from tbl_toko;

END$$
DELIMITER ;

DELIMITER $$
DROP procedure IF EXISTS `sp_getminuman` $$
CREATE PROCEDURE `sp_getminuman` (IN p_category VARCHAR(100))
BEGIN
    select barang_id, barang_name, barang_harga, barang_gambar from tbl_barang where barang_kategori = p_category;
END$$
DELIMITER ;

DELIMITER $$
DROP procedure IF EXISTS `sp_getmakanan` $$
CREATE PROCEDURE `sp_getmakanan` (IN p_category VARCHAR(100))
BEGIN
    select barang_id, barang_name, barang_harga, barang_gambar from tbl_barang where barang_kategori = p_category;
END$$
DELIMITER ;

DELIMITER $$
DROP procedure IF EXISTS `sp_getprint` $$
CREATE PROCEDURE `sp_getprint` (IN p_invoice VARCHAR(100))
BEGIN
    select barang_name,transaksi_jumlah,transaksi_total from tbl_transaksi INNER JOIN tbl_barang ON tbl_transaksi.transaksi_barang_id = tbl_barang.barang_id WHERE transaksi_invoice = p_invoice;
END$$
DELIMITER ;


