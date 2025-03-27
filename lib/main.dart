

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_friendly/controllers/points_controller.dart';
import 'package:waste_friendly/screen/home_screen_social.dart';
import 'package:waste_friendly/screen/login_screen.dart';
import 'package:waste_friendly/screen/profile_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PointsController(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Waste Friendly App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login', // You might want to ensure that '/login' is a valid route
        routes: {
          '/': (context) => ProfileScreen(),
          '/login': (context) => LoginScreen(), // Make sure this screen exists

        },
      ),
    );
  }
}
