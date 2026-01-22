import 'package:flutter/material.dart';
import 'dart:ui';
// import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/animated_hero_button.dart';
import 'package:koutix_app/features/landing/widgets/scroll_animated_fade_in_up.dart';

class FinalCTASection extends StatelessWidget {
  const FinalCTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 120,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        children: [
          ScrollAnimatedFadeInUp(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            from: 20,
            child: const Text(
              'Start Managing Your Supermarket\nSmarter Today',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                height: 1.1,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1.0,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ScrollAnimatedFadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            from: 20,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Text(
                      'Koutix is a modern supermarket billing software, inventory management system, and grocery store management solution designed to help retailers improve efficiency, accuracy, and profitability.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          ScrollAnimatedFadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            from: 20,
            child: const AnimatedHeroButton(
              title: 'Create Free Supermarket Account',
            ),
          ),
          const SizedBox(height: 24),
          ScrollAnimatedFadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            from: 20,
            child: const Text(
              'No setup fees.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
