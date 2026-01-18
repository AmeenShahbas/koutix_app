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
      body: Stack(
        children: [
          // Global Grid Background
          Positioned.fill(
            child: CustomPaint(painter: const GridPatternPainter()),
          ),
          // Scrollable Content
          ListView(
            cacheExtent: 1.0,
            addAutomaticKeepAlives: false,
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
        ],
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
            SvgPicture.asset('assets/icons/logowithoutbg.svg', height: 50),

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
            _AnimatedHeroButton(
              title: 'Download App',
              isSmall: true,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminDashboardScreen(),
                  ),
                );
              },
            ),
          ],
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
          // Headline
          Text(
            'Supermarket Billing & Inventory Management Software',
            textAlign: textAlign,
            style: GoogleFonts.poppins(
              fontSize: 48,
              height: 1.1,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 24),
          // Subtext 1
          SizedBox(
            width: 600,
            child: Text(
              'Manage billing, stock, staff, and sales in one smart web platform. Built for supermarkets and grocery stores across India & GCC.',
              textAlign: textAlign,
              style: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
          ),
          // const SizedBox(height: 16),
          // // Subtext 2
          // SizedBox(
          //   width: 600,
          //   child: Text(
          //     'Built for supermarkets, grocery stores, and retail chains looking for speed, accuracy, and control.',
          //     textAlign: textAlign,
          //     style: GoogleFonts.inter(
          //       fontSize: 16,
          //       color: Colors.black54,
          //       height: 1.6,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 48),
          // Buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const _AnimatedHeroButton(title: 'Create Account'),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size.fromHeight(56),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  overlayColor: Colors.black.withOpacity(0.05),
                ),
                child: Text(
                  'Book Free Demo',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          // SEO Microcopy
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   mainAxisAlignment: centerAlign
          //       ? MainAxisAlignment.center
          //       : MainAxisAlignment.start,
          //   children: [
          //     Icon(Icons.check_circle, size: 20, color: Colors.green[600]),
          //     const SizedBox(width: 12),
          //     Flexible(
          //       child: Text(
          //         'Trusted by modern supermarkets across India and the Middle East.',
          //         style: GoogleFonts.inter(
          //           fontSize: 14,
          //           color: Colors.grey[600],
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
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
      child: Image.asset('assets/images/heroimage.png', fit: BoxFit.contain),
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
                color: Colors.grey[600],
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
    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 5,
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Badge(text: 'WHY SUPERMARKETS CHOOSE KOUTIX'),
                        const SizedBox(height: 24),
                        const Text(
                          'Simplify Daily \nSupermarket Operations',
                          style: TextStyle(
                            fontSize: 48,
                            height: 1.1,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            letterSpacing: -1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 4,
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 600),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Managing a supermarket should not require multiple systems, manual registers, or guesswork.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Badge(text: 'WHY SUPERMARKETS CHOOSE KOUTIX'),
                  const SizedBox(height: 24),
                  const Text(
                    'Simplify Daily \nSupermarket Operations',
                    style: TextStyle(
                      fontSize: 40,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Managing a supermarket should not require multiple systems, manual registers, or guesswork.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 80),

          // Cards Grid
          // Subheader
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 600),
            child: Text(
              'Koutix helps supermarket owners:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
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
                children: [
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: _CompactFeatureItem(
                      width: itemWidth,
                      icon: Icons.timer_off_rounded,
                      text: 'Reduce billing delays and checkout queues',
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: _CompactFeatureItem(
                      width: itemWidth,
                      icon: Icons.inventory_2_rounded,
                      text: 'Maintain accurate inventory levels',
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: _CompactFeatureItem(
                      width: itemWidth,
                      icon: Icons.trending_up_rounded,
                      text: 'Track daily sales and profits in real time',
                    ),
                  ),
                  FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    child: _CompactFeatureItem(
                      width: itemWidth,
                      icon: Icons.admin_panel_settings_rounded,
                      text: 'Manage staff access and counters securely',
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 48),

          // Concluding Text
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            child: Center(
              child: Text(
                'All from a single, easy-to-use web application.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
          ),

          const SizedBox(height: 80),

          // Stats Banner
          FadeInUp(
            delay: const Duration(milliseconds: 900),
            duration: const Duration(milliseconds: 600),
            child: Container(
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
                children: const [
                  _StatItem(
                    icon: Icons.people_alt_rounded,
                    value: '10k+',
                    label: 'Happy Users',
                  ),
                  _StatItem(
                    icon: Icons.download_rounded,
                    value: '20k+',
                    label: 'Total Downloads',
                  ),
                  _StatItem(
                    icon: Icons.star_rounded,
                    value: '4.9',
                    label: 'User Rating',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactFeatureItem extends StatelessWidget {
  final double width;
  final IconData icon;
  final String text;

  const _CompactFeatureItem({
    required this.width,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black87, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
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
  final double? width;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 350,
      height: 280, // Fixed height for uniformity
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          // Minimal Container Glow - Enhanced
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.08), // Increased opacity
            blurRadius: 32, // Increased blur
            offset: const Offset(0, 12),
            spreadRadius: 2, // Slight spread
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Cover entire container
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
              boxShadow: [
                // Minimal Icon Glow - Enhanced
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(
                    0.2,
                  ), // Increased opacity
                  blurRadius: 16, // Increased blur
                  offset: const Offset(0, 4),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.secondaryColor.withOpacity(0.1)),
          ),
          child: Icon(icon, color: AppTheme.secondaryColor, size: 32),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondaryColor,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.secondaryColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          // Header
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: const StickyTextContent(),
          ),
          const SizedBox(height: 60),

          // New Horizontal Card Container
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 600),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 900;

                  if (!isDesktop) {
                    return Column(
                      children: [
                        _DesignCardItem(
                          icon: Icons.receipt_long_rounded,
                          title: 'Fast & Reliable Billing Software',
                          description:
                              'Process customer bills quickly with a stable, secure billing system designed for high-volume supermarket counters.',
                        ),
                        Divider(height: 60, color: Colors.grey.shade300),
                        _DesignCardItem(
                          icon: Icons.inventory_2_rounded,
                          title: 'Inventory & Stock Management',
                          description:
                              'Track stock movement in real time, monitor low-stock items, and prevent over-ordering or wastage.',
                        ),
                        Divider(height: 60, color: Colors.grey.shade300),
                        _DesignCardItem(
                          icon: Icons.people_alt_rounded,
                          title: 'Staff & Counter Management',
                          description:
                              'Assign staff roles, manage counters, and control access levels with full transparency.',
                        ),
                        Divider(height: 60, color: Colors.grey.shade300),
                        _DesignCardItem(
                          icon: Icons.insights_rounded,
                          title: 'Sales Reports & Business Insights',
                          description:
                              'View daily, weekly, and monthly sales reports to understand performance and make better business decisions.',
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _DesignCardItem(
                                icon: Icons.receipt_long_rounded,
                                title: 'Fast & Reliable Billing Software',
                                description:
                                    'Process customer bills quickly with a stable, secure billing system designed for high-volume supermarket counters.',
                              ),
                            ),
                            VerticalDivider(
                              width: 60,
                              color: Colors.grey.shade300,
                            ),
                            Expanded(
                              child: _DesignCardItem(
                                icon: Icons.inventory_2_rounded,
                                title: 'Inventory & Stock Management',
                                description:
                                    'Track stock movement in real time, monitor low-stock items, and prevent over-ordering or wastage.',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 60, color: Colors.grey.shade300),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _DesignCardItem(
                                icon: Icons.people_alt_rounded,
                                title: 'Staff & Counter Management',
                                description:
                                    'Assign staff roles, manage counters, and control access levels with full transparency.',
                              ),
                            ),
                            VerticalDivider(
                              width: 60,
                              color: Colors.grey.shade300,
                            ),
                            Expanded(
                              child: _DesignCardItem(
                                icon: Icons.insights_rounded,
                                title: 'Sales Reports & Business Insights',
                                description:
                                    'View daily, weekly, and monthly sales reports to understand performance and make better business decisions.',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StickyTextContent extends StatelessWidget {
  const StickyTextContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        const Badge(text: 'FEATURES'),
        const SizedBox(height: 32),
        Text(
          'Complete Supermarket\nManagement System',
          style: GoogleFonts.poppins(
            fontSize: 48, // Slightly adjusted for longer text
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1.1,
            letterSpacing: -1.5,
          ),
        ),
      ],
    );
  }
}

class StackingCardsList extends StatelessWidget {
  const StackingCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StackInfoCard(
          index: 0,
          color: Colors.blue[500]!,
          icon: Icons.receipt_long_rounded,
          title: 'Fast & Reliable Billing Software',
          description:
              'Process customer bills quickly with a stable, secure billing system designed for high-volume supermarket counters.',
          chartData: const [0.3, 0.5, 0.4, 0.7, 0.6, 0.8, 0.5],
        ),
        _StackInfoCard(
          index: 1,
          color: Colors.green[500]!, // Green for inventory
          icon: Icons.inventory_2_rounded,
          title: 'Inventory & Stock Management',
          description:
              'Track stock movement in real time, monitor low-stock items, and prevent over-ordering or wastage.',
          topOffset: -40, // Stacking effect
          chartData: const [0.5, 0.6, 0.8, 0.4, 0.7, 0.5, 0.6],
        ),
        _StackInfoCard(
          index: 2,
          color: Colors.orange[500]!, // Orange for staff
          icon: Icons.people_alt_rounded,
          title: 'Staff & Counter Management',
          description:
              'Assign staff roles, manage counters, and control access levels with full transparency.',
          topOffset: -40, // Stacking effect
          chartData: const [0.2, 0.4, 0.3, 0.5, 0.4, 0.6, 0.4],
        ),
        _StackInfoCard(
          index: 3,
          color: Colors.purple[500]!, // Purple for insights
          icon: Icons.insights_rounded,
          title: 'Sales Reports & Business Insights',
          description:
              'View daily, weekly, and monthly sales reports to understand performance and make better business decisions.',
          topOffset: -40, // Stacking effect
          chartData: const [0.4, 0.6, 0.5, 0.8, 0.9, 0.7, 0.9],
        ),
      ],
    );
  }
}

class _StackInfoCard extends StatelessWidget {
  final int index;
  final Color color;
  final IconData icon;
  final String title;
  final String description;
  final double topOffset;
  final List<double> chartData;

  const _StackInfoCard({
    required this.index,
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    this.topOffset = 0,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: 200 * index), // Staggered
      duration: const Duration(milliseconds: 800),
      from: 100, // Slide up from further down
      child: Transform.translate(
        offset: Offset(0, topOffset),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB), // Very light grey background
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              // Mini Chart visual
              SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: chartData.map((e) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          height: 60 * e,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesignCardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _DesignCardItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black, // Dark circle as per image
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5),
        ),
      ],
    );
  }
}

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      // color: const Color(0xFFF9FAFB), // Removed for global grid background
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to left like Hero
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align to left like Hero
              children: [
                const Badge(text: 'HOW IT WORKS'), // Added Badge
                const SizedBox(height: 24),
                const Text(
                  'Get Started in\n3 Simple Steps', // Multi-line for impact
                  style: TextStyle(
                    fontSize: 48, // Increased size like Hero
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 24),
                const SizedBox(
                  // Constrain width for readability
                  width: 600,
                  child: Text(
                    'No complex setup. No technical knowledge required. Just sign up and start managing your store.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80), // Increased spacing

          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 600),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (isDesktop) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _StepCard(
                        step: '01',
                        title: 'Create Account',
                        desc:
                            'Create your supermarket account online in seconds.',
                        isDesktop: true,
                      ),
                      _StepCard(
                        step: '02',
                        title: 'Add Data',
                        desc:
                            'Add products, staff, and billing counters easily.',
                        isDesktop: true,
                      ),
                      _StepCard(
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
                    _StepCard(
                      step: '01',
                      title: 'Create Account',
                      desc:
                          'Create your supermarket account online in seconds.',
                    ),
                    _StepCard(
                      step: '02',
                      title: 'Add Data',
                      desc: 'Add products, staff, and billing counters easily.',
                    ),
                    _StepCard(
                      step: '03',
                      title: 'Start Billing',
                      desc:
                          'Start billing, tracking inventory, and viewing reports.',
                    ),
                  ],
                );
              },
            ),
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
  final bool isDesktop;

  const _StepCard({
    required this.step,
    required this.title,
    required this.desc,
    this.isDesktop = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isDesktop ? 350 : 300,
      child: Column(
        crossAxisAlignment: isDesktop
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Text(
            step,
            style: GoogleFonts.poppins(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
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
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
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
      margin: EdgeInsets.symmetric(
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(32),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: getResponsiveHorizontalPadding(context),
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Column(
              children: [
                Text(
                  'Designed for Local Supermarkets. Scalable Globally.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondaryColor,
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
                      color: AppTheme.secondaryColor,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 600),
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: const [
                _BenefitTag('Fast Billing and reduced customer waiting time'),
                _BenefitTag('Accurate Stocks records across all products'),
                _BenefitTag(
                  'Clear visibility on Revenue, margins,and performance',
                ),
                _BenefitTag('Secure Cloud-based Access from anywhare'),
                _BenefitTag(
                  'Suitable for single stores andMulti-Branch Supermarkets',
                ),
              ],
            ),
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
          color: AppTheme.secondaryColor,
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
      // color: Colors.white, // Removed for global grid background
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Column(
          children: [
            const Text(
              'Start Managing Your Supermarket\nSmarter Today',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                height: 1.1,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(
              width: 600,
              child: Text(
                'Join supermarket owners who are switching to a faster, more reliable way to manage billing, inventory, and sales.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 48),
            const _AnimatedHeroButton(title: 'Create Free Supermarket Account'),
            const SizedBox(height: 24),
            const Text(
              'No setup fees. No long-term contracts.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class LandingFooter extends StatelessWidget {
  const LandingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 900;
    double horizontalPadding = getResponsiveHorizontalPadding(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFF0A0A0A)),
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        100,
        horizontalPadding,
        60,
      ),
      child: Column(
        children: [
          // --- Unified CTA Section ---
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Column(
              children: [
                // Text(
                //   'Start Managing Your Supermarket\nSmarter Today',
                //   textAlign: TextAlign.center,
                //   style: GoogleFonts.poppins(
                //     fontSize: isDesktop ? 48 : 32,
                //     height: 1.1,
                //     fontWeight: FontWeight.w600,
                //     color: Colors.white,
                //     letterSpacing: -1.0,
                //   ),
                // ),
                // const SizedBox(height: 24),
                SizedBox(
                  width: 600,
                  child: Text(
                    'Koutix is a modern supermarket billing software, inventory management system, and grocery store management solution designed to help retailers improve efficiency, accuracy, and profitability.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[400],
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 20,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: const [
                    _StoreButton(
                      icon: Icons.android,
                      label: 'GET IT ON',
                      storeName: 'Google Play',
                    ),
                    _StoreButton(
                      icon: Icons.phone_iphone,
                      label: 'Download on the',
                      storeName: 'App Store',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Removed "No setup fees..." text to match image cleanliness if desired,
                // but adding it back to match previous unified version consistency.
                Text(
                  'No setup fees. No long-term contracts.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 120),

          // --- Footer Links Section ---
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _FooterBrandColumn()),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _FooterLinkColumn(
                        title: 'Quick Link',
                        links: ['Home', 'Features', 'Benefits', 'Why Us'],
                      ),
                    ),
                    Expanded(
                      child: _FooterLinkColumn(
                        title: 'Support',
                        links: ['Contact Us', 'FAQs', 'Help Center'],
                      ),
                    ),
                    Expanded(
                      child: _FooterLinkColumn(
                        title: 'Resources',
                        links: [
                          'Blog',
                          'Privacy Policy',
                          'Changelog',
                          'Download',
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _FooterBrandColumn(),
                    const SizedBox(height: 60),
                    Wrap(
                      spacing: 40,
                      runSpacing: 40,
                      children: const [
                        _FooterLinkColumn(
                          title: 'Quick Link',
                          links: ['Home', 'Features', 'Benefits', 'Why Us'],
                        ),
                        _FooterLinkColumn(
                          title: 'Support',
                          links: ['Contact Us', 'FAQs', 'Help Center'],
                        ),
                        _FooterLinkColumn(
                          title: 'Resources',
                          links: [
                            'Blog',
                            'Privacy Policy',
                            'Changelog',
                            'Download',
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

class _StoreButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String storeName;

  const _StoreButton({
    required this.icon,
    required this.label,
    required this.storeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black, size: 32),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.8),
                  height: 1,
                ),
              ),
              Text(
                storeName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterBrandColumn extends StatelessWidget {
  const _FooterBrandColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/icons/logowithoutbg.svg',
          height: 40,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 24),
        Text(
          'Koutix — Smart Supermarket Software for Growing Retail Businesses',
          style: TextStyle(fontSize: 16, color: Colors.grey[400], height: 1.6),
        ),
        const SizedBox(height: 32),
        Row(
          children: const [
            _SocialIcon(Icons.facebook),
            SizedBox(width: 16),
            _SocialIcon(Icons.camera_alt),
            SizedBox(width: 16),
            _SocialIcon(Icons.alternate_email),
          ],
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: Colors.grey[400], size: 24);
  }
}

class _FooterLinkColumn extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterLinkColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              link,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimatedHeroButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isSmall;

  const _AnimatedHeroButton({
    this.title = 'Try it for Free',
    this.onPressed,
    this.isSmall = false,
  });

  @override
  State<_AnimatedHeroButton> createState() => _AnimatedHeroButtonState();
}

class _AnimatedHeroButtonState extends State<_AnimatedHeroButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _isHovered ? AppTheme.primaryColor : Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Stack(
              children: [
                // Flowing Background Fill
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutCubic,
                            left: 0,
                            top: 0,
                            bottom: 0,
                            width: _isHovered ? constraints.maxWidth : 0,
                            child: Container(color: AppTheme.primaryColor),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                // Content
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.isSmall ? 20 : 24,
                    vertical: widget.isSmall ? 8 : 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          fontSize: widget.isSmall ? 14 : 16,
                          fontWeight: FontWeight.bold,
                          color: _isHovered ? Colors.black : Colors.black87,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                        child: Text(widget.title),
                      ),
                      SizedBox(width: widget.isSmall ? 8 : 16),
                      // Circular Arrow
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isHovered
                              ? Colors.black
                              : AppTheme.primaryColor,
                        ),
                        child: Icon(
                          _isHovered
                              ? Icons.arrow_outward
                              : Icons.arrow_forward,
                          size: widget.isSmall ? 14 : 16,
                          color: _isHovered
                              ? AppTheme.primaryColor
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GridPatternPainter extends CustomPainter {
  const GridPatternPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey[100]!
          .withValues(alpha: 0.7) // Darker and more visible
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6; // Slightly thicker for visibility

    double step = 10.0; // Minimal grid size

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Badge extends StatelessWidget {
  final String text;
  const Badge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        // border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/koutixlogoonlyforwebsite.svg',
            height: 12,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryColor,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
