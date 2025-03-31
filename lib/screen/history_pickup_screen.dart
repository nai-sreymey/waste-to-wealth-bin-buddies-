import 'dart:ui'; // Add this import for ImageFilter
import 'package:flutter/material.dart';
import 'package:waste_friendly/models/history_pickup.dart';
import 'package:waste_friendly/controllers/history_pickup_controller.dart';
import 'package:waste_friendly/screen/home_screen_page.dart';

class PickupHistoryScreen extends StatefulWidget {
  const PickupHistoryScreen({super.key});

  @override
  _PickupHistoryScreenState createState() => _PickupHistoryScreenState();
}

class _PickupHistoryScreenState extends State<PickupHistoryScreen> {
  final HistoryController _historyController = HistoryController();
  bool isDataLoading = false; // Track loading state
  List<HistoryModel> pickups = []; // List to hold fetched pickups

  @override
  Widget build(BuildContext context) {
    Color mainColor = const Color(0xFFF26606); // Main color for styling

    return Scaffold(
      backgroundColor: Colors.grey[100], // Background color for the entire screen
      appBar: AppBar(
        title: const Text(
          'Pickup History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back to the Home screen
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenPage()),
      );
          },
        ),
      ),
      body: Stack(
        children: [
          // Backdrop filter to create the 20% opacity effect with the same background color
          if (isDataLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.orange.withOpacity(0.2),
                ),
              ),
            ),
          // Main content
          AbsorbPointer(
            absorbing: isDataLoading, // Disable interaction when data is loading
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Listing Pickup History',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xF32E553B),
                    ),
                  ),
                  const SizedBox(height: 25),
                  FutureBuilder<List<HistoryModel>>(
                    future: _historyController.fetchPickup(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No pickups found'));
                      }

                      pickups = snapshot.data!; // Store fetched pickups

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: pickups.length,
                        itemBuilder: (context, index) {
                          HistoryModel pickup = pickups[index];

                          Color statusColor;
                          bool canCancel = true;

                          switch (pickup.status.toLowerCase()) {
                            case 'completed':
                              statusColor = const Color(0xFF51BB20); // Green
                              canCancel = false;
                              break;
                            case 'canceled':
                              statusColor = Colors.red; // Red
                              canCancel = false;
                              break;
                            case 'scheduled':
                              statusColor = Colors.blue; // Blue
                              break;
                            default:
                              statusColor = Colors.blue; // Default Blue
                              break;
                          }

                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 3,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: pickup.status.toLowerCase() == 'scheduled'
                                        ? statusColor.withOpacity(0.3)
                                        : Colors.grey[200],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDate(pickup.date),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: pickup.status.toLowerCase() == 'scheduled'
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: statusColor,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          pickup.status.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time, size: 18),
                                          const SizedBox(width: 8),
                                          Text(pickup.time), // Default to 'N/A' if time is empty
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(Icons.recycling, size: 18),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Wrap(
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: pickup.wasteTypes.map(
                                                (m) => Chip(
                                                  label: Text(m, style: const TextStyle(color: Colors.black)),
                                                  backgroundColor: statusColor.withOpacity(0.1),
                                                ),
                                              ).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(Icons.scale, size: 18),
                                          const SizedBox(width: 8),
                                          Text(pickup.weight), // Default to 'N/A' if weight is empty
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      if (canCancel)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                foregroundColor: const Color(0xFFFF181C),
                                                side: const BorderSide(color: Color(0xFFFF181C)),
                                                backgroundColor: Colors.white,
                                              ),
                                              onPressed: () async {
                                                bool success = await _historyController
                                                    .cancelPickup(pickup.pickupId);

                                                if (success) {
                                                  setState(() {
                                                    // Remove the canceled pickup from the list
                                                    pickups.removeAt(index);
                                                  });

                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text("Pickup canceled successfully!"),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text("Failed to cancel pickup."),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                }
                                              },
                                              child: const Text('Cancel Pickup'),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String day = parsedDate.day.toString().padLeft(2, '0');
    String month = parsedDate.month.toString().padLeft(2, '0');
    return "$day/$month/${parsedDate.year}";
  }
}
