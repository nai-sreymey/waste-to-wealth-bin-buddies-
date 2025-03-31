import 'package:flutter/material.dart';
import 'package:waste_friendly/screen/home_screen_page.dart';

class HomeScreenSocial extends StatelessWidget {
  const HomeScreenSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Social'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // Add your action here if needed
            },
          ),
        ],
        // Add back button to the leading position
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigating back to the previous screen
  Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenPage()),
      );          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          _buildPost(
            profileImage: 'assets/images/ka.jpg',
            username: 'sorn monika',
            timeAgo: '2h ago',
            tag: 'Fundraising',
            title: 'Beach Cleanup Initiative',
            content: 'Join us this weekend for a beach cleanup! Let\'s make our oceans plastic-free.',
            imageUrl: 'assets/images/post1.jpg',
            likes: 124,
            comments: 45,
          ),
          _buildPost(
            profileImage: 'assets/images/ka.jpg',
            username: 'Mey Mey Cute Girl',
            timeAgo: '5h ago',
            tag: '',
            title: 'Tree Planting Day',
            content: 'We planted 100 trees today! Every small action counts towards a greener future.',
            imageUrl: 'assets/images/mey.png',
            likes: 98,
            comments: 30,
          ),
          _buildPost(
            profileImage: 'assets/images/ty.png',
            username: 'Nit Nit Beautiful',
            timeAgo: '5h ago',
            tag: '',
            title: 'Tree Planting Day',
            content: 'We planted 100 trees today! Every small action counts towards a greener future.',
            imageUrl: 'assets/images/pov.png',
            likes: 98,
            comments: 30,
          ),
          _buildPost(
            profileImage: 'assets/images/na.png',
            username: 'In In In',
            timeAgo: '5h ago',
            tag: '',
            title: 'Tree Planting Day',
            content: 'We planted 100 trees today! Every small action counts towards a greener future.',
            imageUrl: 'assets/images/all.png',
            likes: 98,
            comments: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildPost({
    required String profileImage,
    required String username,
    required String timeAgo,
    required String title,
    required String content,
    required String imageUrl,
    required int likes,
    required int comments,
    String? tag,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(profileImage),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(timeAgo, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                const Spacer(),
                if (tag != null && tag.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(tag, style: TextStyle(color: Colors.green.shade800)),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 5),
            Text(content),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_border),
                    const SizedBox(width: 5),
                    Text('$likes'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.comment),
                    const SizedBox(width: 5),
                    Text('$comments'),
                  ],
                ),
                const Icon(Icons.share),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
