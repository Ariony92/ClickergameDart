class JoueurModele {
  int experience;
  int degats;
  int experienceParClic;
  int vieMax;
  int vieActuelle;

  JoueurModele({
    this.experience = 0,
    this.degats = 1,
    this.experienceParClic = 5,
    this.vieMax = 100,
  }) : vieActuelle = vieMax;

  void ajouterExperience(int xp) {
    experience += xp;
  }

  int cliquer() {
    ajouterExperience(experienceParClic);
    return degats;
  }

  int ameliorerDegats() {
    int cout = (degats + 1) * 10;
    if (experience >= cout) {
      experience -= cout;
      degats++;
      return degats;
    }
    return -1;
  }

  void prendreDegats(int degatsRecus) {
    vieActuelle = (vieActuelle - degatsRecus).clamp(0, vieMax);
  }

  void reinitialiser() {
    experience = 0;
    degats = 1;
    experienceParClic = 5;
    vieActuelle = vieMax;
  }

  bool estMort() {
    return vieActuelle <= 0;
  }
}
