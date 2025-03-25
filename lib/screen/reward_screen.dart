import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RewardsScreen(),
    );
  }
}

class RewardsScreen extends StatelessWidget {
  final List<RewardItem> rewards = [
    RewardItem(
      title: 'Cash Voucher',
      subtitle: '\$10',
      points: '500 points',
      icon: Icons.attach_money,
    ),
    RewardItem(
      title: 'Shopping Discount',
      subtitle: '20% OFF',
      points: '1000 points',
      icon: Icons.shopping_bag,
    ),
    RewardItem(
      title: 'Free Pickup',
      subtitle: '1 Service',
      points: '250 points',
      icon: Icons.local_shipping,
    ),
    RewardItem(
      title: 'Eco-friendly Products',
      subtitle: 'Gift Box',
      points: '750 points',
      icon: Icons.card_giftcard,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  onPressed: () {},
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
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7, // ✅ Make the box tall
              ),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                return RewardCard(
                  reward: rewards[index],
                  isGray: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RewardItem {
  final String title;
  final String subtitle;
  final String points;
  final IconData icon;

  RewardItem({
    required this.title,
    required this.subtitle,
    required this.points,
    required this.icon,
  });
}

class RewardCard extends StatelessWidget {
  final RewardItem reward;
  final bool isGray;

  const RewardCard({super.key, required this.reward, this.isGray = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isGray ? Colors.grey[300] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Bigger Circle
            CircleAvatar(
              backgroundColor: const Color(0xFFF26606).withOpacity(0.48),
              radius: 35, // ✅ Bigger circle
              child: Icon(
                reward.icon,
                color: Colors.black,
                size: 40, // ✅ Bigger icon
              ),
            ),
            const SizedBox(height: 10),
            Text(
              reward.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              reward.subtitle,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE78402),
                letterSpacing: 1.5,
              ),
            ),
            Text(
              reward.points,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF26606),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: const Text(
                'Redeem',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
