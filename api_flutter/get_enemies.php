<?php
require_once('db.php');

$query = 'SELECT level, name, total_life, image, attack_power FROM Enemy WHERE 1=1';
$params = [];

if (!empty($_GET['level'])) {
    $level = filter_var($_GET['level'], FILTER_VALIDATE_INT);
    if ($level !== false) {
        $query .= ' AND level = :level';
        $params[':level'] = $level;
    }
}

try {
    $statement = $db->prepare($query);
    $statement->execute($params);
    $rows = $statement->fetchAll(PDO::FETCH_ASSOC);
    
    echo json_encode($rows);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
}
?>
