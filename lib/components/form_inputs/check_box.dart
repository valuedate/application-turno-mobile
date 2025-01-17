import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function onChange;
  final String text;
  final Color? color;
  final Color? checkColor;
  final Color? activeColor;
  const CustomCheckbox(
      {required this.value,
      required this.onChange,
      required this.text,
      this.color,
      this.checkColor = ThemeStyle.primary,
      this.activeColor = Colors.white,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange(!value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 17,
            width: 17,
            child: Checkbox(
                side: const BorderSide(style: BorderStyle.none),
                fillColor: (!value) ? WidgetStatePropertyAll(color) : null,
                activeColor: activeColor,
                checkColor: checkColor,
                value: value,
                onChanged: (value) {
                  onChange(value);
                }),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: ThemeStyle.textStyle(fontSize: 13, color: color),
          ),
        ],
      ),
    );
  }
}
