import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/nav_link.dart';
import 'package:koutix_app/features/landing/widgets/mobile_nav_link.dart';
import 'package:koutix_app/features/landing/widgets/animated_hero_button.dart';
import 'package:koutix_app/features/admin/dashboard/dashboard_screen.dart';

class LandingNavBar extends StatefulWidget {
  final String activeSection;
  final VoidCallback onWhyUsTap;
  final VoidCallback onFeaturesTap;
  final VoidCallback onBenefitsTap;
  final VoidCallback onHomeTap;

  const LandingNavBar({
    super.key,
    this.activeSection = 'Home',
    required this.onWhyUsTap,
    required this.onFeaturesTap,
    required this.onBenefitsTap,
    required this.onHomeTap,
  });

  @override
  State<LandingNavBar> createState() => _LandingNavBarState();
}

class _LandingNavBarState extends State<LandingNavBar>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _handleNavTap(VoidCallback callback) {
    callback();
    if (_isMenuOpen) {
      _toggleMenu();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 900;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: getResponsiveHorizontalPadding(context),
            vertical: 32,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white24, width: 1.5),
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
              // Logo
              SvgPicture.asset('assets/icons/logowithoutbg.svg', height: 50),

              // Desktop Links
              if (!isMobile)
                Row(
                  children: [
                    NavLink(
                      title: 'Home',
                      isActive: widget.activeSection == 'Home',
                      onTap: widget.onHomeTap,
                    ),
                    NavLink(
                      title: 'Why Us',
                      isActive: widget.activeSection == 'Why Us',
                      onTap: widget.onWhyUsTap,
                    ),
                    NavLink(
                      title: 'Features',
                      isActive: widget.activeSection == 'Features',
                      onTap: widget.onFeaturesTap,
                    ),
                    NavLink(
                      title: 'Benefits',
                      isActive: widget.activeSection == 'Benefits',
                      onTap: widget.onBenefitsTap,
                    ),
                  ],
                ),

              // Desktop Action Button or Mobile Menu Icon
              if (!isMobile)
                AnimatedHeroButton(
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
                )
              else
                GestureDetector(
                  onTap: _toggleMenu,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animation,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
            ],
          ),
        ),
        // Mobile Menu
        if (isMobile)
          SizeTransition(
            sizeFactor: _animation,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: getResponsiveHorizontalPadding(context),
              ),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white24, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MobileNavLink(
                    title: 'Home',
                    onTap: () => _handleNavTap(widget.onHomeTap),
                  ),
                  const SizedBox(height: 20),
                  MobileNavLink(
                    title: 'Why Us',
                    onTap: () => _handleNavTap(widget.onWhyUsTap),
                  ),
                  const SizedBox(height: 20),
                  MobileNavLink(
                    title: 'Features',
                    onTap: () => _handleNavTap(widget.onFeaturesTap),
                  ),
                  const SizedBox(height: 20),
                  MobileNavLink(
                    title: 'Benefits',
                    onTap: () => _handleNavTap(widget.onBenefitsTap),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: AnimatedHeroButton(
                      title: 'Download App',
                      isSmall: false,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminDashboardScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
