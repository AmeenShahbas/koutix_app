import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import 'dart:ui'; // For ImageFilter
import '../core/theme/app_theme.dart';
import '../core/services/auth_service.dart';
import 'sign_up_screen.dart';
import '../features/super_admin/dashboard/super_admin_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _handleController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _handleController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Minimized Perfect Gradient - More Primary Green
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.6, -0.6), // Subtle Top-Left Lighting
                radius: 1.4,
                colors: [
                  Color(0xFF2E5915), // Brighter/More Primary Green
                  Color(0xFF1B3B0F), // Rich Deep Green
                  Color(0xFF080F05), // Deep dark transition
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

          // 3. Top Left Logo (Raw Logo without Container) - Desktop/Tablet only
          if (MediaQuery.of(context).size.width >= 600)
            Positioned(
              top: 40,
              left: 32,
              child: SafeArea(
                child: SvgPicture.asset(
                  'assets/icons/logowithoutbg.svg',
                  height: 56, // Adjusted size
                  fit: BoxFit.contain,
                ),
              ),
            ),

          // 4. Centered Glass Card (Aligned & Sized)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 480),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 48,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04), // Subtle glass
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 60,
                          offset: const Offset(0, 30),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Mobile Logo - Visible only on small screens inside the card
                        if (MediaQuery.of(context).size.width < 600) ...[
                          Center(
                            child: SvgPicture.asset(
                              'assets/icons/logowithoutbg.svg',
                              height: 48,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        // Header Title - Forced Single Line View Logic
                        // Using FittedBox or just standard text logic, the user wants "Welcome Back to Koutix"
                        // to be visually minimal/singleish if possible, but 2 lines is standard for mobile.
                        // Based on the image, "Welcome Back to" is line 1, "Koutix" is line 2.
                        // BUT User request says: "make the Welcome Back to Koutix text in a single line now its show like in the image"
                        // Wait, user said "make ... single line... NOW its show like in the image" (image shows 2 lines).
                        // It implies "Change it to single line, currently it looks like the image (2 lines)".
                        // I will force it to be single line with FittedBox or just normal text without forced breaks.
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Welcome Back to Koutix',
                            style: GoogleFonts.poppins(
                              fontSize: 28, // Scalable base
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.1,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Subtitle
                        Text(
                          'Sign in to manage your supermarket billing, inventory, and sales dashboard.',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.7),
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),

                        // Form Inputs
                        _buildLabel('Email Address'),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _handleController,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: AppTheme.primaryColor,
                          decoration: _inputDecoration(
                            'Enter registered email',
                          ),
                        ),
                        const SizedBox(height: 28),

                        _buildLabel('Password'),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: AppTheme.primaryColor,
                          decoration: _inputDecoration('Enter your password')
                              .copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.white54,
                                    size: 22,
                                  ),
                                  onPressed: () => setState(
                                    () => _isPasswordVisible =
                                        !_isPasswordVisible,
                                  ),
                                ),
                              ),
                        ),

                        const SizedBox(height: 40),

                        // Primary Button
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.black,
                                    ),
                                  )
                                : const Text('Login to Dashboard'),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Secondary Options
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white70,
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.inter(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Create Account',
                                style: GoogleFonts.inter(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.85),
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        color: Colors.white.withOpacity(0.3),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.red.withOpacity(0.5), width: 1),
      ),
    );
  }

  Future<void> _handleLogin() async {
    final email = _handleController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: Colors.red.shade900,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await _authService.login(email, password);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login Successful: Welcome Back!',
              style: GoogleFonts.inter(color: Colors.black),
            ),
            backgroundColor: AppTheme.primaryColor,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SuperAdminDashboardScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: Colors.red.shade900,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class GrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random();

    for (int i = 0; i < 25000; i++) {
      paint.color = Colors.white.withOpacity(random.nextDouble() * 0.1);
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
