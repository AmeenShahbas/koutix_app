import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koutix_app/features/landing/widgets/social_icon.dart';

class FooterBrandColumn extends StatelessWidget {
  const FooterBrandColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/icons/logowithoutbg.svg', height: 50),
        const SizedBox(height: 12),
        Text(
          'Smart Supermarket Software\nfor Growing Retail Businesses',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16, color: Colors.grey[400], height: 1.6),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SocialIcon(Icons.facebook_outlined),
            SizedBox(width: 16),
            SocialIcon(Icons.camera_alt_outlined),
            SizedBox(width: 16),
            SocialIcon(Icons.alternate_email_outlined),
          ],
        ),
      ],
    );
  }
}
