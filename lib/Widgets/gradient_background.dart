import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.white54, Colors.blue],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      )),
      child: child,
    );
  }
}
