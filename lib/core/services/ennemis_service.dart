import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../modele/ennemis_modele.dart';

class EnnemisService {
  final String _baseUrl = 'http://localhost/api_flutter';

  Future<EnnemiModele> getEnemyById(int id) async {
    final url = Uri.parse('$_baseUrl/get_enemies.php?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return EnnemiModele.fromJson(data);
    }
    else {
      throw Exception('Erreur lors de la récupération de lennemi de niveau $id');
    }
  }
}
