import 'package:flutter/material.dart';

class ThemeStyle {
  static const Color primary = Color.fromRGBO(67, 142, 255, 1);
  static const Color secondary = Color.fromRGBO(45, 203, 115, 1);
  static const Color warning = Color.fromRGBO(246, 183, 73, 1);
  static const Color alert = Color.fromRGBO(255, 108, 108, 1);
  static const Color darkGray = Color.fromRGBO(73, 80, 87, 1);
  static const Color gray = Color.fromRGBO(135, 138, 153, 1);
  static const Color lightGray = Color.fromRGBO(239, 242, 247, 1);
  static const Color transparentGray = Color.fromRGBO(239, 242, 247, 0.4);
  static const Color borderGray = Color.fromRGBO(207, 217, 232, 1);

  static const LinearGradient mainBackgroundGradient = LinearGradient(
    colors: [primary, primary, Colors.white],
    stops: [0.0, 0.1, 0.25],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient heroBackgroundGradient = LinearGradient(
    colors: [primary, Color.fromRGBO(239, 242, 247, 1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient heroBackgroundGradientWhite = LinearGradient(
    colors: [primary, Colors.white],
    stops: [0.2, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient loginTransition = LinearGradient(
    colors: [primary, Color.fromRGBO(157, 195, 251, 1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient transparentToWhite = LinearGradient(
    colors: [
      // Colors.red,
      Colors.white.withOpacity(0.0),
      Colors.white
    ],
    stops: const [0, 0.4],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static TextStyle textStyle({
    double? fontSize = 15,
    FontWeight? fontWeight = FontWeight.w400,
    double? height = 1,
    Color? color = darkGray,
    bool? underLine = false,
  }) {
    return TextStyle(
        fontFamily: "Gantari",
        color: (underLine!) ? Colors.transparent : color,
        shadows: (underLine)
            ? [Shadow(color: color!, offset: const Offset(0, -2))]
            : [],
        fontWeight: fontWeight,
        height: height,
        fontSize: fontSize,
        decoration:
            (underLine) ? TextDecoration.underline : TextDecoration.none,
        decorationColor: color,
        decorationThickness: 1);
  }

  static getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      useMaterial3: true,
    );
  }
}
