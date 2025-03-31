import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_friendly/controllers/points_controller.dart';
import 'package:waste_friendly/screen/home_screen_contact.dart';
import 'package:waste_friendly/screen/home_screen_page.dart';
import 'package:waste_friendly/screen/socai_screen.dart';
import 'package:waste_friendly/screen/login_screen.dart';
import 'package:waste_friendly/screen/profile_screen.dart';
import 'package:waste_friendly/screen/register_screen.dart';
import 'package:waste_friendly/screen/splash_screen.dart';
import 'package:waste_friendly/screen/success_screen.dart';
import 'package:waste_friendly/screen/schedule_pickup_screen.dart';
import 'package:waste_friendly/screen/history_pickup_screen.dart';
import 'package:waste_friendly/screen/reward_screen.dart';
import 'package:waste_friendly/screen/redeem_history.dart';
import 'package:waste_friendly/screen/home_screen_list.dart';


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
        // Initial screen should be the splash screen
        initialRoute: '/splash',
        routes: {
          '/homeScreenContact': (context) => HomeScreenContact(),
          '/home': (context) => HomeScreenPage(),
          '/schedule': (context) => SchedulePickupScreen(),
          // '/homeScreenList': (context) => Acti(),
          '/splash': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/success': (context) => SuccessScreen(),
          '/history': (context) => PickupHistoryScreen(),
          '/reward': (context) => RewardsScreen(),
          '/redeem': (context) => RedeemHistory(),
        },
      ),
    );
  }
}
