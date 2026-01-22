import 'package:flutter/material.dart';
import 'package:koutix_app/features/landing/widgets/trust_logo.dart';

class InfiniteLogosList extends StatefulWidget {
  const InfiniteLogosList({super.key});

  @override
  State<InfiniteLogosList> createState() => _InfiniteLogosListState();
}

class _InfiniteLogosListState extends State<InfiniteLogosList> {
  late ScrollController _scrollController;

  // Create a list of dummy logos with Icons to match the visual style
  final List<Widget> _logos = [
    const TrustLogo(icon: Icons.ac_unit_outlined, text: 'FrozenMart'),
    const TrustLogo(icon: Icons.shopping_cart_outlined, text: 'DailyFresh'),
    const TrustLogo(icon: Icons.eco_outlined, text: 'GreenGrocer'),
    const TrustLogo(icon: Icons.bakery_dining_outlined, text: 'CityBakery'),
    const TrustLogo(icon: Icons.storefront_outlined, text: 'SuperBazaar'),
    const TrustLogo(icon: Icons.shopping_bag_outlined, text: 'QuickPick'),
    const TrustLogo(icon: Icons.local_offer_outlined, text: 'ValueMart'),
    const TrustLogo(icon: Icons.inventory_2_outlined, text: 'StockPile'),
    const TrustLogo(icon: Icons.attach_money_outlined, text: 'ProfitMax'),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    // Animate to a very far distance to simulate infinite scroll
    // 50,000 pixels at 20 pixels/sec = 2500 seconds (~40 mins of loop)
    // In a real app with infinite items, this is sufficient for a session.
    const double dist = 50000.0;
    const double speed = 100.0; // pixels per sec
    final double time = dist / speed;

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + dist,
        duration: Duration(seconds: time.toInt()),
        curve: Curves.linear,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Further increased height
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent,
            ],
            stops: [0.0, 0.05, 0.95, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _logos[index % _logos.length],
            );
          },
        ),
      ),
    );
  }
}
