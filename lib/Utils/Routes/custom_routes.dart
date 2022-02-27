import 'package:flutter/cupertino.dart';

class BottomSlideTransition extends PageRouteBuilder {
  final Widget page;
  BottomSlideTransition({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, page) {
            Animation<Offset> _slideAnimation =
                Tween(begin: const Offset(0, 1), end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
            // Animation<double> _fadeAnimation =
            // Tween(begin: 0.0, end: 1.0).animate(
            // CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            // );
            return SlideTransition(
              position: _slideAnimation,
              child: page,
            );
          },
          pageBuilder: (context, a, _) => page,
        );
}
