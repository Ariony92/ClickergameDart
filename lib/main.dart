import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_modele/ennemis_viewmodele.dart';
import 'view_modele/joueur_viewmodele.dart';
import 'vue/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EnnemisViewModele()),
        ChangeNotifierProvider(create: (_) => JoueurViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clicker Game',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        // '/game': (context) => GameView()
      },
    );
  }
}