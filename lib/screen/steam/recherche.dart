import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebasetest/screen/steam/accueil.dart';
import 'dart:convert';


class RecherchePage extends StatefulWidget {
  const RecherchePage({Key? key,}) : super(key: key);


  @override
  _RecherchePageState createState() => _RecherchePageState();
}

class _RecherchePageState extends State<RecherchePage> {
  late List data;
  Future<String> getData() async {
    var response = await http.get(Uri.parse(
        'https://steamcommunity.com/actions/SearchApps/call'));// A modifier et rajouter la récup de la recherche


    setState(() {
      var jsonResponse = json.decode(response.body);
      data = jsonResponse;
    });

    return "Success!";
  }



  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {

          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(data[index]["logo"]),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
              color: const Color(0xFF1E262C),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            padding: const EdgeInsets.only(left: 5),
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  (data[index]["icon"]),
                  height: 85,
                  width: 85,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]["name"],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccueilPage()
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    child: const Text(
                      'En savoir plus',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}




