import 'package:flutter/material.dart';
import 'package:turno/utils/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Fale Connosco",
          style: ThemeStyle.textStyle(
            fontSize: 13,
            color: ThemeStyle.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "Termos e Condições",
          style: ThemeStyle.textStyle(
            fontSize: 13,
            color: ThemeStyle.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "turno.cloud",
          style: ThemeStyle.textStyle(
            fontSize: 13,
            color: ThemeStyle.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
