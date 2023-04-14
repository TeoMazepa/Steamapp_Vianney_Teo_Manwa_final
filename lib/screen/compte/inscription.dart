import 'package:firebasetest/screen/compte/connexion.dart';
import 'package:flutter/material.dart';
import 'package:firebasetest/screen/steam/accueil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final TextEditingController emailsignup = TextEditingController();
  final TextEditingController passwordsignup = TextEditingController();
  final TextEditingController passwordConfirmation = TextEditingController();

  String emailinscr = '';
  String passwordinscr = '';
  bool passwordMatch = true;

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bgapp.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Inscription',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'GSans',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 12.0,
                ),
                height: 30,
                width: 300,
                child: const Text(
                  'Veuillez saisir ces différentes informations, afin que vos listes soient sauvegardées.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                  top: 43.0,
                ),
                child: const TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1E262C),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Color(0xFFF2F2F2),
                    ),
                    hintText: 'Nom d\'utilisateur',
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                  top: 12.0,
                ),
                child: TextField(
                  cursorColor: Colors.white,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  controller: emailsignup,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1E262C),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Color(0xFFF2F2F2),
                    ),
                    hintText: 'Email',
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                  top: 12.0,
                ),
                child: TextField(
                  cursorColor: Colors.white,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  controller: passwordsignup,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1E262C),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Color(0xFFF2F2F2),
                    ),
                    hintText: 'Mot de passe',
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(
                  left: 22,
                  right: 22,
                  top: 12.0,
                ),
                child: TextField(
                  controller: passwordConfirmation,
                  cursorColor: Colors.white,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1E262C),
                    border: OutlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Color(0xFFF2F2F2),
                    ),
                    hintText: 'Vérification du mot de passe',
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                    left: 22,
                    right: 22,
                    top: 73.0,
                  ),
                  height: 45,
                  width: mediaQueryData.size.height,
                  child: ElevatedButton(
                      onPressed: () async {
                        emailinscr = emailsignup.text;
                        passwordinscr = passwordsignup.text;
                        if (emailinscr.isEmpty ||
                            passwordinscr.isEmpty ||
                            passwordConfirmation.text != passwordsignup.text) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Erreur de saisie"),
                                content: const Text(
                                    "Veuillez entrer votre e-mail et votre mot de passe souhaités"),
                                actions: [
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          try {
                            final newUser = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailinscr, password: passwordinscr);
                            if (newUser != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccueilPage()),
                              );
                            }
                          } catch (e) {
                            if (e is FirebaseAuthException) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Erreur de connexion"),
                                    content: Text(
                                        "L'adresse e-mail est déjà utilisée par un autre compte."
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Erreur de connexion"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                      child: const Text('S\'inscrire'))),
              Container(
                margin: const EdgeInsets.only(
                  top: 200.0,
                ),
                child: TextButton(
                  child: const Text(
                    'Retour Connexion',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xFFAFB8BB),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConnexionSection()),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
