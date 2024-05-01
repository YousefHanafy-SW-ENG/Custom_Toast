import 'package:flutter/material.dart';

class AnimatedOverlayToast extends StatefulWidget {
  final Color color;
  final String message;
  final VoidCallback onDismissed;

  const AnimatedOverlayToast({
    super.key,
    required this.message,
    required this.onDismissed, required this.color,
  });

  @override
  State<AnimatedOverlayToast> createState() => _AnimatedOverlayToastState();
}

class _AnimatedOverlayToastState extends State<AnimatedOverlayToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward().then((value) {
      Future.delayed(const Duration(seconds: 1), () {
        _controller.reverse().then((value) {
          widget.onDismissed();
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity.value,
      child: Container(
        alignment: Alignment.center,
        height: 64,
        color: widget.color,
        child: Text(
          widget.message,
          style:  const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none
          ),
        ),
      ),
    );
  }
}
