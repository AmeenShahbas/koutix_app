import 'package:flutter/material.dart';
import 'package:koutix_app/core/theme/app_theme.dart';
import 'package:koutix_app/features/admin/dashboard/dashboard_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: const [
            LandingNavBar(),
            LandingHeroSection(),
            TrustedBySection(),
            WhyChooseSection(),
            FeaturesSection(),
            HowItWorksSection(),
            BenefitsSection(),
            FinalCTASection(),
            LandingFooter(),
          ],
        ),
      ),
    );
  }
}

class LandingNavBar extends StatelessWidget {
  const LandingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LOgo
          Row(
            children: [
              // Placeholder for Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.storefront,
                  color: AppTheme.secondaryColor,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Koutix',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          // Nav Links (Desktop)
          if (MediaQuery.of(context).size.width > 800)
            Row(
              children: [
                _NavLink(title: 'Features'),
                _NavLink(title: 'Solutions'),
                _NavLink(title: 'Pricing'),
                _NavLink(title: 'Contact'),
              ],
            ),
          // CTAs
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminDashboardScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminDashboardScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Get Started Free'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String title;
  const _NavLink({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }
}

class LandingHeroSection extends StatelessWidget {
  const LandingHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white, // Keeping it clean/white as per earlier request
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.secondaryColor.withOpacity(0.3),
              ),
            ),
            child: const Text(
              'Run your supermarket smarter with Koutix',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Supermarket Billing & \nInventory Management Software',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 56,
              height: 1.1,
              fontWeight: FontWeight.w900,
              color: AppTheme.primaryColor,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 24),
          const SizedBox(
            width: 700,
            child: Text(
              'Process bills quickly, track inventory in real-time, and manage your staff efficiently. Built for supermarkets, grocery stores, and retail chains looking for speed, accuracy, and control.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 4,
                  shadowColor: AppTheme.primaryColor.withOpacity(0.4),
                ),
                child: const Text('Create Free Account'),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.primaryColor,
                  side: const BorderSide(
                    color: AppTheme.primaryColor,
                    width: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Request Demo'),
              ),
            ],
          ),
          const SizedBox(height: 60),
          // Dashboard Mockup Placeholder
          Container(
            width: 1000,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.dashboard_rounded,
                  size: 80,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  'High-Fidelity Dashboard Mockup Image Goes Here',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrustedBySection extends StatelessWidget {
  const TrustedBySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'TRUSTED BY MODERN SUPERMARKETS ACROSS INDIA AND THE MIDDLE EAST',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _TrustLogo(text: 'HyperOne'),
              _TrustLogo(text: 'FreshMart'),
              _TrustLogo(text: 'DailyNeeds'),
              _TrustLogo(text: 'Urban Grocer'),
              _TrustLogo(text: 'Grand City'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrustLogo extends StatelessWidget {
  final String text;
  const _TrustLogo({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.grey[300],
      ),
    );
  }
}

class WhyChooseSection extends StatelessWidget {
  const WhyChooseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      color: Colors.grey[50],
      child: Column(
        children: [
          const Text(
            'Simplify Daily Operations',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryColor,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Why Supermarkets Choose Koutix',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          const SizedBox(
            width: 700,
            child: Text(
              'Managing a supermarket should not require multiple systems, manual registers, or guesswork. Koutix brings everything into one web application.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              _FeatureCard(
                icon: Icons.timer_outlined,
                title: 'Reduce Billing Delays',
                description:
                    'Faster checkout queues with our optimized POS integration.',
              ),
              _FeatureCard(
                icon: Icons.inventory_2_outlined,
                title: 'Accurate Inventory',
                description:
                    'Prevent over-ordering and wastage with real-time tracking.',
              ),
              _FeatureCard(
                icon: Icons.trending_up,
                title: 'Real-time Profit Tracking',
                description:
                    'View daily sales and margins instantly from anywhere.',
              ),
              _FeatureCard(
                icon: Icons.security,
                title: 'Secure Access',
                description:
                    'Manage staff roles and counter access with full logs.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'Complete Supermarket Management',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 60),
          _LargeFeatureRow(
            reversed: false,
            imageColor: Colors.blue[50]!,
            title: 'Fast & Reliable Billing',
            subtitle:
                'Process customer bills quickly with a stable, secure billing system designed for high-volume supermarket counters.',
            icon: Icons.receipt,
          ),
          const SizedBox(height: 80),
          _LargeFeatureRow(
            reversed: true,
            imageColor: Colors.green[50]!,
            title: 'Inventory & Stock Control',
            subtitle:
                'Track stock movement in real time, monitor low-stock items, and prevent over-ordering or wastage.',
            icon: Icons.inventory,
          ),
          const SizedBox(height: 80),
          _LargeFeatureRow(
            reversed: false,
            imageColor: Colors.orange[50]!,
            title: 'Business Insights',
            subtitle:
                'View daily, weekly, and monthly sales reports to understand performance and make better business decisions.',
            icon: Icons.bar_chart,
          ),
        ],
      ),
    );
  }
}

class _LargeFeatureRow extends StatelessWidget {
  final bool reversed;
  final Color imageColor;
  final String title;
  final String subtitle;
  final IconData icon;

  const _LargeFeatureRow({
    required this.reversed,
    required this.imageColor,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textContent = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
              height: 1.6,
            ),
          ),
        ],
      ),
    );

    final imageContent = Expanded(
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: imageColor,
          borderRadius: BorderRadius.circular(24),
        ),
        // Placeholder for feature image
        child: Center(
          child: Icon(Icons.image, size: 64, color: Colors.black12),
        ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return Column(
            children: [imageContent, const SizedBox(height: 40), textContent],
          );
        }
        return Row(
          children: reversed
              ? [textContent, const SizedBox(width: 60), imageContent]
              : [imageContent, const SizedBox(width: 60), textContent],
        );
      },
    );
  }
}

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF9FAFB),
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'Get Started in 3 Simple Steps',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No complex setup. No technical knowledge required.',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _StepCard(
                step: '01',
                title: 'Create Account',
                desc: 'Create your supermarket account online in seconds.',
              ),
              _StepCard(
                step: '02',
                title: 'Add Data',
                desc: 'Add products, staff, and billing counters easily.',
              ),
              _StepCard(
                step: '03',
                title: 'Start Billing',
                desc: 'Start billing, tracking inventory, and viewing reports.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String step;
  final String title;
  final String desc;
  const _StepCard({
    required this.step,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Text(
            step,
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200],
              height: 1,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitsSection extends StatelessWidget {
  const BenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Column(
        children: [
          const Text(
            'Designed for Local Supermarkets. Scalable Globally.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const SizedBox(
            width: 800,
            child: Text(
              'Koutix is built with real supermarket workflows in mind and works seamlessly across India, UAE, and GCC countries.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              _BenefitTag('Fast Billing'),
              _BenefitTag('Accurate Stocks'),
              _BenefitTag('Clear Revenue Visiblity'),
              _BenefitTag('Secure Cloud Access'),
              _BenefitTag('Multi-Branch Support'),
            ],
          ),
        ],
      ),
    );
  }
}

class _BenefitTag extends StatelessWidget {
  final String text;
  const _BenefitTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class FinalCTASection extends StatelessWidget {
  const FinalCTASection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Start Managing Your Supermarket Smarter Today',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Join supermarket owners who are switching to a faster, more reliable way to manage billing, inventory, and sales.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              elevation: 8,
            ),
            child: const Text('Create Free Supermarket Account'),
          ),
          const SizedBox(height: 16),
          const Text(
            'No setup fees. No long-term contracts.',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60),
      color: Colors.grey[900],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.storefront, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              const Text(
                'Koutix',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Smart Supermarket Software for Growing Retail Businesses.',
            style: TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 48),
          const Divider(color: Colors.white12),
          const SizedBox(height: 24),
          const Text(
            '© 2026 Koutix. All rights reserved.',
            style: TextStyle(color: Colors.white24, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
