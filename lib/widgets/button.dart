import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import '../screens/Learn.dart'; // Import your main screen widget
import '../main.dart'; // Import your main screen widget
import '../screens/Practise.dart'; // Import your main screen widget
import '../screens/AnalyticsPage.dart'; // Import your main screen widget

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
    return Container(
        width: 300.0,
        height: 80.0,
        child: NeumorphicButton(
          minDistance: -2.0,
          curve: Curves.easeInToLinear,
          //padding: const EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 25),
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
                    case 'Practise':
                      return Learn(); // Replace with your OtherScreen widget
                    default:
                      return Container(); // Return a default widget or handle the case
                  }
                },
              ),
            );
          },
          provideHapticFeedback: true,
          style: NeumorphicStyle(
            color: Color.fromARGB(255, 22, 22, 22),
            shape: NeumorphicShape.concave,
            shadowDarkColor: Color.fromARGB(255, 0, 0, 0),
            shadowLightColor: Color.fromARGB(255, 80, 80, 80),
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(60))),
          ),
          child: Text(
            title!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Color.fromARGB(255, 141, 141, 141),
            ),
          ),
        ));
  }
}
