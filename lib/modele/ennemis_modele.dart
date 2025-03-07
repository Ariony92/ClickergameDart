import 'dart:ui';

class EnnemiModele {
  final String nom;
  final int vieTotale;
  final int niveau;
  final String image;
  final int attackPower;
  late int vieActuelle;
  Offset position;

  EnnemiModele({
    required this.nom,
    required this.vieTotale,
    required this.niveau,
    required this.image,
    required this.attackPower,
    required this.position,
  }) {
    vieActuelle = vieTotale;
  }

  void mettreAJourPosition(Offset nouvellePosition) {
    position = nouvellePosition;
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

  int recompenseExperience() {
    return niveau * 10;
  }

  factory EnnemiModele.fromJson(Map<String, dynamic> json) {
    String imagePath = json['image'] ?? '';

    String finalImagePath;
    if (imagePath.startsWith('assets/')) {
      finalImagePath = imagePath;
    } else {
      finalImagePath = "http://localhost/api_flutter/$imagePath";
    }

    return EnnemiModele(
      nom: json['name'] ?? '',
      vieTotale: json['total_life'] ?? 100,
      niveau: json['level'] ?? 1,
      image: finalImagePath,
      attackPower: json['attack_power'] ?? 10,
      position: Offset(100, 100),
    );
  }
}
