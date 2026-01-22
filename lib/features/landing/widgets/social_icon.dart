import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  const SocialIcon(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: Colors.grey[400], size: 24);
  }
}
