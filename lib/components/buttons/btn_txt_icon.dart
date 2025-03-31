import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';

class BtnTextIcon extends StatefulWidget {
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final String text;
  // Support for both asset images and IconData (Material icons)
  final AssetImage? icon;
  final IconData? materialIcon;
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
    this.materialIcon,
    this.iconSize = 20,
    this.disabled = false,
    this.width = 175,
    required this.onClick,
  }) : assert(icon == null || materialIcon == null,
            'You can provide either icon or materialIcon, not both');

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
    disabled = widget.disabled;
    opacity = widget.disabled ? 0.4 : 1.0;
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
          _buildIconContainer(),
        ],
      ),
    );
  }

  Widget _buildIconContainer() {
    // If both icons are null, return an empty container
    if (widget.icon == null && widget.materialIcon == null) {
      return Container();
    }

    return Container(
      constraints:
          const BoxConstraints(maxWidth: 35, minWidth: 35, minHeight: 40),
      decoration:
          BoxDecoration(color: Colors.white.withAlpha((0.15 * 255).toInt())),
      child: widget.materialIcon != null
          ? Icon(
              widget.materialIcon,
              color: widget.textColor!.withAlpha((opacity * 255).toInt()),
              size: widget.iconSize,
            )
          : ImageIcon(
              widget.icon,
              color: widget.textColor!.withAlpha((opacity * 255).toInt()),
              size: widget.iconSize,
            ),
    );
  }
}
