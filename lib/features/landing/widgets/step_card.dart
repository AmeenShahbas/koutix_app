import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/features/landing/widgets/scroll_animated_fade_in_up.dart';

class StepCard extends StatelessWidget {
  final String step;
  final String title;
  final String desc;
  final bool isDesktop;

  const StepCard({
    super.key,
    required this.step,
    required this.title,
    required this.desc,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isDesktop ? 350 : 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Simple white number - no container
          ScrollAnimatedFadeInUp(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            from: 20,
            child: Text(
              step,
              style: GoogleFonts.poppins(
                fontSize: 80,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1,
                letterSpacing: -2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ScrollAnimatedFadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            from: 20,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ScrollAnimatedFadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            from: 20,
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
