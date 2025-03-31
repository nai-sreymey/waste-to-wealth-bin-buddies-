import 'package:flutter/material.dart';
import 'package:waste_friendly/models/redeemHistory_model.dart';
import 'package:waste_friendly/screen/home_screen_page.dart'; // Import home screen

class RedeemHistory extends StatefulWidget {
  const RedeemHistory({super.key});

  @override
  _RedeemHistoryState createState() => _RedeemHistoryState();
}

class _RedeemHistoryState extends State<RedeemHistory> {
  List<RedeemhistoryModel> redeemHistory = [];

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
  }

  void _getInitialInfo() {
    setState(() {
      redeemHistory = RedeemhistoryModel.getRedeemHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0), // Light orange background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF57C00), // Orange AppBar
        title: const Text(
          'Redeem History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text color
          ),
        ),
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back button
          onPressed: () {
            // Navigate to the home page when back is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreenPage()), // Replace with your HomePage widget
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: redeemHistory.isEmpty
            ? const Center(
                child: Text(
                  'No redeem history available',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              )
            : ListView.separated(
                itemCount: redeemHistory.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final reward = redeemHistory[index];

                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFFF57C00).withOpacity(0.2), // Light orange background
                            radius: 30,
                            child: Icon(
                              reward.icon,
                              size: 30,
                              color: const Color(0xFFF57C00), // Orange icon color
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reward.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Promo Code: ${reward.promoteCode}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFF57C00), // Orange text color
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF57C00),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Redeemed',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
