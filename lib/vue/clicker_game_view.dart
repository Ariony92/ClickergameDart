import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_modele/ennemis_viewmodele.dart';
import '../view_modele/joueur_viewmodele.dart';

class ClickerGameView extends StatefulWidget {
  @override
  _ClickerGameViewState createState() => _ClickerGameViewState();
}

class _ClickerGameViewState extends State<ClickerGameView> {
  @override
  Widget build(BuildContext context) {
    final ennemisViewModel = Provider.of<EnnemisViewModele>(context);
    final joueurViewModel = Provider.of<JoueurViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Clicker Game"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_game.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ennemisViewModel.ennemiActuel == null
              ? CircularProgressIndicator()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Niveau ${ennemisViewModel.niveauActuel}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),

              Container(
                width: 200,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (ennemisViewModel.ennemiActuel!.vieActuelle /
                      ennemisViewModel.ennemiActuel!.vieTotale)
                      .clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Text(
                "PV : ${ennemisViewModel.ennemiActuel!.vieActuelle} / ${ennemisViewModel.ennemiActuel!.vieTotale}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  int degatsInfliges = joueurViewModel.cliquer();
                  ennemisViewModel.attaquerEnnemi(degatsInfliges, joueurViewModel, context);
                },
                child: ennemisViewModel.ennemiActuel!.image.startsWith("assets/")
                    ? Image.asset(
                  ennemisViewModel.ennemiActuel!.image,
                  width: 200,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Text("Erreur chargement image");
                  },
                )
                    : Image.network(
                  ennemisViewModel.ennemiActuel!.image,
                  width: 200,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Text("Erreur chargement image");
                  },
                ),
              ),

              const SizedBox(height: 30),

              Text(
                "Expérience : ${joueurViewModel.experience}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Dégâts par clic : ${joueurViewModel.degats}",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  int result = joueurViewModel.ameliorerDegats();
                  if (result == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Pas assez d'expérience !"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                child: Text("Améliorer dégâts (${joueurViewModel.coutAmeliorationDegats()} XP)"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
