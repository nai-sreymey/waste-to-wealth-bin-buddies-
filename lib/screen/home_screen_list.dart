import 'package:flutter/material.dart';
import 'package:waste_friendly/controllers/ativity_controller.dart';
import 'package:waste_friendly/models/ativity_controller.dart';
import 'package:waste_friendly/screen/home_screen_page.dart'; // Import your HomeScreenPage

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final ActivityController _activityController = ActivityController();
  late Future<List<Activity>> _activities;

  @override
  void initState() {
    super.initState();
    _activities = _activityController.fetchActivity(); // Specify limit
  }

  Future<void> _refreshActivities() async {
    setState(() {
      _activities = _activityController.fetchActivity(); // Refresh with limit
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to HomeScreenPage when back button is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreenPage()), // Change this to your HomeScreenPage
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Adding padding of 10 pixels
        child: FutureBuilder<List<Activity>>(
          future: _activities,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No activities found'));
            } else {
              return RefreshIndicator(
                onRefresh: _refreshActivities,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final activity = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/logo.png', // Placeholder image
                          height: 40,
                          width: 40,
                        ),
                        title: Text(activity.title),
                        subtitle: Text(activity.description),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '+7 points', // Replace with dynamic points if available
                              style: TextStyle(color: Colors.orange),
                            ),
                            Text(
                              '${activity.date}', // Format date as required
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


