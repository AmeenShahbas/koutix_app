import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollAnimatedFadeInUp extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double from;
  final Curve curve;

  const ScrollAnimatedFadeInUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.from = 20,
    this.curve = Curves.easeOut,
  });

  @override
  State<ScrollAnimatedFadeInUp> createState() => _ScrollAnimatedFadeInUpState();
}

class _ScrollAnimatedFadeInUpState extends State<ScrollAnimatedFadeInUp> {
  late AnimationController _controller;
  bool _hasAnimated = false;
  final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (!_hasAnimated && info.visibleFraction > 0.1) {
          if (mounted) {
            _controller.forward();
            _hasAnimated = true;
          }
        }
      },
      child: FadeInUp(
        manualTrigger: true,
        controller: (controller) => _controller = controller,
        delay: widget.delay,
        duration: widget.duration,
        from: widget.from,
        curve: widget.curve,
        child: widget.child,
      ),
    );
  }
}
