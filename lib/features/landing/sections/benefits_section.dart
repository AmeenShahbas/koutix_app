import 'package:flutter/material.dart' hide Badge;
// import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/badge.dart';
import 'package:koutix_app/features/landing/widgets/bento_card.dart';
import 'package:koutix_app/features/landing/widgets/geo_bento_card.dart';
import 'package:koutix_app/features/landing/widgets/scroll_animated_fade_in_up.dart';

class BenefitsSection extends StatelessWidget {
  const BenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive Layout Logic
    bool isDesktop = MediaQuery.of(context).size.width > 1000;

    return Container(
      width: double.infinity,
      // color: Colors.black,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Benefits Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                from: 20,
                child: const Badge(text: 'BENEFITS'),
              ),
              const SizedBox(height: 24),
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                from: 20,
                child: Text(
                  'Built for Supermarket Owners\n& Grocery Stores',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -1.0,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),

          // 2. Bento Grid Layout
          if (isDesktop)
            Column(
              children: [
                // Top Row: 3 Cards
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: BentoCard(
                          icon: Icons.bolt_outlined,
                          title: 'Faster Billing',
                          description:
                              'Reduce customer waiting time with our lightning-fast checkout process.',
                          color: Color(0xFF111111), // Soft Blue tint
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: BentoCard(
                          icon: Icons.inventory_2_outlined,
                          title: 'Accurate Stocks',
                          description:
                              'Keep track of every item with real-time inventory updates and low-stock alerts.',
                          color: Color(0xFF111111), // Soft Green tint
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: BentoCard(
                          icon: Icons.bar_chart_outlined,
                          title: 'Clear Insights',
                          description:
                              'Visualize revenue, margins, and performance with easy-to-read reports.',
                          color: Color(0xFF111111), // Soft Red tint
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Bottom Row: 2 Wide Cards
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: BentoCard(
                          icon: Icons.cloud_outlined,
                          title: 'Secure Cloud Access',
                          description:
                              'Access your store data securely from anywhere, anytime, on any device.',
                          isWide: true,
                          color: Color(0xFF111111), // Soft Orange tint
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: BentoCard(
                          icon: Icons.storefront_outlined,
                          title: 'Multi-Branch Support',
                          description:
                              'Manage single stores or entire supermarket chains from one central dashboard.',
                          isWide: true,
                          color: Color(0xFF111111), // Soft Purple tint
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          else
            // Mobile Layout: Vertical Stack
            Column(
              children: [
                BentoCard(
                  icon: Icons.bolt_outlined,
                  title: 'Faster Billing',
                  description:
                      'Reduce customer waiting time with our lightning-fast checkout process.',
                  color: Color(0xFF111111),
                ),
                SizedBox(height: 24),
                BentoCard(
                  icon: Icons.inventory_2_outlined,
                  title: 'Accurate Stocks',
                  description:
                      'Keep track of every item with real-time inventory updates.',
                  color: Color(0xFF111111),
                ),
                SizedBox(height: 24),
                BentoCard(
                  icon: Icons.bar_chart_outlined,
                  title: 'Clear Insights',
                  description:
                      'Visualize revenue, margins, and performance with easy-to-read reports.',
                  color: Color(0xFF111111),
                ),
                SizedBox(height: 24),
                BentoCard(
                  icon: Icons.cloud_outlined,
                  title: 'Secure Cloud Access',
                  description:
                      'Access your store data securely from anywhere, anytime.',
                  color: Color(0xFF111111),
                ),
                SizedBox(height: 24),
                BentoCard(
                  icon: Icons.storefront_outlined,
                  title: 'Multi-Branch Support',
                  description:
                      'Manage single stores or entire supermarket chains from one dashboard.',
                  color: Color(0xFF111111),
                ),
              ],
            ),

          const SizedBox(height: 120),

          // 3. Geo Section Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                from: 20,
                child: const Badge(text: 'GLOBAL REACH'),
              ),
              const SizedBox(height: 24),
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                from: 20,
                child: Text(
                  'Designed for Local Supermarkets.\nScalable Globally.',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.5,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                from: 20,
                child: SizedBox(
                  width: 700,
                  child: Text(
                    'Koutix is built with real supermarket workflows in mind and works seamlessly across:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[400],
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),

          // 4. Geo Cards
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center, // Centered wrap
                children: [
                  // GeoBentoCard(country: 'India', icon: LucideIcons.flag),
                  GeoBentoCard(
                    country: 'UAE & GCC',
                    icon: Icons.language_outlined,
                  ),
                  GeoBentoCard(
                    country: 'Global Markets',
                    icon: Icons.public_outlined,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 60),
          // Footer Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(
                0xFF111111,
              ), // Slightly dark background for contrast
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.white12),
            ),
            child: Text(
              'Reliable performance, secure data handling, and simple operations — no matter where your store is located.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
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
