import 'package:flutter/material.dart';
import '../modele/joueur_modele.dart';

class JoueurViewModel extends ChangeNotifier {
  final JoueurModele _joueur = JoueurModele();

  int get experience => _joueur.experience;
  int get degats => _joueur.degats;
  int get experienceParClic => _joueur.experienceParClic;
  int get vieMax => _joueur.vieMax;
  int get vieActuelle => _joueur.vieActuelle;

  int cliquer() {
    int degatsInfliges = _joueur.cliquer();
    notifyListeners();
    return degatsInfliges;
  }

  int ameliorerDegats() {
    int nouveauDegats = _joueur.ameliorerDegats();
    notifyListeners();
    return nouveauDegats;
  }

  void ajouterExperience(int xp) {
    _joueur.ajouterExperience(xp);
    notifyListeners();
  }
}
