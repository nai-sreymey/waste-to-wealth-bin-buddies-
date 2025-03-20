import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // You can perform navigation here based on the selected index
    if (_selectedIndex == 0) {
      // If the "Home" tab is tapped, navigate to the HomeScreenPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenPage()),
      );
    }
  }

  final List<Map<String, String>> activities = [
    {
      'title': 'Plastic Collection',
      'subtitle': '4.8 kg',
      'image': 'assets/images/logo.png',
      'points': '+7 points',
      'date': 'Yesterday',
    },
    {
      'title': 'Paper Recycling',
      'subtitle': '5.3 kg',
      'image': 'assets/images/logo.png',
      'points': '+10 points',
      'date': '2 days ago',
    },
    {
      'title': 'Glass Collection',
      'subtitle': '3.1 kg',
      'image': 'assets/images/logo.png',
      'points': '+5 points',
      'date': 'Last week',
    },
  ];

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChart(),
            const SizedBox(height: 20),
            const Text(
              'Action',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton('Schedule Pickup', 'assets/images/Layer 25.png'),
                _actionButton('Redeem', 'assets/images/Group.png'),
              ],
            ),
            const SizedBox(height: 20),
            _carousel(),
            const SizedBox(height: 20),
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            _recentActivity(),
            const SizedBox(height: 20),
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

  Widget _buildChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total Points',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '190 points',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              '19\$',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.blue,
                  value: 2.8,
                  title: 'Plastic',
                  radius: 50,
                ),
                PieChartSectionData(
                  color: Colors.green,
                  value: 5.3,
                  title: 'Paper',
                  radius: 50,
                ),
                PieChartSectionData(
                  color: Colors.red,
                  value: 2.1,
                  title: 'Glass',
                  radius: 50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(String title, String iconPath) {
    return Container(
      width: 150,
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Image.asset(iconPath, height: 60),
          ),
        ],
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

  Widget _recentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: activities.map((activity) => _activityItem(activity)).toList(),
    );
  }

  Widget _activityItem(Map<String, String> activity) {
    return Card(
      child: ListTile(
        leading: Image.asset(activity['image']!, height: 40),
        title: Text(activity['title']!),
        subtitle: Text(activity['subtitle']!),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(activity['points']!, style: const TextStyle(color: Colors.orange)),
            Text(activity['date']!),
          ],
        ),
      ),
    );
  }
}
