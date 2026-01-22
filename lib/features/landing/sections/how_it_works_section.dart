import 'package:flutter/material.dart' hide Badge;
// import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/badge.dart';
import 'package:koutix_app/features/landing/widgets/step_card.dart';
import 'package:koutix_app/features/landing/widgets/scroll_animated_fade_in_up.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align to left like Hero
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Align to left like Hero
            children: [
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                from: 20,
                child: const Badge(text: 'HOW IT WORKS'),
              ),
              const SizedBox(height: 24),
              ScrollAnimatedFadeInUp(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                from: 20,
                child: const Text(
                  'Get Started in\n3 Simple Steps', // Multi-line for impact
                  style: TextStyle(
                    fontSize: 48, // Increased size like Hero
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1.0,
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
                  // Constrain width for readability
                  width: 600,
                  child: Text(
                    'No complex setup. No technical knowledge required. Just sign up and start managing your store.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80), // Increased spacing

          LayoutBuilder(
            builder: (context, constraints) {
              if (isDesktop) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StepCard(
                      step: '01',
                      title: 'Create Account',
                      desc:
                          'Create your supermarket account online in seconds.',
                      isDesktop: true,
                    ),
                    StepCard(
                      step: '02',
                      title: 'Add Data',
                      desc: 'Add products, staff, and billing counters easily.',
                      isDesktop: true,
                    ),
                    StepCard(
                      step: '03',
                      title: 'Start Billing',
                      desc:
                          'Start billing, tracking inventory, and viewing reports.',
                      isDesktop: true,
                    ),
                  ],
                );
              }

              return Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: [
                  StepCard(
                    step: '01',
                    title: 'Create Account',
                    desc: 'Create your supermarket account online in seconds.',
                  ),
                  StepCard(
                    step: '02',
                    title: 'Add Data',
                    desc: 'Add products, staff, and billing counters easily.',
                  ),
                  StepCard(
                    step: '03',
                    title: 'Start Billing',
                    desc:
                        'Start billing, tracking inventory, and viewing reports.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
