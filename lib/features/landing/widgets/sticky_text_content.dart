import 'package:flutter/material.dart' hide Badge;
import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/features/landing/widgets/badge.dart';
import 'package:koutix_app/features/landing/widgets/scroll_animated_fade_in_up.dart';

class StickyTextContent extends StatelessWidget {
  const StickyTextContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Badge
        ScrollAnimatedFadeInUp(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          from: 20,
          child: const Badge(text: 'FEATURES'),
        ),
        const SizedBox(height: 32),
        ScrollAnimatedFadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          from: 20,
          child: Text(
            'Complete Supermarket\nManagement System',
            style: GoogleFonts.poppins(
              fontSize: 48, // Slightly adjusted for longer text
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
