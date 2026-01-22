import 'package:flutter/material.dart';

class HeroImageComposition extends StatelessWidget {
  const HeroImageComposition({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/heroimage.png', fit: BoxFit.contain);
  }
}
