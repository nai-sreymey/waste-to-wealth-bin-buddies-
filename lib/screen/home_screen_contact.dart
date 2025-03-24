import 'package:flutter/material.dart';
import 'package:waste_friendly/screen/home_screen_page.dart'; 
import 'package:waste_friendly/screen/home_screen4.dart';

class HomeScreenContact extends StatefulWidget {
  const HomeScreenContact({super.key});

  @override
  State<HomeScreenContact> createState() => _HomeScreenContactState();
}

class _HomeScreenContactState extends State<HomeScreenContact> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      // If the "Home" tab is tapped, navigate to the HomeScreenPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenPage()),
      );
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SchedulePickupScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Selected: $_selectedIndex",
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        backgroundColor: const Color.fromARGB(115, 255, 153, 0),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'Social',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
