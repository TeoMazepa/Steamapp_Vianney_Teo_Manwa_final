import 'package:firebasetest/screen/compte/inscription.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'screen/compte/connexion.dart';

//// Projet Application mobile
////
//// Manwa Battah, Téo Mazepa et Vianney Portalier
////
//// OCRES 4 ING4 PROMO 2024



Future<void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projet Steam',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: const Color(0xFF636AF6)),
        fontFamily: 'Proxima',
        scaffoldBackgroundColor: const Color(0xFF1A2025),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF1A2025),
        ),
      ),
      home: ConnexionSection(),
    );
  }
}

