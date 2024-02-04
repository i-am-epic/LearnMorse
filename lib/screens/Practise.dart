import 'package:flutter/material.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

void main() {
  runApp(Learn());
}

class Learn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LearnMorseCodePage(),
    );
  }
}

class LearnMorseCodePage extends StatelessWidget {
  final List<Card> morseCards = [
    _buildMorseCard('A', '.-'),
    _buildMorseCard('B', '-...'),
    // ... Add cards for other letters
    _buildMorseCard('Z', '--..'),
  ];

  static Card _buildMorseCard(String letter, String morseValue) {
    return Card(
      color: Colors.blue, // Customize the color as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Learn/$letter.png', // Adjust the path to your image
            height: 150, // Set the height of the image
          ),
          SizedBox(height: 20),
          Text(
            letter,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            morseValue,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Morse Code'),
      ),
      body: SwipingCardDeck(
        cardDeck: morseCards,
        onDeckEmpty: () => debugPrint("Card deck empty"),
        onLeftSwipe: (Card card) => debugPrint("Swiped left!"),
        onRightSwipe: (Card card) => debugPrint("Swiped right!"),
        swipeThreshold: MediaQuery.of(context).size.width / 4,
        minimumVelocity: 800,
        cardWidth: 200,
        rotationFactor: 0.6 / 3.14,
      ),
    );
  }
}
