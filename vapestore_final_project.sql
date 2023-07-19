-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 19, 2023 at 11:53 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vapestore`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `detail_cabang` ()   BEGIN
    DECLARE namacabang varchar(50);
    DECLARE alamatcabang varchar(50);
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT nama_cabang, alamat_cabang FROM cabang_toko;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1; 
    open cur;
    CREATE TEMPORARY TABLE TempDetailCabang(TempKolom varchar(100));
    fetch_loop : LOOP
    FETCH cur INTO namacabang, alamatcabang;
    IF done THEN
    LEAVE fetch_loop;
    end IF;
    INSERT INTO TempDetailCabang  Value(CONCAT(namacabang,", Cabang ",alamatcabang));
    END LOOP;
    CLOSE cur;
    SELECT TempKolom as 'Detail Cabang' FROM TempDetailCabang;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `akun_kasir`
--

CREATE TABLE `akun_kasir` (
  `id_akun_kasir` int NOT NULL,
  `id_profil_kasir` int NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `akun_kasir`
--

INSERT INTO `akun_kasir` (`id_akun_kasir`, `id_profil_kasir`, `username`, `password`) VALUES
(1, 1, 'Sukijan', 'suki123'),
(2, 2, 'Andhika', 'Dika98'),
(3, 3, 'Lily', 'Lynibos123'),
(4, 4, 'Zaki', 'Zaki456'),
(5, 5, 'Hans', 'Hans234'),
(6, 6, 'Auri', 'Auri78'),
(7, 7, 'Gabriel', 'Gabpacarwan12'),
(8, 8, 'Singgih', 'Singmenyanyi07');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` int NOT NULL,
  `nama_barang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `id_kategori_barang` int DEFAULT NULL,
  `ukuran_barang` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stok_barang` int DEFAULT NULL,
  `harga_barang` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `id_kategori_barang`, `ukuran_barang`, `stok_barang`, `harga_barang`) VALUES
(1, 'Upods Saltnic Strawberry Freeze Liquid Vape', 2, '30ml', 10, 75),
(2, 'Chznanarilla Pods Friendly Liquid', 6, '30ml', 5, 90),
(3, 'Sony VTC 4 Baterai Vape', 9, '2100mAh', 10, 50),
(4, 'Sony VTC 6A Vape Baterai', 9, '3000mAh', 10, 95),
(5, 'Ursa Nano pod', 6, '60g', 10, 245),
(6, 'Oxva Xlim V2', 6, '150g', 10, 232),
(7, 'Catridge Ursa Nano', 4, '20g', 5, 28),
(8, 'Catridge Xros Authentic ', 4, '20g', 5, 29),
(9, 'Coil Drag X', 4, '10g', 10, 16);

--
-- Triggers `barang`
--
DELIMITER $$
CREATE TRIGGER `after_update_barang` AFTER UPDATE ON `barang` FOR EACH ROW BEGIN
 
INSERT INTO log_barang(id_barang, nama_barang, id_kategori_barang, stok_barang, harga_barang, last_update)  
VALUES (OLD.id_barang, OLD.nama_barang, OLD.id_kategori_barang, OLD.stok_barang, OLD.harga_barang, NOW());

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cabang_toko`
--

CREATE TABLE `cabang_toko` (
  `id_cabang` int NOT NULL,
  `nama_cabang` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat_cabang` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cabang_toko`
--

INSERT INTO `cabang_toko` (`id_cabang`, `nama_cabang`, `alamat_cabang`) VALUES
(1, 'Alhasil Utama', 'Yogyakarta'),
(2, 'Vape Mentari', 'Bandung'),
(3, 'Banana Vape', 'Surabaya'),
(4, 'Sekilas Vape', 'Bali'),
(5, 'Konoha Vape', 'Lampung'),
(6, 'Colors Vape', 'Yogyakarta'),
(7, 'Blue Vape', 'Bali'),
(8, 'Asap Vape', 'Sulawesi'),
(9, 'Honda Vape', 'Bantul');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id_customer` int NOT NULL,
  `nama_customer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat_customer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `nik_customer` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id_customer`, `nama_customer`, `alamat_customer`, `nik_customer`) VALUES
(1, 'Dhuta', 'Jl.Buah Batu no.4', 5376921),
(2, 'Joey', 'Jl.Angkasa no.7', 5327981),
(3, 'Fades', 'Jl.Dilan dan Milea no.003', 5326727),
(4, 'Lucky', 'Jl.Ahmad Yani no.9', 5346547),
(5, 'Hanan', 'Jl.Balapan no.7', 5318987),
(6, 'Budi', 'Jl.Cendana no.49', 5327728),
(7, 'Setiawan', 'Jl.Giwangan no.71', 5347096),
(8, 'Sahrul', 'Jl.Janti no.22', 5348976),
(9, 'Bambang', 'Jl.Babarsari no.18', 5324536);

-- --------------------------------------------------------

--
-- Table structure for table `kategori_barang`
--

CREATE TABLE `kategori_barang` (
  `id_kategori_barang` int NOT NULL,
  `nama_kategori` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori_barang`
--

INSERT INTO `kategori_barang` (`id_kategori_barang`, `nama_kategori`, `deskripsi`) VALUES
(1, 'liquid freebase', 'cairan nikotin untuk mod vape yang terdiri dari banyak rasa'),
(2, 'liquid saltnic', 'cairan nikotin untuk pod vape yang terdiri dari banyak rasa'),
(3, 'kapas', 'untuk menguapkan liquid dari kapas dengan ditetes'),
(4, 'catridge', 'digunakan untuk menghasilkan uap dari pod'),
(5, 'mod vape', 'lebih banyak asap dan lebih besar ukurannya'),
(6, 'pod vape', 'lebih praktis dan lebih kecil ukurannya'),
(7, 'adaptor', 'charger untuk baterai jenis mod'),
(8, 'RDA/RTA', 'lebih menghasilkan rasa dan uap lebih banyak/dapat menyimpan liquid lebih lama untuk jenis mod'),
(9, 'baterai', '');

-- --------------------------------------------------------

--
-- Table structure for table `log_barang`
--

CREATE TABLE `log_barang` (
  `id_barang` int NOT NULL,
  `nama_barang` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `id_kategori_barang` int NOT NULL,
  `stok_barang` int NOT NULL,
  `harga_barang` int NOT NULL,
  `last_update` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `profil_kasir`
--

CREATE TABLE `profil_kasir` (
  `id_profil_kasir` int NOT NULL,
  `nama_kasir` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat_kasir` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `umur_kasir` int NOT NULL,
  `tanggal_lahir_kasir` date NOT NULL,
  `jenis_kelamin_kasir` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nik_kasir` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profil_kasir`
--

INSERT INTO `profil_kasir` (`id_profil_kasir`, `nama_kasir`, `alamat_kasir`, `umur_kasir`, `tanggal_lahir_kasir`, `jenis_kelamin_kasir`, `nik_kasir`) VALUES
(1, 'Sukijan', 'Jl.Sudirman no. b7', 24, '1999-09-13', 'Pria', 6541673),
(2, 'Andhika', 'Jl. Cempaka no. 4a', 23, '1999-08-23', 'Pria', 6541646),
(3, 'Lily', 'Jl. Rajawali no. 37', 22, '2000-08-02', 'Perempuan', 5481822),
(4, 'Zaki', 'Jl. Tajem no. 8c', 25, '1997-09-06', 'Pria', 1978945),
(5, 'Hans', 'Jl. Mangga Dua Gg. I, no. 2', 30, '1993-05-23', 'Pria', 9874912),
(6, 'Auri', 'Jl. Kusumoningrat no. 23', 22, '2001-01-15', 'Perempuan', 5496556),
(7, 'Gabriel', 'Jl. Nirmala no. 1b', 24, '1999-04-17', 'Perempuan', 5649864),
(8, 'Singgih', 'Jl. Bali Raya no. 51', 23, '2000-05-23', 'Pria', 6549612);

-- --------------------------------------------------------

--
-- Table structure for table `profil_supplier`
--

CREATE TABLE `profil_supplier` (
  `id_profile_supplier` int NOT NULL,
  `nama_supplier` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alamat_supplier` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `profil_supplier`
--

INSERT INTO `profil_supplier` (`id_profile_supplier`, `nama_supplier`, `alamat_supplier`) VALUES
(1, 'PT Suryadi', 'Jakarta Barat'),
(2, 'PT Sejahtera', 'Lampung'),
(3, 'PT Mentari', 'Bali'),
(4, 'PT Wong', 'Jakarta Selatan'),
(5, 'PT Mekar Jaya', 'Surabaya'),
(6, 'PT Bulan', 'Bantul'),
(7, 'PT Indah', 'Bandung'),
(8, 'PT Rrq', 'Yogyakarta'),
(9, 'PT Evos', 'Jambi');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int NOT NULL,
  `id_akun_kasir` int NOT NULL,
  `id_barang` int DEFAULT NULL,
  `id_cabang` int DEFAULT NULL,
  `id_customer` int DEFAULT NULL,
  `tanggal_transaksi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_akun_kasir`, `id_barang`, `id_cabang`, `id_customer`, `tanggal_transaksi`) VALUES
(1, 7, 5, 3, 4, '2023-10-07'),
(2, 6, 8, 9, 4, '2023-10-07'),
(3, 5, 3, 7, 4, '2023-10-07'),
(4, 2, 6, 4, 5, '2023-10-08'),
(5, 5, 8, 4, 2, '2023-10-08'),
(6, 7, 9, 5, 4, '2023-10-08'),
(7, 4, 6, 7, 9, '2023-10-09'),
(8, 1, 6, 5, 2, '2023-10-09'),
(9, 7, 3, 6, 8, '2023-10-09'),
(10, 3, 2, 1, 7, '2023-10-09'),
(11, 8, 4, 5, 3, '2023-10-09'),
(12, 6, 3, 2, 8, '2023-10-10'),
(13, 3, 1, 7, 9, '2023-10-10'),
(14, 4, 6, 8, 2, '2023-10-10'),
(15, 8, 2, 5, 7, '2023-10-10');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_supplier`
--

CREATE TABLE `transaksi_supplier` (
  `id_transaksi_supplier` int NOT NULL,
  `id_profile_supplier` int NOT NULL,
  `id_barang` int DEFAULT NULL,
  `tanggal_transaksi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi_supplier`
--

INSERT INTO `transaksi_supplier` (`id_transaksi_supplier`, `id_profile_supplier`, `id_barang`, `tanggal_transaksi`) VALUES
(1, 1, 1, '2023-10-07'),
(2, 2, 2, '2023-10-08'),
(3, 3, 3, '2023-10-09'),
(4, 3, 2, '2023-11-10'),
(5, 3, 5, '2023-11-11'),
(6, 4, 6, '2023-11-12'),
(7, 7, 7, '2023-12-13'),
(8, 8, 8, '2023-12-14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun_kasir`
--
ALTER TABLE `akun_kasir`
  ADD PRIMARY KEY (`id_akun_kasir`),
  ADD KEY `id_profil_kasir` (`id_profil_kasir`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `id_kategori_barang` (`id_kategori_barang`);

--
-- Indexes for table `cabang_toko`
--
ALTER TABLE `cabang_toko`
  ADD PRIMARY KEY (`id_cabang`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id_customer`);

--
-- Indexes for table `kategori_barang`
--
ALTER TABLE `kategori_barang`
  ADD PRIMARY KEY (`id_kategori_barang`);

--
-- Indexes for table `profil_kasir`
--
ALTER TABLE `profil_kasir`
  ADD PRIMARY KEY (`id_profil_kasir`);

--
-- Indexes for table `profil_supplier`
--
ALTER TABLE `profil_supplier`
  ADD PRIMARY KEY (`id_profile_supplier`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `id_akun_kasir` (`id_akun_kasir`),
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `id_cabang` (`id_cabang`),
  ADD KEY `id_customer` (`id_customer`);

--
-- Indexes for table `transaksi_supplier`
--
ALTER TABLE `transaksi_supplier`
  ADD PRIMARY KEY (`id_transaksi_supplier`),
  ADD KEY `id_profile_supplier` (`id_profile_supplier`),
  ADD KEY `id_barang` (`id_barang`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `profil_kasir`
--
ALTER TABLE `profil_kasir`
  MODIFY `id_profil_kasir` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `akun_kasir`
--
ALTER TABLE `akun_kasir`
  ADD CONSTRAINT `akun_kasir_ibfk_1` FOREIGN KEY (`id_profil_kasir`) REFERENCES `profil_kasir` (`id_profil_kasir`);

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`id_kategori_barang`) REFERENCES `kategori_barang` (`id_kategori_barang`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_akun_kasir`) REFERENCES `akun_kasir` (`id_akun_kasir`),
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `transaksi_ibfk_3` FOREIGN KEY (`id_cabang`) REFERENCES `cabang_toko` (`id_cabang`),
  ADD CONSTRAINT `transaksi_ibfk_4` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id_customer`);

--
-- Constraints for table `transaksi_supplier`
--
ALTER TABLE `transaksi_supplier`
  ADD CONSTRAINT `transaksi_supplier_ibfk_1` FOREIGN KEY (`id_profile_supplier`) REFERENCES `profil_supplier` (`id_profile_supplier`),
  ADD CONSTRAINT `transaksi_supplier_ibfk_2` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
