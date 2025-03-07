import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/services/api_service.dart';
import '../modele/ennemis_modele.dart';
import 'joueur_viewmodele.dart';

class EnnemisViewModele extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  EnnemiModele? ennemiActuel;
  int niveauActuel = 1;

  EnnemisViewModele() {
    chargerEnnemi();
  }

    Future<void> chargerEnnemi() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/api_flutter/get_enemies.php?level=$niveauActuel'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Réponse API : $data");

        if (data.isNotEmpty) {
          ennemiActuel = EnnemiModele.fromJson(data[0]);
          notifyListeners();
        } else {
          print("Aucun ennemi trouvé pour le niveau $niveauActuel");
        }
      } else {
        print("Erreur API : Code ${response.statusCode}");
      }
    } catch (e) {
      print("erreur lors du chargement de l'ennemi : $e");
    }
  }


  void attaquerEnnemi(int degats, JoueurViewModel joueurViewModel, BuildContext context) {
    if (ennemiActuel != null) {
      ennemiActuel!.reduirePV(degats);
      joueurViewModel.ajouterExperience(joueurViewModel.experienceParClic);

      if (ennemiActuel!.estMort()) {
        if (niveauActuel >= 3) {
          _afficherMessageFin(context);
        } else {
          niveauActuel++;
          chargerEnnemi();
        }
      }
      notifyListeners();
    }
  }
  void _afficherMessageFin(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Félicitations !"),
          content: Text("Tu as fini le jeu"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
