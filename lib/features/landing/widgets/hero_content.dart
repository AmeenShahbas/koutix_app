import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/features/landing/widgets/animated_hero_button.dart';
import 'package:koutix_app/auth/login_screen.dart';

class HeroContent extends StatelessWidget {
  final bool centerAlign;
  const HeroContent({super.key, this.centerAlign = false});

  @override
  Widget build(BuildContext context) {
    final align = centerAlign
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        // Headline
        FadeInUp(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          from: 20,
          child: Text(
            'Supermarket Billing & Inventory Management Software',
            textAlign: textAlign,
            style: GoogleFonts.poppins(
              fontSize: 48,
              height: 1.1,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Subtext 1
        FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          from: 20,
          child: SizedBox(
            width: 600,
            child: Text(
              'Manage billing, stock, staff, and sales in one smart web platform. Built for supermarkets and grocery stores across India & GCC.',
              textAlign: textAlign,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.grey[400],
                height: 1.6,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        // Buttons
        FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          from: 20,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AnimatedHeroButton(
                title: 'Create Account',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size.fromHeight(56),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  side: const BorderSide(color: Colors.white24, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  elevation: 0,
                  overlayColor: Colors.black.withOpacity(0.05),
                ),
                child: Text(
                  'Book Free Demo',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
