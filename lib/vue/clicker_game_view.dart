import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_modele/ennemis_viewmodele.dart';
import '../view_modele/joueur_viewmodele.dart';
import '../widgets/joueur_widget.dart';
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
                    EnemyWidget(),
                    const SizedBox(height: 30),
                    JoueurWidget(),
                  ],
                ),
        ),
      ),
    );
  }
}
