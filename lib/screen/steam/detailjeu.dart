import 'package:flutter/material.dart';
import 'accueil.dart';

class DetailPage extends StatelessWidget {
  final Rank rank;
  const DetailPage({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail jeu"), actions: const <Widget>[
        MyIconButton(),
        MyIconButtonE(),
      ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Image.network(
                  '${rank.background_raw}',
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF1E262C).withOpacity(0.5),
                      ),
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 35.0),
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      height: 100,
                      width: 350,
                      child: Row(
                        children: <Widget>[
                          Image.network('${rank.header_image}',
                            width: 120,
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
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${rank.publishers}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            MyButtonsWidget(rank: rank),

          ],
        ),
      ),
    );
  }
}

class MyIconButton extends StatefulWidget {
  const MyIconButton({Key? key}) : super(key: key);

  @override
  _MyIconButtonState createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.white : null,
      ),
      onPressed: _toggleFavorite,
    );
  }
}

class MyIconButtonE extends StatefulWidget {
  const MyIconButtonE({Key? key}) : super(key: key);

  @override
  _MyIconButtonStateE createState() => _MyIconButtonStateE();
}

class _MyIconButtonStateE extends State<MyIconButtonE> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.star : Icons.star_border,
        color: isFavorite ? Colors.white : null,
      ),
      onPressed: _toggleFavorite,
    );
  }
}

class MyButtonsWidget extends StatefulWidget {
  const MyButtonsWidget({super.key, required this.rank});
  final Rank rank;


  @override
  _MyButtonsWidgetState createState() => _MyButtonsWidgetState();
}

class _MyButtonsWidgetState extends State<MyButtonsWidget> {
  int _activeIndex = 0;

   getButton() {
    switch (_activeIndex) {
      case 0:
        return Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            '${widget.rank.short_description}',
            //getButtonText(),
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),

        );
      case 1:
        return const ButtonDesc();
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 18.0, bottom: 17, left: 10, right: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _activeIndex = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(0xFF636AF6),
                    ), backgroundColor: _activeIndex == 0
                        ? const Color(0xFF636AF6)
                        : const Color(0xFF1A2025),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  child: const Text('DESCRIPTION'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _activeIndex = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(0xFF636AF6),
                    ), backgroundColor: _activeIndex == 1
                        ? const Color(0xFF636AF6)
                        : const Color(0xFF1A2025),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  child: const Text('AVIS'),
                ),
              ),
            ],
          ),
        ),
        getButton(),

      ],
    );
  }
}

class ButtonDesc extends StatelessWidget{
  const ButtonDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xFF1E262C),
        ),
        margin: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 15.0),
        height: 100,
        width: 353,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                  top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:  [
                  const Text(
                    'Nom de l\'utilisateur',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                      children:  const [
                        Icon(Icons.star, color: Colors.yellow, size: 14.0),
                        Icon(Icons.star, color: Colors.yellow, size: 14.0),
                        Icon(Icons.star, color: Colors.yellow, size: 14.0),
                        Icon(Icons.star, color: Colors.yellow, size: 14.0),
                        Icon(Icons.star, color: Colors.yellow, size: 14.0),
                      ]
                  )

                ],
              ),
            ),
            Container(

                margin: const EdgeInsets.only(
                    left: 20.0,right: 20.0, top: 10),

                child: const Text(
                    'Bacon ipsum dolor amet rump doner brisket corned beef tri-tip. Burgdoggen t-bone leberkas, tri-tip bacon beef ribs corned beef meatball',

                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                  ),)
            ),
          ],
        ));
  }
}