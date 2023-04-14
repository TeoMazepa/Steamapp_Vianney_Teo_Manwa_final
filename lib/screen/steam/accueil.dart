import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebasetest/screen/steam/detailjeu.dart';
import 'package:firebasetest/screen/steam/like.dart';
import 'package:firebasetest/screen/steam/recherche.dart';
import 'package:firebasetest/screen/steam/whishlist.dart';
import 'package:material_color_generator/material_color_generator.dart';

import 'dart:core';

Future<List<Rank>> fetchGames(/*String searchQuery*/) async {
  try {
    final response = await http.get(
      Uri.https(
          'api.steampowered.com', '/ISteamChartsService/GetMostPlayedGames/v1'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
        'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );

    if (response.statusCode == 200) {
      return await _getGameDetails(
          Games.fromJson(jsonDecode(response.body)).ranks);
    } else {
      throw Exception('Failed to load games: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load games: $e');
  }
}

Future<List<Rank>> _getGameDetails(List<Rank> ranks) async {
  List<Rank> updatedRanks = [];
  for (var rank in ranks) {
    final response = await http.get(
      Uri.parse(
          'https://store.steampowered.com/api/appdetails?appids=${rank.appId}'),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody[rank.appId.toString()]['success']) {
        rank.name = jsonBody[rank.appId.toString()]['data']['name'];
        rank.publishers =
        jsonBody[rank.appId.toString()]['data']['publishers'][0];
        rank.header_image =
        jsonBody[rank.appId.toString()]['data']['header_image'];

        /*rank.bg_image =
        jsonBody[rank.appId.toString()]['data']['background'];*/

        rank.background_raw =
        jsonBody[rank.appId.toString()]['data']['background_raw'];

        rank.short_description =
        jsonBody[rank.appId.toString()]['data']['short_description'];
  /*rank.currency =
        jsonBody[rank.appId.toString()]['data']['price_overview']['currency'];
        rank.path_full =
        jsonBody[rank.appId.toString()]['data']['screenshots'];*/
      }
    }
    updatedRanks.add(rank);
  }
  return updatedRanks;
}

class Games {
  final int rollupDate;
  final List<Rank> ranks;

  Games({
    required this.rollupDate,
    required this.ranks,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      rollupDate: json['response']['rollup_date'],
      ranks: List<Rank>.from(
        json['response']['ranks'].map(
              (rankJson) => Rank.fromJson(rankJson),
        ),
      ),
    );
  }
}

class Rank {
  final int rank;
  final int appId;
  final int lastWeekRank;
  final int peakInGame;
  String? name;
  String? header_image;
  /*String? bg_image;*/
  String? background_raw;
  String? publishers;
  String? short_description;
  //String? path_full;


  Rank({
    required this.rank,
    required this.appId,
    required this.lastWeekRank,
    required this.peakInGame,
    this.name,
    this.header_image,
    /*this.bg_image,*/
    this.background_raw,
    this.publishers,
    this.short_description,
    //this.path_full,

  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
        rank: json['rank'],
        appId: json['appid'],
        lastWeekRank: json['last_week_rank'],
        peakInGame: json['peak_in_game'],
        name: json['name'],
        header_image: json['header_image'],
        //bg_image: json['bg_image'],
        background_raw: json['background_raw'],
        publishers: json['publishers'],
        short_description: json['short_description'],
        //path_full: json['path_full'],

    );
  }
}

class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  late Future<List<Rank>> futureGames;

  final TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureGames = fetchGames(/*string:searchQuery*/);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projet Steam',
      theme: ThemeData(
        primarySwatch: generateMaterialColor(color: Color(0xFF636AF6)),
        fontFamily: 'Proxima',
        scaffoldBackgroundColor: const Color(0xFF1A2025),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1A2025),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Accueil"), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LikePage()),
              );
            },
          ),
          IconButton(
              icon: const Icon(Icons.star_border),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WhishPage()),
                );
              }),
        ]),
        body: Center(
          child: FutureBuilder<List<Rank>>(
            future: futureGames,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final ranks = snapshot.data!;

                return ListView.builder(
                  itemCount: ranks.length,
                  itemBuilder: (context, index) {
                    final rank = ranks[index];
                    if (index == 0) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 45,
                            margin: const EdgeInsets.only(
                                left: 22, right: 22, top: 25.0, bottom: 10.0),
                            child: TextField(
                              controller: myController,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 15, color: Colors.white),
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: Color(0xFF636AF6),
                                    ),
                                    onPressed: () {
                                      //String value = Uri.encodeQueryComponent(myController.text);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const RecherchePage(),
                                        ),
                                      );
                                    }
                                ),
                                filled: true,
                                fillColor: const Color(0xFF1E262C),
                                border: const OutlineInputBorder(),
                                hintStyle: const TextStyle(
                                  color: Color(0xFFF2F2F2),
                                ),
                                hintText: 'Rechercher un jeu...',
                              ),
                            )
                          ),
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    '${ranks[0].background_raw}',
                                  ),
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${ranks[0].name}',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${ranks[0].short_description}',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(rank: rank)),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(4)),
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              )),
                                          child: const Text('En savoir plus')),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          Container(
                              margin:
                              const EdgeInsets.only(top: 22, right: 200),
                              child: const Text(
                                'Les meilleures vente',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                         image: DecorationImage(
                           image: NetworkImage('${rank.background_raw}'),
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
                            '${rank.header_image}',
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
                                  '${rank.name}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${rank.publishers}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 10,
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
                                      builder: (context) => DetailPage(rank: rank,)),
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
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
