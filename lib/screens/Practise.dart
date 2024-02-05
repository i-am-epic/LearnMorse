import 'package:flutter/material.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

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
    _buildMorseCard('A'),
    _buildMorseCard('B'),
    _buildMorseCard('C'),
    _buildMorseCard('D'),
    _buildMorseCard('E'),
    _buildMorseCard('F'),
    _buildMorseCard('G'),
    _buildMorseCard('H'),
    _buildMorseCard('I'),
    _buildMorseCard('J'),
    _buildMorseCard('K'),
    _buildMorseCard('L'),
    _buildMorseCard('M'),
    _buildMorseCard('N'),
    _buildMorseCard('O'),
    _buildMorseCard('P'),
    _buildMorseCard('Q'),
    _buildMorseCard('R'),
    _buildMorseCard('S'),
    _buildMorseCard('T'),
    _buildMorseCard('U'),
    _buildMorseCard('V'),
    _buildMorseCard('W'),
    _buildMorseCard('X'),
    _buildMorseCard('Y'),
    _buildMorseCard('Z'),
  ];

  Set<String> rightSwipedLetters = Set<String>();

  static Card _buildMorseCard(String letter) {
    final Map<String, String> pronunciationMap = {
      'A': 'di-dah',
      'B': 'dah-di-di-di',
      'C': 'dah-di-dah-di',
      'D': 'dah-di-di',
      'E': 'di',
      'F': 'di-di-dah-di',
      'G': 'dah-dah-di',
      'H': 'di-di-di-di',
      'I': 'di-di',
      'J': 'di-dah-dah-dah',
      'K': 'dah-di-dah',
      'L': 'di-dah-di-di',
      'M': 'dah-dah',
      'N': 'dah-di',
      'O': 'dah-dah-dah',
      'P': 'di-dah-dah-di',
      'Q': 'dah-dah-di-dah',
      'R': 'di-dah-di',
      'S': 'di-di-di',
      'T': 'dah',
      'U': 'di-di-dah',
      'V': 'di-di-di-dah',
      'W': 'di-dah-dah',
      'X': 'dah-di-di-dah',
      'Y': 'dah-di-dah-dah',
      'Z': 'dah-dah-di-di',
    };

    final Map<String, String> morseCodeMap = {
      'A': '.-',
      'B': '-...',
      'C': '-.-.',
      'D': '-..',
      'E': '.',
      'F': '..-.',
      'G': '--.',
      'H': '....',
      'I': '..',
      'J': '.---',
      'K': '-.-',
      'L': '.-..',
      'M': '--',
      'N': '-.',
      'O': '---',
      'P': '.--.',
      'Q': '--.-',
      'R': '.-.',
      'S': '...',
      'T': '-',
      'U': '..-',
      'V': '...-',
      'W': '.--',
      'X': '-..-',
      'Y': '-.--',
      'Z': '--..',
    };
    String pronunciation =
        pronunciationMap[letter] ?? ''; // Get the pronunciation from the map
    String morsecodestr =
        morseCodeMap[letter] ?? ''; // Get the pronunciation from the map

    return Card(
      key: Key(letter), // Use the letter as the key for each card
      color: Color.fromARGB(255, 0, 0, 0),
      shadowColor: Color.fromARGB(255, 80, 80, 80),
      surfaceTintColor: Color.fromARGB(255, 168, 168, 168),
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(30.0), // Adjust the radius as needed
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Image.asset(
            'lib/assets/Learn/$letter.png',
            height: 400,
            width: 350,
          ),
          SizedBox(height: 20),
          Text(
            letter,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 141, 141, 141),
            ),
          ),
          SizedBox(height: 20),
          Text(
            morsecodestr,
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 141, 141, 141),
            ),
          ),
          SizedBox(height: 20),
          Text(
            pronunciation,
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 141, 141, 141),
            ),
          ),
          SizedBox(height: 20),
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
    setState(() {
      // Remove the left-swiped letter from the current position
      morseCards.removeWhere((card) => card.key.toString() == letter);

      // Extract the actual letter
      String actualLetter = letter[3]; // Assuming the format is [<'T'>]

      print(actualLetter.toString().characters);
      // Add the left-swiped letter to the end of the list
      morseCards.add(_buildMorseCard(actualLetter));
    });
  }

  void _onRightSwipe(String letter) {
    debugPrint("Swiped right!");
    setState(() {
      // Add the right-swiped letter to the set
      rightSwipedLetters.add(letter);

      // Remove the right-swiped letter from the current position
      morseCards.removeWhere((card) => card.key.toString() == letter);
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
        title: Text('Swipe to learn Morse Code!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 48, 48, 48),
            )),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color.fromARGB(255, 31, 31, 31),
      body: Stack(
        children: [
          // Background Text
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center, // Align text to the center

                'You have swiped all the cards! Practice again.',
                style: TextStyle(
                  fontSize: 24,

                  color:
                      Colors.white.withOpacity(0.3), // Adjust opacity as needed
                ),
              ),
            ),
          ),
          Column(
            children: [
              NeumorphicButton(
                onPressed: _shuffleCards,
                style: const NeumorphicStyle(
                  color: Color.fromARGB(255, 22, 22, 22),
                  shape: NeumorphicShape.concave,
                  shadowDarkColor: Color.fromARGB(255, 0, 0, 0),
                  shadowLightColor: Color.fromARGB(255, 80, 80, 80),
                ),
                child: Icon(
                  Icons.shuffle,
                  color: Color.fromARGB(255, 141, 141, 141),
                ),
              ),
              Expanded(
                child: SwipingCardDeck(
                  cardDeck: morseCards
                      .where((card) =>
                          !rightSwipedLetters.contains(card.key.toString()))
                      .toList(),
                  onDeckEmpty: () => debugPrint("Card deck empty"),
                  onLeftSwipe: (Card card) => _onLeftSwipe(card.key.toString()),
                  onRightSwipe: (Card card) =>
                      _onRightSwipe(card.key.toString()),
                  swipeThreshold: MediaQuery.of(context).size.width / 4,
                  minimumVelocity: 800,
                  cardWidth: 200,
                  rotationFactor: 0.6 / 3.14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
