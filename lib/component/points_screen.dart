import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_friendly/controllers/points_controller.dart';

class PointsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch points data when the screen is built
    Future.microtask(() {
      Provider.of<PointsController>(context, listen: false).fetchPointsData();
    });

    return Consumer<PointsController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.points == null) {
          return const Center(child: Text("No data available"));
        }

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
                Text(
                  '${controller.points.totalPoints} points',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$${controller.points.cashEquivalent}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // PieChartWidget(points: controller.points), // Pie chart widget
          ],
        );
      },
    );
  }
}
