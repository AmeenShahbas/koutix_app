import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:koutix_app/core/theme/app_theme.dart';
import 'package:koutix_app/features/admin/dashboard/dashboard_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

double getResponsiveHorizontalPadding(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width >= 1280) return 138.0;
  if (width >= 768) return 32.0;
  return 16.0;
}

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
    // Floating Navbar
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      from: 20,
      child: RepaintBoundary(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: getResponsiveHorizontalPadding(context),
            vertical: 32,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100), // Pill shape like buttons
            border: Border.all(color: Colors.grey[200]!, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo Only (No Text)
              SvgPicture.asset('assets/icons/logowithoutbg.svg', height: 36),

              // Desktop Links (Centered)
              if (MediaQuery.of(context).size.width > 900)
                Row(
                  children: [
                    _NavLink(title: 'Home', isActive: true),
                    _NavLink(title: 'Features'),
                    _NavLink(title: 'Why Us'),
                    _NavLink(title: 'Benefits'),
                    _NavLink(title: 'Testimonials'),
                  ],
                ),

              // Action Button
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
                  backgroundColor: AppTheme
                      .primaryColor, // Reverting to Primary color for contrast on white/grey bar
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      100,
                    ), // Circle/Pill shape for button
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Download App',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String title;
  final bool isActive;
  const _NavLink({required this.title, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.black : Colors.grey[600],
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
    bool isDesktop = MediaQuery.of(context).size.width > 900;
    double horizontalPadding = getResponsiveHorizontalPadding(context);

    return Container(
      width: double.infinity,
      // Subtle grid or gradient background could go here
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     colors: [
      //       Colors.white,
      //       const Color(0xFFF5F5FA), // Very light purple/grey tint
      //     ],
      //   ),
      // ),
      // Conditional Padding: Desktop gets 0 right padding for "Bleed" effect
      child: isDesktop
          ? Padding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 80, 0, 80),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Content
                  Expanded(flex: 5, child: _HeroContent()),
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
                        child: const _HeroImageComposition(),
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
                  _HeroContent(centerAlign: true),
                  const SizedBox(height: 60),
                  _HeroImageComposition(),
                ],
              ),
            ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final bool centerAlign;
  const _HeroContent({this.centerAlign = false});

  @override
  Widget build(BuildContext context) {
    final align = centerAlign
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.left;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      from: 20,
      child: Column(
        crossAxisAlignment: align,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: 18, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  '#1 Best Supermarket Software',
                  style: GoogleFonts.poppins(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Headline
          Text(
            'All-in-One Supermarket\nManagement App for\nProductive Teams',
            textAlign: textAlign,
            style: GoogleFonts.poppins(
              fontSize: 50, // Reduced from 64 for minimal look
              height: 1.1,
              fontWeight: FontWeight.bold, // Reduced form w900
              color: Colors.black,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 24),
          // Subtext
          SizedBox(
            width: 600,
            child: Text(
              'Improve collaboration, monitor progress in real-time, and complete billing on time — all in one intuitive, easy-to-use dashboard.',
              textAlign: textAlign,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor, // Primary Color
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      100,
                    ), // Circle/Pill shape
                  ),
                  elevation: 5,
                  shadowColor: AppTheme.primaryColor.withOpacity(0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Try it for Free'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: Colors.grey, width: 1),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      100,
                    ), // Circle/Pill shape
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Learn More'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroImageComposition extends StatelessWidget {
  const _HeroImageComposition();

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      child: RepaintBoundary(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Laptop / Web Dashboard Mockup (Back Layer)
            Transform.translate(
              offset: const Offset(40, 0),
              child: Container(
                height: 480,
                width: 720,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero, // Removed border radius
                  border: Border.all(color: Colors.grey[200]!, width: 4),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 50,
                  //     offset: const Offset(0, 20),
                  //   ),
                  // ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Column(
                    children: [
                      // Browser Bar
                      Container(
                        height: 30,
                        color: Colors.grey[100],
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.red[200],
                            ),
                            const SizedBox(width: 6),
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.orange[200],
                            ),
                            const SizedBox(width: 6),
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.green[200],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Web Admin Dashboard",
                            style: TextStyle(color: Colors.grey[300]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Mobile App Mockup (Front Layer)
            Transform.translate(
              offset: const Offset(-180, 80),
              child: Container(
                height: 480,
                width: 240,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.zero, // Removed border radius
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.2),
                  //     blurRadius: 40,
                  //     offset: const Offset(0, 20),
                  //   ),
                  // ],
                ),
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Center(
                    child: Text(
                      "Partner App",
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsiveHorizontalPadding(context),
            ),
            child: Text(
              'TRUSTED BY MODERN SUPERMARKETS ACROSS INDIA AND THE MIDDLE EAST',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsiveHorizontalPadding(context),
            ),
            child: const _InfiniteLogosList(),
          ),
        ],
      ),
    );
  }
}

class _TrustLogo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TrustLogo({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey[300], size: 56), // Further increased size
        const SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            fontSize: 36, // Further increased font size
            fontWeight: FontWeight.bold,
            color: Colors.grey[300],
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

class _InfiniteLogosList extends StatefulWidget {
  const _InfiniteLogosList();

  @override
  State<_InfiniteLogosList> createState() => _InfiniteLogosListState();
}

class _InfiniteLogosListState extends State<_InfiniteLogosList> {
  late ScrollController _scrollController;

  // Create a list of dummy logos with Icons to match the visual style
  final List<Widget> _logos = const [
    _TrustLogo(icon: Icons.ac_unit, text: 'FrozenMart'),
    _TrustLogo(icon: Icons.local_grocery_store, text: 'DailyFresh'),
    _TrustLogo(icon: Icons.eco, text: 'GreenGrocer'),
    _TrustLogo(icon: Icons.bakery_dining, text: 'CityBakery'),
    _TrustLogo(icon: Icons.storefront, text: 'SuperBazaar'),
    _TrustLogo(icon: Icons.shopping_basket, text: 'QuickPick'),
    _TrustLogo(icon: Icons.local_offer, text: 'ValueMart'),
    _TrustLogo(icon: Icons.inventory_2, text: 'StockPile'),
    _TrustLogo(icon: Icons.monetization_on, text: 'ProfitMax'),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    // Animate to a very far distance to simulate infinite scroll
    // 50,000 pixels at 20 pixels/sec = 2500 seconds (~40 mins of loop)
    // In a real app with infinite items, this is sufficient for a session.
    const double dist = 50000.0;
    const double speed = 100.0; // pixels per sec
    final double time = dist / speed;

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + dist,
        duration: Duration(seconds: time.toInt()),
        curve: Curves.linear,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Further increased height
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Colors.white,
              Colors.white,
              Colors.transparent,
            ],
            stops: [0.0, 0.05, 0.95, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _logos[index % _logos.length],
            );
          },
        ),
      ),
    );
  }
}

class WhyChooseSection extends StatelessWidget {
  const WhyChooseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
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
          Text(
            'Why Supermarkets Choose Koutix',
            style: GoogleFonts.poppins(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Changed from primary to black
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
        borderRadius: BorderRadius.circular(32), // High rounding
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
              borderRadius: BorderRadius.circular(100), // Circle like button
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
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        children: [
          Text(
            'Complete Supermarket Management',
            style: GoogleFonts.poppins(
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
              borderRadius: BorderRadius.circular(100), // Circle like button
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
          borderRadius: BorderRadius.zero, // Removed border radius
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
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        children: [
          Text(
            'Get Started in 3 Simple Steps',
            style: GoogleFonts.poppins(
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
            style: GoogleFonts.poppins(
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
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        children: [
          Text(
            'Designed for Local Supermarkets. Scalable Globally.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
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
        borderRadius: BorderRadius.circular(100), // Pill shape
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
      padding: EdgeInsets.symmetric(
        vertical: 120,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Start Managing Your Supermarket Smarter Today',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  100,
                ), // Circle/Pill shape for button
              ),
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
              Text(
                'Koutix',
                style: GoogleFonts.poppins(
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
