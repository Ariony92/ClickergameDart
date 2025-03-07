<?php
require_once('db.php');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["error" => "Méthode non autorisée"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['id']) || !isset($data['damage'])) {
    http_response_code(400);
    echo json_encode(["error" => "Données manquantes"]);
    exit;
}

$id = filter_var($data['id'], FILTER_VALIDATE_INT);
$damage = filter_var($data['damage'], FILTER_VALIDATE_INT);

if (!$id || !$damage) {
    http_response_code(400);
    echo json_encode(["error" => "Données invalides"]);
    exit;
}

try {
    $query = "SELECT currentLife FROM enemies WHERE id = :id";
    $statement = $db->prepare($query);
    $statement->execute([':id' => $id]);
    $enemy = $statement->fetch(PDO::FETCH_ASSOC);

    if (!$enemy) {
        http_response_code(404);
        echo json_encode(["error" => "Ennemi non trouvé"]);
        exit;
    }

    $newLife = max(0, $enemy['currentLife'] - $damage);

    $query = "UPDATE enemies SET currentLife = :currentLife WHERE id = :id";
    $statement = $db->prepare($query);
    $statement->execute([':currentLife' => $newLife, ':id' => $id]);

    echo json_encode(["success" => "PV mis à jour", "currentLife" => $newLife]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
}
?>

