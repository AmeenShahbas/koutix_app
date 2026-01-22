import 'package:flutter/material.dart';

class GridPatternPainter extends CustomPainter {
  const GridPatternPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
          .withOpacity(0.05) // Subtle white lines
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

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
