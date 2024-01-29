import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morse Code Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MorseCodeGameScreen(),
    );
  }
}

class MorseCodeGameScreen extends StatefulWidget {
  const MorseCodeGameScreen({super.key});

  @override
  _MorseCodeGameScreenState createState() => _MorseCodeGameScreenState();
}

class _MorseCodeGameScreenState extends State<MorseCodeGameScreen> {
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

  late String previousLetter;
  late String currentLetter;
  late String nextLetter;
  late String currentMorseCode;
  late String userGuess;
  late int points;
  late bool showHint;
  late Stopwatch stopwatch;
  late Timer? timer;
  Timer? resetTimer;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      previousLetter = '';
      currentLetter = getRandomLetter();
      nextLetter = getRandomLetter();
      currentMorseCode = morseCodeMap[currentLetter]!;
      userGuess = '';
      points = 0;
      showHint = false;
      stopwatch = Stopwatch();
      timer = null;
    });
  }

  String getRandomLetter() {
    final random = Random();
    final randomCharCode = random.nextInt(26) + 65;
    return String.fromCharCode(randomCharCode);
  }

  void startGuess() {
    if (timer != null) {
      timer!.cancel();
    }
    setState(() {
      stopwatch = Stopwatch()..start();
      timer = Timer(const Duration(seconds: 4), showHintIfTimeRunsOut);
      resetTimer = Timer(const Duration(seconds: 1), () {
        setState(() {
          userGuess = '';
        });
      });
    });
  }

  void showHintIfTimeRunsOut() {
    setState(() {
      showHint = true;
    });
  }

  void checkMorseCode() {
    if (userGuess == currentMorseCode) {
      setState(() {
        points += 3;
        previousLetter = currentLetter;
        currentLetter = nextLetter;
        timer?.cancel();
        userGuess = '';
        currentMorseCode = morseCodeMap[currentLetter]!;
        showHint = false;
        nextLetter = getRandomLetter();
      });
    } else {
      setState(() {
        points -= showHint ? 1 : 2;
      });
    }
  }

  void handleButtonPress(String buttonValue) {
    setState(() {
      userGuess += buttonValue;
      resetTimer?.cancel();
      startGuess();
      if (userGuess.length >= currentMorseCode.length) {
        checkMorseCode();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            'Learn Morse',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Points: $points'),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 250, 209, 195),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircle(nextLetter, faded: true, size: 70.0),
                _buildCircle(currentLetter, size: 100.0),
                _buildCircle(previousLetter, faded: true, size: 70.0),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              showHint ? currentMorseCode : '',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              userGuess,
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => handleButtonPress('.'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 79, 56, 47),
                  ),
                  child: Container(
                    width: 120,
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text(
                      '.',
                      style: TextStyle(fontSize: 70, color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => handleButtonPress('-'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 79, 56, 47),
                  ),
                  child: Container(
                    width: 120,
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text(
                      '-',
                      style: TextStyle(fontSize: 70, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(String letter, {bool faded = false, double size = 60.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: faded ? Colors.brown.withOpacity(0.5) : Colors.brown,
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
