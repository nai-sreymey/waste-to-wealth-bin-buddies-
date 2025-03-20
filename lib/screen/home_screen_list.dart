import 'package:flutter/material.dart';

class HomeScreenList extends StatefulWidget {
  const HomeScreenList({super.key});

  @override
  State<HomeScreenList> createState() => _HomeScreenListState();
}

class _HomeScreenListState extends State<HomeScreenList> {
  // Sample list of activity data
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
    {
      'title': 'Glass Collection',
      'subtitle': '3.1 kg',
      'image': 'assets/images/logo.png',
      'points': '+5 points',
      'date': 'Last week',
    },
    {
      'title': 'Glass Collection',
      'subtitle': '3.1 kg',
      'image': 'assets/images/logo.png',
      'points': '+5 points',
      'date': 'Last week',
    },
    {
      'title': 'Glass Collection',
      'subtitle': '3.1 kg',
      'image': 'assets/images/logo.png',
      'points': '+5 points',
      'date': 'Last week',
    },
    {
      'title': 'Glass Collection',
      'subtitle': '3.1 kg',
      'image': 'assets/images/logo.png',
      'points': '+5 points',
      'date': 'Last week',
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This will navigate back to the previous screen
          },
        ),
        // title: const Text('Home Screen'),
        // backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _recentActivity(),
      ),
    );
  }

  Widget _recentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('See All', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
        // Looping through the activities list and creating a widget for each
        ...activities.map((activity) => _activityItem(activity)).toList(),
      ],
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
