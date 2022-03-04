import 'package:flutter/material.dart';

class CustomAlignedContainer extends StatelessWidget {
  final AlignmentGeometry alignment;
  final Color color;
  final double opacity;
  final double padding;
  final double borderRadius;
  final Widget child;

  const CustomAlignedContainer(
      {Key? key,
      required this.alignment,
      this.color = Colors.white,
      this.opacity = 1.0,
      this.padding = 0.0,
      this.borderRadius = 0.0,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: color.withOpacity(opacity),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}
