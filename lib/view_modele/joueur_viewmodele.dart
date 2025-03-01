import 'package:flutter/material.dart';
import '../modele/amelioration_joueur_modele.dart';
import '../modele/joueur_modele.dart';

class JoueurViewModel extends ChangeNotifier {
  final JoueurModele _joueur = JoueurModele();

  // stats joueur
  int get experience => _joueur.experience;
  int get degats => _joueur.degats;
  int get experienceParClic => _joueur.experienceParClic;

 //retourne nbr de dégats infligé selon le clique
  int cliquer() {
    int degatsInfliges = _joueur.cliquer();
    notifyListeners();
    return degatsInfliges;
  }

//augemente degat du joueur en dépensant de l'exp et retorune les nouveaux dégats
  int augmenterDegats() {
    int nouveauDegats = _joueur.augmenterDegats();
    notifyListeners();
    return nouveauDegats;
  }


  //Le joeuur peut acheter soit des degats donc augmente les degats ou de l'experience en plus (cest a dire il gagne bcp d'exp quand il clique)
  int acheterAmelioration(AmeliorationJoueur amelioration) {
    int nouvelleStat = _joueur.acheterAmelioration(amelioration);
    notifyListeners();
    return nouvelleStat;
  }

//donne une quantité d'exp au joueur
  void ajouterExperience(int xp) {
    _joueur.ajouterExperience(xp);
    notifyListeners();
  }

 //reinitialisation des stats si il relance le jeu
  void reinitialiser() {
    _joueur.experience = 0;
    _joueur.degats = 1;
    _joueur.experienceParClic = 5;
    notifyListeners();
  }
}
