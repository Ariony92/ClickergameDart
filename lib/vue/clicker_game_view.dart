import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_modele/ennemis_viewmodele.dart';
import '../view_modele/joueur_viewmodele.dart';
import '../widgets/enemy_widget.dart';

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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_game.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ennemisViewModel.ennemiActuel == null
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),

                    // Affichage de l'ennemi avec EnemyWidget
                    EnemyWidget(),
                    const SizedBox(height: 30),

                    // Barre de vie du joueur
                    const Text(
                      "Votre Vie",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 200,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[300],
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (joueurViewModel.vieActuelle /
                                joueurViewModel.vieMax)
                            .clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green, // Vert pour le joueur
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "PV : ${joueurViewModel.vieActuelle} / ${joueurViewModel.vieMax}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Expérience : ${joueurViewModel.experience}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Dégâts par clic : ${joueurViewModel.degats}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: () {
                        int result = joueurViewModel.ameliorerDegats();
                        if (result == -1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Pas assez d'expérience !"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Améliorer dégâts (${joueurViewModel.coutAmeliorationDegats()} XP)",
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
