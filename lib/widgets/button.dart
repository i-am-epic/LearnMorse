import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import '../screens/Learn.dart'; // Import your main screen widget
import '../main.dart'; // Import your main screen widget

class CustomButton extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final double? height;
  final double? borderRadius;
  final String? page;
  const CustomButton({
    Key? key,
    this.imagePath,
    this.title = 'Button', // Provide a default value here
    this.height = 40.0,
    this.borderRadius,
    this.page = 'main',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Size(100.0, 20.0); // Set the fixed width value here
    return NeumorphicButton(
      minDistance: -2.0,
      curve: Curves.easeInToLinear,
      //padding: const EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      onPressed: () {
        print("onClick");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // Use the page property to determine which screen to navigate to
              switch (page) {
                case 'Learn':
                  return MyApp(); // Replace with your LearnScreen widget
                case 'other':
                  return MyApp(); // Replace with your OtherScreen widget
                default:
                  return Container(); // Return a default widget or handle the case
              }
            },
          ),
        );
      },
      provideHapticFeedback: true,
      style: const NeumorphicStyle(
        color: Color.fromARGB(255, 22, 22, 22),
        shape: NeumorphicShape.concave,
        shadowDarkColor: Color.fromARGB(255, 0, 0, 0),
        shadowLightColor: Color.fromARGB(255, 80, 80, 80),
      ),
      child: Text(
        title!,
        style: TextStyle(
          color: Color.fromARGB(255, 141, 141, 141),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
