import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? color;
  final double borderRadius;
  final double elevation;
  const CustomButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.color = Colors.greenAccent,
      this.borderRadius = 24,
      this.elevation = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: child,
    );
  }
}
