import 'package:flutter/material.dart';
import 'package:waste_friendly/controllers/reward_controller.dart';
import 'package:waste_friendly/models/reward_model.dart';
import 'package:waste_friendly/screen/home_screen_page.dart';
import 'package:waste_friendly/screen/redeem_history.dart'; // Import for RedeemHistory screen

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final RewardController _rewardController = RewardController();
  late Future<List<RewardModel>> _rewards;

  @override
  void initState() {
    super.initState();
    _rewards = _rewardController.fetchReward(); // Fetch rewards on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center everything in the column
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/chart.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      '1,234',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Available Points',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Navigate back to HomeScreenPage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreenPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Available Rewards',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFE78402)),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<RewardModel>>(
              future: _rewards,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No rewards available.'));
                } else {
                  List<RewardModel> rewards = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: rewards.length,
                    itemBuilder: (context, index) {
                      return RewardCard(reward: rewards[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final RewardModel reward;

  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF26606).withOpacity(0.48),
              radius: 35,
              child: Icon(
                reward.icon,
                color: Colors.black,
                size: 40,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              reward.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25, // Increased title font size
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              reward.description,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE78402),
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              reward.exchangePoint,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            Center( // Added Center widget to center the button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF26606),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Navigate to the RedeemHistory screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RedeemHistory()), // Navigate to RedeemHistory screen
                  );
                },
                child: const Text(
                  'Redeem',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
