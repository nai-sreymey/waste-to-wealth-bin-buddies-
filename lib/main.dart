import 'package:flutter/material.dart';
import 'package:waste_friendly/screen/home_screen_page.dart';
import 'package:waste_friendly/screen/home_screen_contact.dart';
import 'package:waste_friendly/screen/home_screen_list.dart';
import 'package:waste_friendly/screen/splash_screen.dart';
import 'package:waste_friendly/screen/login_screen.dart';
import 'package:waste_friendly/screen/register_screen.dart';
import 'package:waste_friendly/screen/success_screen.dart';
import 'package:waste_friendly/screen/schedule_pickup_screen.dart';
import 'package:waste_friendly/screen/history_pickup_screen.dart';
import 'package:waste_friendly/screen/reward_screen.dart';

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
      // Initial screen should be the login page
      initialRoute: '/login',
      routes: {
        '/homeScreenContact': (context) => HomeScreenContact(),
        '/home': (context) => HomeScreenPage(),
        '/schedule': (context) => SchedulePickupScreen(),
        '/homeScreenList': (context) => HomeScreenList(),
        '/splash': (context) => MyHome(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/success': (context) => SuccessScreen(),
        '/pickupHistory': (context) => MyApp1(),
        '/reward': (context) => MyApp2(),
      },
    );
  }
}
