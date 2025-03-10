import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../core/services/api_service.dart';
import '../modele/ennemis_modele.dart';
import 'joueur_viewmodele.dart';
import '../vue/home_view.dart';

class EnnemisViewModele extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  EnnemiModele? ennemiActuel;
  int niveauActuel = 1;

  EnnemisViewModele() {
    chargerEnnemi();
  }

  Future<void> chargerEnnemi() async {
    try {
      final response = await http.get(Uri.parse(
          'http://localhost/api_flutter/get_enemies.php?level=$niveauActuel'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        //print("Réponse API : $data");

        if (data.isNotEmpty) {
          ennemiActuel = EnnemiModele.fromJson(data[0]);
          notifyListeners();
        } else {
          //print("Aucun ennemi trouvé pour le niveau $niveauActuel");
          ennemiActuel = null;
        }
      } else {
        //print("Erreur API : Code ${response.statusCode}");
      }
    } catch (e) {
      //print("erreur lors du chargement de l'ennemi : $e");
    }
  }

  void attaquerEnnemi(
      int degats, JoueurViewModel joueurViewModel, BuildContext context) {
    if (ennemiActuel != null) {
      ennemiActuel!.reduirePV(degats);
      joueurViewModel.ajouterExperience(joueurViewModel.experienceParClic);
      joueurViewModel.attaquerJoueur(ennemiActuel!.ptAttaque());

      if (ennemiActuel!.estMort()) {
        niveauActuel++;
        joueurViewModel.ajouterVie(50);
        chargerEnnemi();
      }
      if (joueurViewModel.estMort()) {
        _afficherMessageFin(context);
      }
      notifyListeners();
    } else {
      _afficherMessageFin(context);
      notifyListeners();
    }
  }

  void _afficherMessageFin(BuildContext context) {
    final joueurViewModel =
        Provider.of<JoueurViewModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Fin de Jeu"),
          actions: [
            TextButton(
              onPressed: () {
                _resetGame(
                    joueurViewModel); // Réinitialiser le jeu et le joueur
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                  (Route<dynamic> route) =>
                      false, // Supprime toutes les pages précédentes
                );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _resetGame(JoueurViewModel joueurViewModel) {
    // Réinitialisation des ennemis
    niveauActuel = 1;
    ennemiActuel = null;
    chargerEnnemi();

    // Réinitialisation du joueur
    joueurViewModel.reinitialiserJoueur();

    notifyListeners();
  }
}
