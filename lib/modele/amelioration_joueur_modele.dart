import '../core/enums/enum_amelioration.dart';

// une amélioration que le joueur peut acheter
class AmeliorationJoueur {
  ameliorationType typeAmelioration; // Le type d'amélioration
  String nom;
  int niveau;
  int coutDeBase;                   // Le coût de l'amélioration
  int multiplicateurCout;           // Un multiplicateur pour calculer le coût
  int effet;                      // bonus de dégâts ou de gain d'expérience


  AmeliorationJoueur({
    required this.typeAmelioration,
    required this.nom,
    this.niveau = 1,
    this.coutDeBase = 10,
    this.multiplicateurCout = 10,
    this.effet = 1,
  });

  // Calcule coût actuel pour passer au niveau suivant
  int get coutActuel {
    return coutDeBase * niveau * multiplicateurCout;
  }

  // Augmente le niveau de l'amélioration et met à jour l'effet.
  void ameliorer() {
    niveau++;
    effet = niveau;
  }


  factory AmeliorationJoueur.fromJson(Map<String, dynamic> json) {
    return AmeliorationJoueur(
      typeAmelioration: json['type'] == 'damage'
          ? ameliorationType.degats
          : ameliorationType.experiencegagner,
      nom: json['nom'] ?? '',
      niveau: json['niveau'] ?? 1,
      coutDeBase: json['coutDeBase'] ?? 10,
      multiplicateurCout: json['multiplicateurCout'] ?? 10,
      effet: json['effet'] ?? 1,
    );
  }

  // Convertit l'instance en JSON pour pouvoir la sauvegarder ou l'envoyer.
  Map<String, dynamic> toJson() {
    return {
      'type': typeAmelioration == ameliorationType.degats
          ? 'damage'
          : 'experience',
      'nom': nom,
      'niveau': niveau,
      'coutDeBase': coutDeBase,
      'multiplicateurCout': multiplicateurCout,
      'effet': effet,
    };
  }
}
