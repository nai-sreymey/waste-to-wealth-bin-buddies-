import 'package:flutter/material.dart';

class RedeemhistoryModel {
  String title;
  IconData icon; // Use IconData to store icons
  String promoteCode;
  Color boxColor;
  bool boxIsSelected;

  RedeemhistoryModel({
    required this.title,
    required this.icon,
    required this.promoteCode,
    required this.boxColor,
    required this.boxIsSelected,
  });

  // Static method to get a list of redeem history data
  static List<RedeemhistoryModel> getRedeemHistory() {
    List<RedeemhistoryModel> redeem_history = [];

    redeem_history.add(
      RedeemhistoryModel(
        title: 'Cash Voucher',
        icon: Icons.attach_money, // Use the correct IconData here
        promoteCode: 'E-12345',
        boxColor: Color(0xffC58BF2), // Correct way to define color
        boxIsSelected: false,
      ),
    );

    // You can add more items to the list as needed
    redeem_history.add(
      RedeemhistoryModel(
        title: 'Discount Voucher',
        icon: Icons.shopping_bag,
        promoteCode: 'E-67890',
        boxColor: Color(0xffFF6347), // Another example color
        boxIsSelected: true,
      ),
    );

    return redeem_history;
  }
}
