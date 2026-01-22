import 'package:flutter/material.dart';

class TrustLogo extends StatelessWidget {
  final IconData icon;
  final String text;

  const TrustLogo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey[300], size: 56), // Further increased size
        const SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            fontSize: 36, // Further increased font size
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
