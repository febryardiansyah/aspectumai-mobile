import 'package:flutter/material.dart';

class AppElevatedButtonWidget extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool isExpanded;

  const AppElevatedButtonWidget({
    super.key,
    this.label,
    this.icon,
    this.backgroundColor,
    this.onTap,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = label != null
        ? Text(
            label!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        : Icon(
            icon,
            color: Colors.white,
            size: 24,
          );

    final button = ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        minimumSize: Size(isExpanded ? double.infinity : 50, 50),
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
      child: buttonChild,
    );

    return isExpanded ? SizedBox(height: 50, child: button) : SizedBox(width: 50, height: 50, child: button);
  }
}