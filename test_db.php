<?php
// Simple DB connection tester for the E-Library project
error_reporting(E_ALL);
ini_set('display_errors', 1);

$host = 'localhost';
$user = 'root';
$pass = '';
$db   = 'data_perpus';

$mysqli = @new mysqli($host, $user, $pass, $db);

if ($mysqli->connect_errno) {
    echo "Koneksi gagal: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
    echo "<br><br>Periksa: MySQL berjalan, kredensial di `inc/koneksi.php`, dan apakah database '" . $db . "' ada dan ter-import.";
} else {
    echo "Koneksi berhasil ke database '<b>" . htmlspecialchars($db) . "</b>' dengan user '<b>" . htmlspecialchars($user) . "</b>' pada host '<b>" . htmlspecialchars($host) . "</b>'<br>";
    $res = $mysqli->query("SHOW TABLES");
    if ($res) {
        echo "Jumlah tabel: <b>" . $res->num_rows . "</b><br>";
        echo "Tabel (maks 50): <ul>";
        $i = 0;
        while ($row = $res->fetch_array()) {
            echo "<li>" . htmlspecialchars($row[0]) . "</li>";
            $i++; if ($i >= 50) break;
        }
        echo "</ul>";
    } else {
        echo "Gagal membaca tabel: " . $mysqli->error;
    }
}

?>