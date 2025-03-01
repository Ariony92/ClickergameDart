import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../modele/ennemis_modele.dart';


class EnnemisService {
  // URL de base de votre API PHP
  final String _baseUrl = 'http://votre-api-url.com/api';

  /// Récupère un ennemi par son niveau (id) via l'API.
  /// La méthode retourne une instance de EnnemiModele en cas de succès,
  /// sinon, elle lance une exception.
  Future<EnnemiModele> getEnemyById(int id) async {
    // Construction de l'URL avec le paramètre id
    final url = Uri.parse('$_baseUrl/get_enemies.php?id=$id');

    // Envoi de la requête GET
    final response = await http.get(url);

    // Vérification du statut de la réponse
    if (response.statusCode == 200) {
      // Conversion de la réponse JSON en Map
      final Map<String, dynamic> data = json.decode(response.body);
      // Conversion des données en objet EnnemiModele
      return EnnemiModele.fromJson(data);
    } else {
      // En cas d'erreur, on lance une exception
      throw Exception('Erreur lors de la récupération de l\'ennemi de niveau $id');
    }
  }
}
