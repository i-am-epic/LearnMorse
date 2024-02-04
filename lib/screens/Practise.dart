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

class LearnMorseCodePage extends StatefulWidget {
  @override
  _LearnMorseCodePageState createState() => _LearnMorseCodePageState();
}

class _LearnMorseCodePageState extends State<LearnMorseCodePage> {
  final List<Card> morseCards = [
    _buildMorseCard('A', '.-'),
    _buildMorseCard('B', '-...'),
    _buildMorseCard('C', '-.-.'),
    _buildMorseCard('D', '-..'),
    _buildMorseCard('E', '.'),
    _buildMorseCard('F', '..-.'),
    _buildMorseCard('G', '--.'),
    _buildMorseCard('H', '....'),
    _buildMorseCard('I', '..'),
    _buildMorseCard('J', '.---'),
    _buildMorseCard('K', '-.-'),
    _buildMorseCard('L', '.-..'),
    _buildMorseCard('M', '--'),
    _buildMorseCard('N', '-.'),
    _buildMorseCard('O', '---'),
    _buildMorseCard('P', '.--.'),
    _buildMorseCard('Q', '--.-'),
    _buildMorseCard('R', '.-.'),
    _buildMorseCard('S', '...'),
    _buildMorseCard('T', '-'),
    _buildMorseCard('U', '..-'),
    _buildMorseCard('V', '...-'),
    _buildMorseCard('W', '.--'),
    _buildMorseCard('X', '-..-'),
    _buildMorseCard('Y', '-.--'),
    _buildMorseCard('Z', '--..'),
  ];

  Set<String> rightSwipedLetters = Set<String>();

  static Card _buildMorseCard(String letter, String morseValue) {
    return Card(
      key: Key(letter), // Use the letter as the key for each card
      color: Color.fromARGB(255, 44, 44, 44),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            '/Users/nikhilav/Development/projects/morselearn/morselearn/lib/assets/Learn/$letter.png',
            height: 400,
            width: 300,
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

  void _shuffleCards() {
    setState(() {
      morseCards.shuffle();
      //rightSwipedLetters.clear(); // Reset the set of right-swiped letters
    });
  }

  void _onLeftSwipe(String letter) {
    debugPrint("Swiped left!");
    // Implement logic for left swipe if needed
  }

  void _onRightSwipe(String letter) {
    debugPrint("Swiped right!");
    setState(() {
      rightSwipedLetters.add(letter); // Add the right-swiped letter to the set
    });

    // Check if all cards have been right-swiped
    if (rightSwipedLetters.length == morseCards.length) {
      debugPrint("Right-swiped all cards! Practice again.");
      // You can display a message or perform any other action here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Morse Code'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: _shuffleCards,
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: SwipingCardDeck(
        cardDeck: morseCards
            .where((card) => !rightSwipedLetters.contains(card.key.toString()))
            .toList(),
        onDeckEmpty: () => debugPrint("Card deck empty"),
        onLeftSwipe: (Card card) => _onLeftSwipe(card.key.toString()),
        onRightSwipe: (Card card) => _onRightSwipe(card.key.toString()),
        swipeThreshold: MediaQuery.of(context).size.width / 4,
        minimumVelocity: 800,
        cardWidth: 200,
        rotationFactor: 0.6 / 3.14,
      ),
    );
  }
}
