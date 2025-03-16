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

  int ptAttaque() {
    return attackPower;
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
    vieTotale: int.parse(json['total_life'].toString()), 
    niveau: int.parse(json['level'].toString()), 
    image: finalImagePath,
    attackPower: int.parse(json['attack_power'].toString()), 
    position: Offset(100, 100),
  );
}
}
