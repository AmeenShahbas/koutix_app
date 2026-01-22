import 'package:flutter/material.dart';
import 'package:koutix_app/features/landing/utils.dart';
import 'package:koutix_app/features/landing/widgets/infinite_logos_list.dart';

class TrustedBySection extends StatelessWidget {
  const TrustedBySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                color: Colors.grey[500],
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsiveHorizontalPadding(context),
            ),
            child: const InfiniteLogosList(),
          ),
        ],
      ),
    );
  }
}
