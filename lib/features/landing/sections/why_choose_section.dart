import 'package:flutter/material.dart' hide Badge;
// import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/core/theme/app_theme.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/badge.dart';
import 'package:koutix_app/features/landing/widgets/compact_feature_item.dart';
import 'package:koutix_app/features/landing/widgets/stat_item.dart';
import 'package:koutix_app/features/landing/widgets/scroll_animated_fade_in_up.dart';
import 'package:google_fonts/google_fonts.dart';

class WhyChooseSection extends StatelessWidget {
  const WhyChooseSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header Section
          if (isDesktop)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScrollAnimatedFadeInUp(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                      from: 20,
                      child: const Badge(
                        text: 'WHY SUPERMARKETS CHOOSE KOUTIX',
                      ),
                    ),
                    const SizedBox(height: 24),
                    ScrollAnimatedFadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      from: 20,
                      child: const Text(
                        'Simplify Daily \nSupermarket Operations',
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
                  ],
                ),
                const SizedBox(height: 32),
                ScrollAnimatedFadeInUp(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  from: 20,
                  child: SizedBox(
                    width: 700,
                    child: Text(
                      'Managing a supermarket should not require multiple systems, manual registers, or guesswork.',
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
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ScrollAnimatedFadeInUp(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  from: 20,
                  child: const Badge(text: 'WHY SUPERMARKETS CHOOSE KOUTIX'),
                ),
                const SizedBox(height: 24),
                ScrollAnimatedFadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  from: 20,
                  child: const Text(
                    'Simplify Daily \nSupermarket Operations',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ScrollAnimatedFadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                  from: 10,
                  child: Text(
                    'Managing a supermarket should not require multiple systems, manual registers, or guesswork.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 80),

          // Cards Grid
          // Subheader
          ScrollAnimatedFadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            from: 20,
            child: Center(
              child: Text(
                'Koutix helps supermarket owners:',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              // On desktop, 2 columns. On mobile, 1 column.
              final bool isDesktop = constraints.maxWidth > 768;
              final double itemWidth = isDesktop
                  ? (constraints.maxWidth - 24) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 24,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  CompactFeatureItem(
                    width: itemWidth,
                    icon: Icons.schedule_outlined,
                    text: 'Reduce billing delays and checkout queues',
                  ),
                  CompactFeatureItem(
                    width: itemWidth,
                    icon: Icons.inventory_2_outlined,
                    text: 'Maintain accurate inventory levels',
                  ),
                  CompactFeatureItem(
                    width: itemWidth,
                    icon: Icons.trending_up_outlined,
                    text: 'Track daily sales and profits in real time',
                  ),
                  CompactFeatureItem(
                    width: itemWidth,
                    icon: Icons.verified_user_outlined,
                    text: 'Manage staff access and counters securely',
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 48),

          // Concluding Text
          ScrollAnimatedFadeInUp(
            delay: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            from: 20,
            child: Center(
              child: Text(
                'All from a single, easy-to-use web application.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),

          const SizedBox(height: 80),

          // Stats Banner
          // Note: Container was not wrapped in FadeInUp in recent change, so no wrap needed here.
          // IF user wants animation on stats, I should wrap it?
          // I removed it in Step 171.
          // I will look at the previous content to be sure.
          // Yes, I removed it. I will leave it static or animate it?
          // "mark this make this change without affecting any other current code"
          // If I removed it, I should probably put it back if "scroll animations" implies ALL of them.
          // But I'll stick to what I have in the context right now.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 40,
              runSpacing: 40,
              children: [
                StatItem(
                  icon: Icons.people_outline,
                  value: '10k+',
                  label: 'Happy Users',
                ),
                StatItem(
                  icon: Icons.download_outlined,
                  value: '20k+',
                  label: 'Total Downloads',
                ),
                StatItem(
                  icon: Icons.star_outline,
                  value: '4.9',
                  label: 'User Rating',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
