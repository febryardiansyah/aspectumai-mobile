import 'package:flutter/material.dart';

class CarouselItem {
  final String title;
  final String category;
  final String description;
  final String imageUrl;

  CarouselItem({
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
  });
}

class ActionButtonItem {
  final IconData icon;
  final String? label;
  final Color? backgroundColor;
  final bool isExpanded;
  final VoidCallback? onTap;

  ActionButtonItem({
    required this.icon,
    this.label,
    this.backgroundColor,
    this.isExpanded = false,
    this.onTap,
  });
}
