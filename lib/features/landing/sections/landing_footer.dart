import 'package:flutter/material.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/footer_brand_column.dart';
import 'package:koutix_app/features/landing/widgets/footer_link_column.dart';

class LandingFooter extends StatelessWidget {
  final VoidCallback onWhyUsTap;
  final VoidCallback onFeaturesTap;
  final VoidCallback onBenefitsTap;
  final VoidCallback onHomeTap;

  const LandingFooter({
    super.key,
    required this.onWhyUsTap,
    required this.onFeaturesTap,
    required this.onBenefitsTap,
    required this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;
    double horizontalPadding = getResponsiveHorizontalPadding(context);

    return Container(
      width: double.infinity,
      // decoration: const BoxDecoration(color: Color(0xFF0A0A0A)),
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        100,
        horizontalPadding,
        60,
      ),
      child: Column(
        children: [
          // --- Unified CTA Section ---
          // FadeInUp(
          //   duration: const Duration(milliseconds: 600),
          //   child: Column(
          //     children: [
          //       // Text(
          //       //   'Start Managing Your Supermarket\nSmarter Today',
          //       //   textAlign: TextAlign.center,
          //       //   style: GoogleFonts.poppins(
          //       //     fontSize: isDesktop ? 48 : 32,
          //       //     height: 1.1,
          //       //     fontWeight: FontWeight.w600,
          //       //     color: Colors.white,
          //       //     letterSpacing: -1.0,
          //       //   ),
          //       // ),
          //       // const SizedBox(height: 24),
          //       SizedBox(
          //         width: 600,
          //         child: Text(
          //           'Koutix is a modern supermarket billing software, inventory management system, and grocery store management solution designed to help retailers improve efficiency, accuracy, and profitability.',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             fontSize: 20,
          //             color: Colors.grey[400],
          //             height: 1.5,
          //           ),
          //         ),
          //       ),
          //       // const SizedBox(height: 48),
          //       // Wrap(
          //       //   spacing: 20,
          //       //   runSpacing: 16,
          //       //   alignment: WrapAlignment.center,
          //       //   children: [
          //       //     _StoreButton(
          //       //       icon: Icons.android,
          //       //       label: 'GET IT ON',
          //       //       storeName: 'Google Play',
          //       //     ),
          //       //     _StoreButton(
          //       //       icon: Icons.phone_iphone,
          //       //       label: 'Download on the',
          //       //       storeName: 'App Store',
          //       //     ),
          //       //   ],
          //       // ),
          //       // const SizedBox(height: 24),
          //       // // Removed "No setup fees..." text to match image cleanliness if desired,
          //       // // but adding it back to match previous unified version consistency.
          //       // Text(
          //       //   'No setup fees. No long-term contracts.',
          //       //   style: TextStyle(color: Colors.grey[600], fontSize: 14),
          //       // ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 120),

          // --- Footer Links Section ---
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: const FooterBrandColumn()),
                    const SizedBox(width: 40),
                    Expanded(
                      child: FooterLinkColumn(
                        title: 'Quick Link',
                        links: const ['Home', 'Why Us', 'Features', 'Benefits'],
                        onTaps: [
                          onHomeTap,
                          onWhyUsTap,
                          onFeaturesTap,
                          onBenefitsTap,
                        ],
                      ),
                    ),
                    const Expanded(
                      child: FooterLinkColumn(
                        title: 'Support',
                        links: ['Contact Us', 'FAQs', 'Help Center'],
                      ),
                    ),
                    const Expanded(
                      child: FooterLinkColumn(
                        title: 'Resources',
                        links: [
                          'Blog',
                          'Privacy Policy',
                          // 'Changelog',
                          // 'Download',
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FooterBrandColumn(),
                    const SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FooterLinkColumn(
                          title: 'Quick Link',
                          links: const [
                            'Home',
                            'Why Us',
                            'Features',
                            'Benefits',
                          ],
                          onTaps: [
                            onHomeTap,
                            onWhyUsTap,
                            onFeaturesTap,
                            onBenefitsTap,
                          ],
                        ),
                        const SizedBox(height: 40),
                        const FooterLinkColumn(
                          title: 'Support',
                          links: ['Contact Us', 'FAQs', 'Help Center'],
                        ),
                        const SizedBox(height: 40),
                        const FooterLinkColumn(
                          title: 'Resources',
                          links: [
                            'Blog',
                            'Privacy Policy',
                            // 'Changelog',
                            // 'Download',
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

          // --- Footer Copyright Section ---
          const SizedBox(height: 80),
          const Divider(color: Colors.white12),
          const SizedBox(height: 24),
          const Text(
            '© 2026 Koutix. All rights reserved.',
            style: TextStyle(color: Colors.white24, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
