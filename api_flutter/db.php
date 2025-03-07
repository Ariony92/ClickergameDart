<?php
$dsn = 'mysql:host=localhost;dbname=clicker_game;charset=utf8';
$user = 'root';
$password = 'ton mdp';

try {
    $db = new PDO($dsn, $user, $password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["error" => "Erreur de connexion à la base de données : " . $e->getMessage()]);
    exit;
}
?>
