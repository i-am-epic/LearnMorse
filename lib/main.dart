import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'widgets/button.dart'; // Import your custom button widget
import 'screens/Learn.dart'; // Import your main screen widget

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // Add your logic to handle the sign-in success
    } catch (error) {
      // Add your logic to handle sign-in failure
      print("Error during sign-in: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Morse Code App'),
        forceMaterialTransparency: true,
      ),
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              title: 'Learn',
              page: 'Learn',
            ),
            SizedBox(height: 20),
            CustomButton(
              title: 'Practice',
              page: 'Learn',
            ),
            SizedBox(height: 20),
            CustomButton(
              title: 'Multiplayer',
              page: 'Learn',
            ),
            SizedBox(height: 20),
            CustomButton(
              title: 'Settings',
              page: 'Learn',
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    routes: {
      'main': (context) => HomeScreen(),
      'other': (context) => MyApp(),
      // Add more routes as needed
    },
  ));
}
