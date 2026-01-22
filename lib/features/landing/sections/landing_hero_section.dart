import 'package:flutter/material.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/hero_content.dart';
import 'package:koutix_app/features/landing/widgets/hero_image_composition.dart';

class LandingHeroSection extends StatelessWidget {
  const LandingHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;
    double horizontalPadding = getResponsiveHorizontalPadding(context);

    return Container(
      width: double.infinity,
      child: isDesktop
          ? Padding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 80, 0, 80),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Content
                  Expanded(flex: 5, child: const HeroContent()),
                  const SizedBox(width: 60),
                  // Right Image Composition
                  Expanded(
                    flex: 6,
                    // Align center-left so it stays connected to content but can bleed right
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Transform.translate(
                        offset: const Offset(
                          0,
                          -40,
                        ), // Move image up slightly as requested
                        child: const HeroImageComposition(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical: 80,
                horizontal: horizontalPadding,
              ),
              child: Column(
                children: [
                  const HeroContent(centerAlign: true),
                  const SizedBox(height: 60),
                  const HeroImageComposition(),
                ],
              ),
            ),
    );
  }
}
