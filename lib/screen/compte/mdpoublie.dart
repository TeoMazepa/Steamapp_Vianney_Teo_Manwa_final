import 'package:flutter/material.dart';
import 'package:firebasetest/screen/steam/accueil.dart';

class MdpSection extends StatelessWidget {
  const MdpSection({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/bgapp.png"), fit: BoxFit.cover),
    ),
    child:Center(
        child: Column(
          children:  <Widget>[
            const SizedBox(height:50,),

            const Text('Mot de passe oublié',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'GSans',
              ),
            ),

            Container(
              margin: const EdgeInsets.only(
                top: 12.0,),
              height: 30,
              width: 300,
              child: const Text('Veuillez saisir votre email afin de réinitialiser votre mot de passe',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),),
            ),

            Container(
              height: 45,
              margin: const EdgeInsets.only(left: 22, right: 22,top: 41.0,),
              child: const TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                ),
                textAlign: TextAlign.center,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF1E262C),
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Color(0xFFF2F2F2),),
                  hintText: 'Mot de passe',

                ),
              ),
            ),

            Container(
                margin: const EdgeInsets.only(left: 22, right: 22,top: 71.0,),
                height: 45,
                width: mediaQueryData.size.height,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const AccueilPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,)),
                    child: const Text('Renvoyer mon mot de passe'))
            ),

          ],
        ),
      ),

      ),
    );
  }
}
