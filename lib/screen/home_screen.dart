import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple, // Background color similar to your splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Waste to",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Adjusted text color to white for better contrast
              ),
            ),
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/logo.png', // Correct image path
              width: 138, // Adjust size as needed
              height: 139,
            ),
            const SizedBox(height: 50),
            const Text(
              "Wealth",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Adjusted text color to white for better contrast
              ),
            ),
          ],
        ),
      ),
    );
  }
}
