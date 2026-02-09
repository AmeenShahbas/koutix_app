import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'dart:ui';
import '../../../core/theme/app_theme.dart';

class BranchManagerDashboardScreen extends StatefulWidget {
  const BranchManagerDashboardScreen({super.key});

  @override
  State<BranchManagerDashboardScreen> createState() =>
      _BranchManagerDashboardScreenState();
}

class _BranchManagerDashboardScreenState
    extends State<BranchManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Gradient Background
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.6, -0.6),
              radius: 1.4,
              colors: [
                Color(0xFF2E5915),
                Color(0xFF1B3B0F),
                Color(0xFF080F05),
                Colors.black,
              ],
              stops: [0.0, 0.2, 0.5, 1.0],
            ),
          ),
        ),

        // 2. Grain Overlay
        Positioned.fill(
          child: Opacity(
            opacity: 0.25,
            child: CustomPaint(painter: GrainPainter()),
          ),
        ),

        // 3. Content
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(),
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.storefront_outlined,
                        size: 64,
                        color: AppTheme.primaryColor.withOpacity(0.8),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Branch Manager Dashboard",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Welcome to your branch portal.",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Branch Manager Dashboard",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }
}

class GrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random();

    for (int i = 0; i < 25000; i++) {
      paint.color = Colors.white.withOpacity(random.nextDouble() * 0.05);
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        0.7,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
