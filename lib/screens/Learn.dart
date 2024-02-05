import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:vibration/vibration.dart';
import 'dart:async'; // for Timer
import 'dart:math'; // for Random
import 'AnalyticsPage.dart';
import '../models/CharacterAnalytics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

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
  const MorseCodeGameScreen({Key? key});

  @override
  _MorseCodeGameScreenState createState() => _MorseCodeGameScreenState();
}

class _MorseCodeGameScreenState extends State<MorseCodeGameScreen> {
  final Map<String, String> morseCodeMap = {
    'A': '·-',
    'B': '-···',
    'C': '-·-·',
    'D': '-··',
    'E': '·',
    'F': '··-·',
    'G': '--·',
    'H': '····',
    'I': '··',
    'J': '·---',
    'K': '-·-',
    'L': '·-··',
    'M': '--',
    'N': '-·',
    'O': '---',
    'P': '·--·',
    'Q': '--·-',
    'R': '·-·',
    'S': '···',
    'T': '-',
    'U': '··-',
    'V': '···-',
    'W': '·--',
    'X': '-··-',
    'Y': '-·--',
    'Z': '--··',
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
  Map<String, CharacterAnalytics> characterAnalyticsMap = {};

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
      timer = Timer(const Duration(seconds: 8), showHintIfTimeRunsOut);
    });
  }

  void vibrate() async {
    final hasVibrator = await Vibration.hasCustomVibrationsSupport();
    if (hasVibrator!) {
      Vibration.vibrate(pattern: [1, 500, 10, 1000], intensities: [1, 255]);
      print('Vibrating2');
    } else {
      Vibration.vibrate();
      await Future.delayed(Duration(milliseconds: 180));
      Vibration.vibrate();
    }
  }

  void vibrate2() async {
    final hasVibrator = await Vibration.hasAmplitudeControl();
    if (hasVibrator!) {
      //Vibration.vibrate(duration: 500, amplitude: 20, intensities: [1]);
      print('Vibrating');
    } else {
      Vibration.vibrate();
      await Future.delayed(Duration(milliseconds: 5));
      Vibration.vibrate();
    }
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

  void checkMorseCode() async {
    if (userGuess == currentMorseCode) {
      final elapsedMilliseconds =
          stopwatch.elapsedMilliseconds; // Store the elapsed time
      stopwatch.stop(); // Stop the stopwatch here
      setState(() {
        points += 3;

        // Update analytics for the character
        characterAnalyticsMap.update(
          currentLetter,
          (analytics) {
            return CharacterAnalytics(
              correctAttempts: analytics.correctAttempts + 1,
              totalAttempts: analytics.totalAttempts + 1,
              totalTime: analytics.totalTime + elapsedMilliseconds,
              hintsUsed: analytics.hintsUsed, // No change in hintsUsed
            );
            
          },
          ifAbsent: () {
            return CharacterAnalytics(
              correctAttempts: 1,
              totalAttempts: 1,
              totalTime: elapsedMilliseconds,
              hintsUsed: 0, // Initialize hintsUsed
            );
          },
        );

        previousLetter = currentLetter;
        currentLetter = nextLetter;
        userGuess = '';
        currentMorseCode = morseCodeMap[currentLetter]!;
        showHint = false;
        vibrate2();
        nextLetter = getRandomLetter();

        // Start a new timer after updating UI
        timer = Timer(const Duration(seconds: 10), showHintIfTimeRunsOut);
      });
    } else {
      final elapsedMilliseconds =
          stopwatch.elapsedMilliseconds; // Store the elapsed time
      stopwatch.stop(); // Stop the stopwatch here
      setState(() {
        points -= showHint ? 1 : 2;

        // Update analytics for the character
        characterAnalyticsMap.update(
          currentLetter,
          (analytics) {
            return CharacterAnalytics(
              correctAttempts: analytics.correctAttempts,
              totalAttempts: analytics.totalAttempts + 1,
              totalTime: analytics.totalTime + elapsedMilliseconds,
              hintsUsed:
                  showHint ? analytics.hintsUsed + 1 : analytics.hintsUsed,
            );
          },
          ifAbsent: () {
            return CharacterAnalytics(
              correctAttempts: 0,
              totalAttempts: 1,
              totalTime: elapsedMilliseconds,
              hintsUsed: showHint ? 1 : 0,
            );
          },
        );
        userGuess = '';
        vibrate();
        // Start a new timer after updating UI
        timer = Timer(const Duration(seconds: 2), showHintIfTimeRunsOut);
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

  void showAnalyticsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Character Analytics'),
          content: Column(
            children: characterAnalyticsMap.entries
                .map(
                  (entry) => ListTile(
                    title: Text(entry.key),
                    subtitle: Text(
                      'Correct Attempts: ${entry.value.correctAttempts}\nTotal Attempts: ${entry.value.totalAttempts}',
                    ),
                  ),
                )
                .toList(),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Practice Morse',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 141, 141, 141),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Points: $points',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalyticsPage(characterAnalyticsMap),
                ),
              );
            },
            icon: Icon(Icons.analytics),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircle(nextLetter, faded: true, size: 80.0),
                _buildCircle(currentLetter, size: 120.0),
                _buildCircle(previousLetter, faded: true, size: 80.0),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              showHint ? currentMorseCode : '',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 141, 141, 141),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              userGuess,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(251, 121, 85, 72),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeumorphicButton(
                  padding: const EdgeInsets.fromLTRB(65, 100, 65, 100),
                  onPressed: () => handleButtonPress('·'),
                  provideHapticFeedback: true,
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.all(Radius.circular(60))),
                    color: Color.fromARGB(255, 22, 22, 22),
                    shape: NeumorphicShape.concave,
                    shadowDarkColor: Color.fromARGB(255, 0, 0, 0),
                    shadowLightColor: Color.fromARGB(255, 80, 80, 80),
                  ),
                  child: Text(
                    '·',
                    style: TextStyle(
                      color: Color.fromARGB(255, 141, 141, 141),
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                NeumorphicButton(
                  onPressed: () => handleButtonPress('-'),
                  provideHapticFeedback: true,
                  padding: const EdgeInsets.fromLTRB(65, 100, 65, 100),
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.all(Radius.circular(60))),
                    color: Color.fromARGB(255, 22, 22, 22),
                    shape: NeumorphicShape.concave,
                    shadowDarkColor: Color.fromARGB(255, 0, 0, 0),
                    shadowLightColor: Color.fromARGB(255, 80, 80, 80),
                  ),
                  child: Text(
                    '-',
                    style: TextStyle(
                      color: Color.fromARGB(255, 141, 141, 141),
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                )
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
