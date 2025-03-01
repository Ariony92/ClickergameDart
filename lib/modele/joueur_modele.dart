import 'package:clicker/core/enums/enum_amelioration.dart';
import 'amelioration_joueur_modele.dart';


class JoueurModele {
  int experience;
  int degats;
  int experienceParClic;

  JoueurModele({
    this.experience = 0,
    this.degats = 1,
    this.experienceParClic = 5,
  });

  void ajouterExperience(int xp) {
    experience += xp;
  }

  // inflige des dégâts et gagne de l'expérience retourne les dégats infligé
  int cliquer() {
    ajouterExperience(experienceParClic);
    return degats;
  }

  // Permet d'augmenter les dégâts de base en dépensant de l'expérience.
  int augmenterDegats() {
    int coutDegats = degats * 10;
    if (experience >= coutDegats) {
      experience -= coutDegats;
      degats++;
      return degats;
    }
    return -1;
  }

  // Permet au joueur d'acheter une amélioration si l'amélioration est dégat, on augmente degats et pareil pour les EXP
  int acheterAmelioration(AmeliorationJoueur amelioration) {
    int cout = amelioration.coutActuel;
    if (experience >= cout) {
      experience -= cout;
      if (amelioration.typeAmelioration == ameliorationType.degats) {
        degats += amelioration.effet;
        amelioration.ameliorer();
        return degats;
      } else if (amelioration.typeAmelioration == ameliorationType.experiencegagner) {
        experienceParClic += amelioration.effet;
        amelioration.ameliorer();
        return experienceParClic;
      }
    }
    return -1;
  }
}
