import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koutix_app/core/theme/app_theme.dart';

class AnimatedHeroButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isSmall;

  const AnimatedHeroButton({
    super.key,
    this.title = 'Try it for Free',
    this.onPressed,
    this.isSmall = false,
  });

  @override
  State<AnimatedHeroButton> createState() => _AnimatedHeroButtonState();
}

class _AnimatedHeroButtonState extends State<AnimatedHeroButton> {
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
            color: Colors.black,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _isHovered ? AppTheme.primaryColor : Colors.grey.shade700,
              width: 1,
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
                          color: _isHovered ? Colors.black : Colors.white70,
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
