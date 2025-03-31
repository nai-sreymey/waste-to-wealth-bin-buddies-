import 'package:flutter/material.dart';

class RewardModel {
  final String title;
  final IconData icon;
  final String description;
  final String exchangePoint;
  final bool viewIsSelected;
  final Color boxColor;

  RewardModel({
    required this.title,
    required this.icon,
    required this.description,
    required this.exchangePoint,
    this.viewIsSelected = false, // Default value
    this.boxColor = Colors.white, // Default color
  });

  // Static method to get the correct icon based on title
  static IconData getIconForTitle(String title) {
    switch (title) {
      case 'Cash Voucher':
        return Icons.attach_money;
      case 'Shopping Discount':
        return Icons.shopping_bag;
      case 'Free Pickup':
        return Icons.local_shipping;
      case 'Eco-friendly Products':
        return Icons.eco;
      default:
        return Icons.card_giftcard; // Default icon
    }
  }

  // Factory constructor to create an object from JSON
  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      title: json['title'] ?? '',
      icon: getIconForTitle(json['title'] ?? ''), // Static icon mapping
      description: json['description'] ?? '',
      exchangePoint: '${json['exchangePoint'] ?? 0} points',
    );
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'exchangePoint': exchangePoint.replaceAll(' points', ''),
    };
  }
  }