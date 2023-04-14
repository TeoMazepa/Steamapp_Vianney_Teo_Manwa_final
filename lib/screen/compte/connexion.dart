import 'package:flutter/material.dart';
import 'package:firebasetest/screen/compte/inscription.dart';
import 'package:firebasetest/screen/steam/accueil.dart';
import 'mdpoublie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ConnexionSection extends StatefulWidget {
  @override
  _ConnexionSection createState() => _ConnexionSection();
}

class _ConnexionSection extends State<ConnexionSection> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bgapp.png"),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Bienvenue !',
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
                  height: 60,
                  width: 190,
                  child: const Text(
                    'Veuillez vous connecter ou créer un nouveau compte pour utiliser l’application.',
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
                    top: 25.0,
                  ),
                  child: TextField(
                    controller: emailController,
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
                    controller: passwordController,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
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
                    margin: const EdgeInsets.only(
                      left: 22,
                      right: 22,
                      top: 73.0,
                    ),
                    height: 45,
                    width: mediaQueryData.size.height,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true; // activer l'affichage du loader
                          });
                          email = emailController.text;
                          password = passwordController.text;
                          if (email.isEmpty || password.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Erreur de connexion"),
                                  content: Text(
                                      "Veuillez entrer votre e-mail et votre mot de passe"
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
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccueilPage()),
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Erreur de connexion"),
                                      content: Text(
                                          "Aucun utilisateur trouvé avec cet e-mail"),
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
                              } else if (e.code == 'wrong-password') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Erreur de connexion"),
                                      content:
                                          Text("Le mot de passe est incorrect"),
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
                            } catch (e) {
                              print(e);
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            )),
                        child: const Text('Se connecter'))),
                Container(
                    margin: const EdgeInsets.only(
                      left: 22,
                      right: 22,
                      top: 15.0,
                    ),
                    height: 45,
                    width: mediaQueryData.size.width,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFF636AF6), width: 1),
                      ),
                      child: const Text(
                        'Créer un nouveau compte',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Inscription()),
                        );
                      },
                    )),
                Container(
                  margin: const EdgeInsets.only(
                    top: 200.0,
                  ),
                  child: TextButton(
                    child: const Text(
                      'Mot de passe oublié',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFFAFB8BB),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MdpSection()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
