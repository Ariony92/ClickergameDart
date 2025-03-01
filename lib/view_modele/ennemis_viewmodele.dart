import 'package:flutter/material.dart';
import '../core/services/ennemis_service.dart';
import '../modele/ennemis_modele.dart';

class EnnemisViewModele extends ChangeNotifier {
  final EnnemisService _enemyService = EnnemisService();
  late EnnemiModele _ennemi;
  bool nouveauEnnemi = true;
  int niveauActuel = 1;

  int get niveauEnnemi => _ennemi.niveau;
  int get vieTotale => _ennemi.vieTotale;
  int get vieActuelle => _ennemi.vieActuelle;


  void attaquerEnnemi(int degats) {
    _ennemi.reduirePV(degats);
    if (_ennemi.estMort()) {
      ennemiSuivant();
    }
    notifyListeners();
  }

  void ennemiSuivant() {
    niveauActuel++;
    nouveauEnnemi = true;
    fetchEnnemi();
    notifyListeners();
  }

  Future<bool> fetchEnnemi() async {
    try {
      _ennemi = await _enemyService.getEnemyById(niveauActuel);
      nouveauEnnemi = false;
      notifyListeners();
      return true;
    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'ennemi de niveau $niveauActuel : $e");
    }
  }
}
