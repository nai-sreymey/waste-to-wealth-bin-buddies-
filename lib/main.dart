import 'package:flutter/material.dart';
import 'package:waste_friendly/screen/home_screen_contact.dart';
import 'package:waste_friendly/screen/home_screen_list.dart';
import 'package:waste_friendly/screen/home_screen_page.dart';
// import 'package:waste_friendly/screen/home_screen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreenContact(), // Your initial page
    );
  }
}

// Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(builder: (context) => const ()),
// );

