<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');

include_once './database.php';

$db = new Database("transbase.db", 2024, "sample", "tbadmin", "");
$cashbooks = $db->execute("select * from cashbook");
$db->close();

print_r(json_encode($cashbooks));
?>