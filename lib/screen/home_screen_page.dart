import 'package:flutter/material.dart';
import 'package:waste_friendly/component/points_screen.dart';
import 'package:waste_friendly/controllers/ativity_controller.dart';
import 'package:waste_friendly/models/ativity_controller.dart';
import 'package:waste_friendly/screen/history_pickup_screen.dart';
import 'package:waste_friendly/screen/home_screen_list.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart package
import 'package:waste_friendly/screen/socai_screen.dart';
import '../screen/home_screen_page.dart'; // Import the history screen
import 'schedule_pickup_screen.dart'; // Import SchedulePickupScreen
import '../screen/reward_screen.dart'; // Import RewardsScreen
import '../screen/socai_screen.dart'; // Import SocialScreen (assuming you create this screen)
import 'profile_screen.dart'; // Import ProfileScreen (assuming you create this screen)

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  int _selectedIndex = 0;
  late Future<List<Activity>> _activities;

  @override
  void initState() {
    super.initState();
    _activities = ActivityController().fetchActivity(); // Fetch activities dynamically
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }

    // Navigation logic for BottomNavigationBar tabs
    if (index == 1) {
      // Navigate to History screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PickupHistoryScreen()),
      );
    } else if (index == 2) {
      // Navigate to Social screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenSocial()),
      );
    } else if (index == 3) {
      // Navigate to Profile screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'BIN BUDDIES',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Added padding to the whole screen
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PointsScreen(),
            const SizedBox(height: 20),
            _buildChart(),
            const Text(
              'Action',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton(
                  'Schedule Pickup',
                  'assets/images/Layer 25.png',
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SchedulePickupScreen()),
                    );
                  },
                ),
                _actionButton(
                  'Redeem',
                  'assets/images/Group.png',
                  () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RewardsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            _carousel(),
            const SizedBox(height: 20),
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const SizedBox(height: 10),
            _recentActivity(context), // Pass context
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        backgroundColor: const Color.fromARGB(115, 255, 153, 0),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Social'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _actionButton(String title, String iconPath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed, // Use the callback function here
      child: Container(
        width: 150,
        height: 150,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Image.asset(iconPath, height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _carousel() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage('assets/images/enviroment.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _recentActivity(BuildContext context) {
    return FutureBuilder<List<Activity>>(
      future: _activities,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No activities found'));
        } else {
          final activities = snapshot.data!.take(3).toList();
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return _activityItem(activities[index]);
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ActivityScreen()),
                    );
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _activityItem(Activity activity) {
    return Card(
      child: ListTile(
        leading: Image.asset('assets/images/logo.png', height: 40),
        title: Text(activity.title),
        subtitle: Text(activity.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('+7 points', style: TextStyle(color: Colors.orange)),
            Text('${activity.date}'),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: [FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2), FlSpot(3, 4)],
                isCurved: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
