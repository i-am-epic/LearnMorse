import 'package:flutter/material.dart';
import '../models/CharacterAnalytics.dart';

class AnalyticsPage extends StatelessWidget {
  final Map<String, CharacterAnalytics> characterAnalyticsMap;

  AnalyticsPage(this.characterAnalyticsMap);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character Analytics'),
        backgroundColor:
            Color.fromARGB(255, 32, 32, 32), // Set your custom background color
      ),
      body: Container(
        color:
            Color.fromARGB(255, 32, 32, 32), // Set your custom background color
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: characterAnalyticsMap.length,
            itemBuilder: (context, index) {
              final entry = characterAnalyticsMap.entries.toList()[index];
              final character = entry.key;
              final analytics = entry.value;

              return Card(
                color:
                    Colors.brown.withOpacity(0.8), // Set your custom card color
                elevation: 5.0, // Set your custom elevation
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Character: $character',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set your custom text color
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Correct Attempts: ${analytics.correctAttempts}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Set your custom text color
                        ),
                      ),
                      Text(
                        'Total Attempts: ${analytics.totalAttempts}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Set your custom text color
                        ),
                      ),
                      Text(
                        'Total Time: ${analytics.totalTime} milliseconds',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Set your custom text color
                        ),
                      ),
                      Text(
                        'Hints Used: ${analytics.hintsUsed}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Set your custom text color
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
