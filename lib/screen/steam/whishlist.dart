import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebasetest/screen/steam/accueil.dart';

class WhishPage extends StatelessWidget {
  const WhishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ma liste de souhaits"),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                IconButton(
                  iconSize: 94,
                  onPressed: ()  {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AccueilPage()),
                    );
                  },
                  icon: SvgPicture.asset('assets/logo/empty_whishlist.svg'),),


                const SizedBox(
                  width: 300,
                  child: Text('Vous n’avez encore pas liké de contenu. Cliquez sur le coeur pour en rajouter.',textAlign: TextAlign.center,
                    style: TextStyle(
                        color:Colors.white,
                        fontSize:15
                    ),
                  ),


                )


              ]
          )
      ),

    );
  }
}