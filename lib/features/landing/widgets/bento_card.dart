import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/core/theme/app_theme.dart';
import 'package:koutix_app/features/landing/widgets/scroll_animated_fade_in_up.dart';

class BentoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isWide;
  final Color color;

  const BentoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.isWide = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 20 : 32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(isMobile ? 20 : 32),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Visual Part
              Container(
                width: isMobile ? 50 : 60,
                height: isMobile ? 50 : 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: isMobile ? 20 : 24,
                  color: AppTheme.primaryColor,
                ),
              ),
              SizedBox(height: isMobile ? 20 : 40),
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                from: 20,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: isMobile ? 8 : 12),
              Flexible(
                child: ScrollAnimatedFadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  from: 20,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 15,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
