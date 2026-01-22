import 'package:flutter/material.dart';
import 'package:koutix_app/features/landing/widgets/grid_pattern_painter.dart';
import 'package:koutix_app/features/landing/sections/landing_hero_section.dart';
import 'package:koutix_app/features/landing/sections/trusted_by_section.dart';
import 'package:koutix_app/features/landing/sections/why_choose_section.dart';
import 'package:koutix_app/features/landing/sections/features_section.dart';
import 'package:koutix_app/features/landing/sections/how_it_works_section.dart';
import 'package:koutix_app/features/landing/sections/benefits_section.dart';
import 'package:koutix_app/features/landing/sections/final_cta_section.dart';
import 'package:koutix_app/features/landing/sections/landing_footer.dart';
import 'package:koutix_app/features/landing/sections/landing_nav_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Global keys for each section
  final GlobalKey whyUsKey = GlobalKey();
  final GlobalKey featuresKey = GlobalKey();
  final GlobalKey benefitsKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  String _activeSection = 'Home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Simple logic: check if sections are visible
    // We can check offset or use keys. Since we have keys and layouts vary, keys are better but expensive in scroll loop?
    // Let's use simplistic offset checking relative to context if possible, or just offsets if we assume heights.
    // Actually, finding render object in scroll listener is okay for desktop landing pages found in keys.

    // Define thresholds or checks
    if (!_scrollController.hasClients) return;

    // Helper to get Y position of key relative to viewport
    double? getKeyY(GlobalKey key) {
      final context = key.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);
        return offset.dy;
      }
      return null;
    }

    final whyUsY = getKeyY(whyUsKey);
    final featuresY = getKeyY(featuresKey);
    final benefitsY = getKeyY(benefitsKey);

    // Navbar height approx 100.
    // If a section is "near the top" (e.g. < 300px), it's active.
    // Check in reverse order (bottom up)

    String newSection = 'Home';

    if (benefitsY != null && benefitsY < 300) {
      newSection = 'Benefits';
    } else if (featuresY != null && featuresY < 300) {
      newSection = 'Features';
    } else if (whyUsY != null && whyUsY < 300) {
      newSection = 'Why Us';
    } else {
      newSection = 'Home';
    }

    if (newSection != _activeSection) {
      setState(() {
        _activeSection = newSection;
      });
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero).dy;
      final currentScroll = _scrollController.offset;
      final targetScroll =
          currentScroll + position - 100; // 100px offset for navbar

      _scrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Global Grid Background
          Positioned.fill(
            child: CustomPaint(painter: const GridPatternPainter()),
          ),
          // Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 100), // Space for sticky navbar
                const LandingHeroSection(),
                const TrustedBySection(),
                WhyChooseSection(key: whyUsKey),
                FeaturesSection(key: featuresKey),
                const HowItWorksSection(),
                BenefitsSection(key: benefitsKey),
                const FinalCTASection(),
                LandingFooter(
                  onWhyUsTap: () => _scrollToSection(whyUsKey),
                  onFeaturesTap: () => _scrollToSection(featuresKey),
                  onBenefitsTap: () => _scrollToSection(benefitsKey),
                  onHomeTap: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            ),
          ),
          // Sticky Navbar - Always on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LandingNavBar(
              activeSection: _activeSection,
              onWhyUsTap: () => _scrollToSection(whyUsKey),
              onFeaturesTap: () => _scrollToSection(featuresKey),
              onBenefitsTap: () => _scrollToSection(benefitsKey),
              onHomeTap: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
