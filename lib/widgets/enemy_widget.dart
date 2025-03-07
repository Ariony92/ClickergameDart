import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_modele/ennemis_viewmodele.dart';
import '../view_modele/joueur_viewmodele.dart';

class EnemyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ennemisViewModel = Provider.of<EnnemisViewModele>(context);
    final joueurViewModel = Provider.of<JoueurViewModel>(context);
    final ennemi = ennemisViewModel.ennemiActuel;

    if (ennemi == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Niveau ${ennemisViewModel.niveauActuel} - ${ennemi.nom}",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        GestureDetector(
          onTap: () {
            int degatsInfliges = joueurViewModel.cliquer();
            ennemisViewModel.attaquerEnnemi(degatsInfliges, joueurViewModel, context);
          },
          child: ennemi.image.startsWith("assets/")
              ? Image.asset(
            ennemi.image,
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return Text("Erreur chargement image");
            },
          )
              : Image.network(
            ennemi.image,
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return Text("Erreur chargement image");
            },
          ),
        ),

        const SizedBox(height: 10),

        Container(
          width: 200,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (ennemi.vieActuelle / ennemi.vieTotale).clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.redAccent,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "PV : ${ennemi.vieActuelle} / ${ennemi.vieTotale}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
