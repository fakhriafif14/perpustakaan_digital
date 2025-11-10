<?php
include "inc/koneksi.php";

$sql = "UPDATE tb_pengguna SET nama_pengguna = 'Fakhri' WHERE username = 'admin'";
if ($koneksi->query($sql) === TRUE) {
    echo "Nama berhasil diupdate menjadi Fakhri";
} else {
    echo "Error updating record: " . $koneksi->error;
}

$koneksi->close();
?>