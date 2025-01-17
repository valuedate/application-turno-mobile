import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';

class Highlight extends StatelessWidget {
  final String text;
  final bool rounded;
  final Color color;
  final ImageIcon? icon;
  const Highlight(
      {required this.text,
      this.rounded = true,
      this.color = ThemeStyle.primary,
      this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 18, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 35,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular((rounded) ? 18 : 5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          Text(
            text,
            style: ThemeStyle.textStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
