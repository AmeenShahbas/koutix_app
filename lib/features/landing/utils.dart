import 'package:flutter/material.dart';

double getResponsiveHorizontalPadding(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width >= 1280) return 138.0;
  if (width >= 768) return 32.0;
  return 16.0;
}
