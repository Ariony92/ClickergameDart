<?php
require_once('db.php');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["error" => "Méthode non autorisée"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['id'])) {
    http_response_code(400);
    echo json_encode(["error" => "ID de l'ennemi requis"]);
    exit;
}

$id = filter_var($data['id'], FILTER_VALIDATE_INT);

if (!$id) {
    http_response_code(400);
    echo json_encode(["error" => "ID invalide"]);
    exit;
}

try {
    $query = "DELETE FROM enemies WHERE id = :id";
    $statement = $db->prepare($query);
    $statement->execute([':id' => $id]);

    echo json_encode(["success" => "Ennemi supprimé"]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
}
?>
