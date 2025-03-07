import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../modele/ennemis_modele.dart';

class ApiService {
  final String baseUrl = "http://localhost/api_flutter";

  Future<EnnemiModele?> getEnemyByLevel(int level) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/get_ennemies.php?level=$level"));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty && data[0] is Map<String, dynamic>) {
          return EnnemiModele.fromJson(data[0]);
        } else {
          return null;
        }
      } else {
        throw Exception("erreur api, code ${response.statusCode}");
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> updateEnemyLife(int level, int damage) async {
    final response = await http.post(
      Uri.parse("$baseUrl/update_enemy.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"level": level, "damage": damage}),
    );

    if (response.statusCode != 200) {
      throw Exception("erreur mise à jour PV ennemi");
    }
  }

  Future<void> deleteEnemy(int level) async {
    final response = await http.post(
      Uri.parse("$baseUrl/delete_enemy.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"level": level}),
    );

    if (response.statusCode != 200) {
      throw Exception("erreur de suppression ennemi");
    }
  }
}
