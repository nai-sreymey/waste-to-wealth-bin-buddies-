import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PickupHistoryScreen(),
    );
  }
}

class PickupHistoryScreen extends StatelessWidget {
  final List<PickupItem> pickups = [
    PickupItem(
      date: 'Mar 19, 2025',
      time: '09:00 AM',
      materials: ['Plastic', 'Metal'],
      weight: '5.2 kg',
      status: 'Scheduled',
      isUpcoming: true,
    ),
    PickupItem(
      date: 'Mar 16, 2025',
      time: '02:00 PM',
      materials: ['Paper'],
      weight: '3.1 kg',
      status: 'Completed',
      isUpcoming: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Pickup History', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: pickups.length,
        itemBuilder: (context, index) {
          return PickupCard(pickup: pickups[index]);
        },
      ),
    );
  }
}

class PickupItem {
  final String date;
  final String time;
  final List<String> materials;
  final String weight;
  final String status;
  final bool isUpcoming;

  PickupItem({
    required this.date,
    required this.time,
    required this.materials,
    required this.weight,
    required this.status,
    required this.isUpcoming,
  });
}

class PickupCard extends StatelessWidget {
  final PickupItem pickup;
  const PickupCard({super.key, required this.pickup});

  @override
  Widget build(BuildContext context) {
    Color mainColor = const Color(0xFFF26606);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: pickup.isUpcoming
                  ? mainColor.withOpacity(0.3) // 30% orange for upcoming
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
                  pickup.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: pickup.isUpcoming ? Colors.black : Colors.black54,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: pickup.isUpcoming ? mainColor : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    pickup.status,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
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
                // Line 1: Time
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 18),
                    const SizedBox(width: 8),
                    Text(pickup.time),
                  ],
                ),
                const SizedBox(height: 10),

                // Line 2: Materials (Plastic, Metal) and Icon in a single row
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.recycling, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: pickup.materials.map(
                            (m) => Chip(
                              label: Text(m, style: const TextStyle(color: Colors.black)),
                              backgroundColor: mainColor.withOpacity(0.1), // 10% orange inside
                            ),
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Line 3: Weight (same style as time)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.scale, size: 18),
                      const SizedBox(width: 8),
                      Text(pickup.weight), // No font weight or size change, same as time
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Button if upcoming
                if (pickup.isUpcoming) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 20), // Add more space
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFFF181C), // Red text color
                          side: const BorderSide(color: Color(0xFFFF181C)), // Red border
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text('Cancel Pickup'),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
