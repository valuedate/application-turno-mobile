import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';

class BtnTextIcon extends StatefulWidget {
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final String text;
  final AssetImage? icon;
  final double? iconSize;
  final Function onClick;
  final bool disabled;
  final double? width;

  const BtnTextIcon({
    super.key,
    this.color = ThemeStyle.primary,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    required this.text,
    this.icon,
    this.iconSize = 20,
    this.disabled = false,
    this.width = 175,
    required this.onClick,
  });

  @override
  State<BtnTextIcon> createState() => _BtnTextIconState();
}

class _BtnTextIconState extends State<BtnTextIcon> {
  bool disabled = false;
  double opacity = 1;
  @override
  void dispose() {
    disabled = false;
    opacity = 1;
    super.dispose();
  }

  @override
  void initState() {
    bool disabled = widget.disabled;
    double opacity = widget.disabled ? 0.4 : 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      clipBehavior: Clip.hardEdge,
      style: ButtonStyle(
        side: WidgetStatePropertyAll(BorderSide(color: widget.borderColor!)),
        elevation: const WidgetStatePropertyAll(0.0),
        maximumSize: WidgetStatePropertyAll(Size(widget.width!, 40)),
        minimumSize: WidgetStatePropertyAll(Size(widget.width!, 40)),
        backgroundColor: WidgetStatePropertyAll(
            widget.color!.withAlpha((opacity * 255).toInt())),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
      onPressed: disabled
          ? null
          : () async {
              setState(() {
                disabled = true;
                opacity = 0.4;
              });
              await widget.onClick();
              setState(() {
                disabled = false;
                opacity = 1;
              });
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontFamily: "Gantari",
                  color: widget.textColor!.withAlpha((opacity * 255).toInt()),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          (widget.icon != null)
              ? Container(
                  constraints: const BoxConstraints(
                      maxWidth: 35, minWidth: 35, minHeight: 40),
                  decoration: BoxDecoration(
                      color: Colors.white.withAlpha((0.15 * 255).toInt())),
                  child: ImageIcon(
                    widget.icon,
                    color: widget.textColor,
                    size: widget.iconSize,
                  ))
              : Container()
        ],
      ),
    );
  }
}
