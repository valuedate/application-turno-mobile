import 'package:flutter/material.dart';
import 'package:turno/utils/theme.dart';

class RoundedElevatedButton extends StatelessWidget {
  final bool showOnlyIcon;
  final String btnText;
  final IconData icon;
  final Function onPressed;
  const RoundedElevatedButton(
      {required this.showOnlyIcon,
      required this.icon,
      required this.onPressed,
      this.btnText = "",
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        maximumSize:
            WidgetStatePropertyAll(Size((showOnlyIcon) ? 40 : 110, 40)),
        minimumSize:
            WidgetStatePropertyAll(Size((showOnlyIcon) ? 40 : 110, 40)),
        padding: WidgetStatePropertyAll(
            EdgeInsets.only(left: (showOnlyIcon) ? 1 : 17, right: 1)),
        elevation: WidgetStatePropertyAll((showOnlyIcon) ? 5 : 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (!showOnlyIcon)
              ? Text(
                  btnText,
                  style: const TextStyle(
                      color: ThemeStyle.primary,
                      fontFamily: "Gantari",
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                )
              : Container(),
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
                color: ThemeStyle.primary.withAlpha(30),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Icon(
              icon,
              color: ThemeStyle.primary,
              size: 24,
            ),
          )
        ],
      ),
    );
  }
}
