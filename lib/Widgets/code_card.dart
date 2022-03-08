import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeCard extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;
  const CodeCard(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(18),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.fromBorderSide(
          BorderSide(
            width: 2,
            color: Colors.greenAccent.withOpacity(0.5),
          ),
        ),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              Center(
                child: Opacity(
                  opacity: 0.3,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
