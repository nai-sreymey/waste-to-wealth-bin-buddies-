import 'package:flutter/material.dart';
import 'package:waste_friendly/screen/home_screen.dart';
import 'package:waste_friendly/screen/home_screen1.dart';
import 'package:waste_friendly/screen/home_screen2.dart';
import 'package:waste_friendly/screen/home_screen3.dart';
import 'package:waste_friendly/screen/home_screen4.dart';
import 'package:waste_friendly/screen/home_screen5.dart';
import 'package:waste_friendly/screen/home_screen6.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHome()
    );
  }
}

