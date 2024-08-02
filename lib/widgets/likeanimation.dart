import 'package:flutter/material.dart';

class Likeanimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final bool isIconclick;
  final VoidCallback? onEnd;
  final Duration duration;
  const Likeanimation(
      {super.key,
      required this.child,
      required this.isAnimating,
      this.isIconclick = false,
      this.onEnd,
      this.duration = const Duration(milliseconds: 500)});

  @override
  State<Likeanimation> createState() => _LikeanimationState();
}

class _LikeanimationState extends State<Likeanimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleanimation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _scaleanimation =
        Tween<double>(begin: 1, end: 1.3).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Likeanimation oldWidget) {
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  void startAnimation() async {
    if (widget.isAnimating || widget.isIconclick) {
      _animationController.forward();
      _animationController.reverse();
      await Future.delayed(
        const Duration(milliseconds: 800),
      );
    }
    if (widget.onEnd != null) {
      widget.onEnd!();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleanimation,
      child: widget.child,
    );
  }
}
