class EnnemiModele {
  final String nom;
  final int vieTotale;
  final int niveau;
  late int vieActuelle;

  EnnemiModele({
    required this.nom,
    required this.vieTotale,
    required this.niveau,
  }) {
    vieActuelle = vieTotale;
  }

  void reduirePV(int degats) {
    vieActuelle = (vieActuelle - degats).clamp(0, vieTotale);
  }

  bool estMort() {
    return vieActuelle <= 0;
  }

  void reinitialiserVie() {
    vieActuelle = vieTotale;
  }

  // récompense XP pour chaque enemis tué
  int recompenseExperience() {
    return niveau * 10;
  }

  factory EnnemiModele.fromJson(Map<String, dynamic> json) {
    return EnnemiModele(
      nom: json['name'] ?? '',
      vieTotale: json['totalLife'] ?? 100,
      niveau: json['level'] ?? 1,
    );
  }
}
