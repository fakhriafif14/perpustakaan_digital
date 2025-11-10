-- --------------------------------------------------------
-- Struktur Database Sistem Informasi Perpustakaan
-- --------------------------------------------------------

-- Buat database
CREATE DATABASE IF NOT EXISTS data_perpus;
USE data_perpus;

-- --------------------------------------------------------
-- 1. Tabel Anggota (tb_anggota)
-- Menyimpan data anggota perpustakaan
-- --------------------------------------------------------
CREATE TABLE `tb_anggota` (
  `id_anggota` varchar(10) NOT NULL,
  `nama` varchar(20) NOT NULL,
  `jekel` enum('Laki-laki','Perempuan') NOT NULL,
  `kelas` varchar(50) NOT NULL,
  `no_hp` varchar(15) NOT NULL,
  PRIMARY KEY (`id_anggota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 2. Tabel Buku (tb_buku)
-- Menyimpan data koleksi buku perpustakaan
-- --------------------------------------------------------
CREATE TABLE `tb_buku` (
  `id_buku` varchar(10) NOT NULL,
  `judul_buku` varchar(30) NOT NULL,
  `pengarang` varchar(30) NOT NULL,
  `penerbit` varchar(30) NOT NULL,
  `th_terbit` year(4) NOT NULL,
  PRIMARY KEY (`id_buku`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 3. Tabel Pengguna (tb_pengguna)
-- Menyimpan data pengguna sistem (admin dan petugas)
-- --------------------------------------------------------
CREATE TABLE `tb_pengguna` (
  `id_pengguna` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pengguna` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(35) NOT NULL,
  `level` enum('Administrator','Petugas') NOT NULL,
  PRIMARY KEY (`id_pengguna`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 4. Tabel Sirkulasi (tb_sirkulasi)
-- Menyimpan data transaksi peminjaman dan pengembalian
-- --------------------------------------------------------
CREATE TABLE `tb_sirkulasi` (
  `id_sk` varchar(20) NOT NULL,
  `id_buku` varchar(10) NOT NULL,
  `id_anggota` varchar(10) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `status` enum('PIN','KEM') NOT NULL,
  PRIMARY KEY (`id_sk`),
  KEY `id_buku` (`id_buku`),
  KEY `id_anggota` (`id_anggota`),
  CONSTRAINT `tb_sirkulasi_ibfk_1` FOREIGN KEY (`id_buku`) REFERENCES `tb_buku` (`id_buku`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_sirkulasi_ibfk_2` FOREIGN KEY (`id_anggota`) REFERENCES `tb_anggota` (`id_anggota`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- 5. Tabel Log Peminjaman (log_pinjam)
-- Menyimpan history/log peminjaman buku
-- --------------------------------------------------------
CREATE TABLE `log_pinjam` (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `id_buku` varchar(10) NOT NULL,
  `id_anggota` varchar(10) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  PRIMARY KEY (`id_log`),
  KEY `id_anggota` (`id_anggota`),
  KEY `id_buku` (`id_buku`),
  CONSTRAINT `log_pinjam_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `tb_anggota` (`id_anggota`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `log_pinjam_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `tb_buku` (`id_buku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------
-- Data Contoh untuk Pengujian
-- --------------------------------------------------------

-- 1. Data Pengguna
INSERT INTO `tb_pengguna` (`nama_pengguna`, `username`, `password`, `level`) VALUES
('Fakhri', 'admin', md5('123'), 'Administrator'),
('Petugas1', 'petugas', md5('123'), 'Petugas');

-- 2. Data Anggota
INSERT INTO `tb_anggota` (`id_anggota`, `nama`, `jekel`, `kelas`, `no_hp`) VALUES
('A001', 'Ana', 'Perempuan', 'juwana', '089987789000'),
('A002', 'Bagus', 'Laki-laki', 'demak', '089987789098'),
('A003', 'Citra', 'Perempuan', 'demak', '085878526048'),
('A004', 'Didik', 'Laki-laki', 'pati', '087789987654'),
('A005', 'Edi', 'Laki-laki', 'demak', '089987789098');

-- 3. Data Buku
INSERT INTO `tb_buku` (`id_buku`, `judul_buku`, `pengarang`, `penerbit`, `th_terbit`) VALUES
('B001', 'Matematika', 'anastasya', 'armi print', 2010),
('B002', 'RPL 2', 'Eko', 'UMK', 2020),
('B003', 'C++', 'Anton', 'Toni Perc', 2010),
('B004', 'CI 4', 'anastasya', 'armi print', 2009),
('B005', 'Data Mining', 'Anton', 'Toni Perc', 2020);