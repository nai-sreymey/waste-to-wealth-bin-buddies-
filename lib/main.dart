import 'package:flutter/material.dart';

import 'package:waste_friendly/screen/home_screen_contact.dart';
import 'package:waste_friendly/screen/home_screen_list.dart';
import 'package:waste_friendly/screen/home_screen_page.dart';
// import 'package:waste_friendly/screen/home_screen_page.dart';
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
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHome()
    );
  }
}

