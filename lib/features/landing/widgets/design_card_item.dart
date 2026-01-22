import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
// import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/core/theme/app_theme.dart';
import 'package:koutix_app/features/landing/widgets/scroll_animated_fade_in_up.dart';

class DesignCardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const DesignCardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 20 : 24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 16 : 24,
            horizontal: isMobile ? 16 : 24,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(isMobile ? 20 : 24),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: isMobile ? 18 : 20,
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                from: 20,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                from: 20,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey[400],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
