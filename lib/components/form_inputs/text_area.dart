import 'package:flutter/material.dart';
import 'package:turno/utils/theme.dart';

class TextArea extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final Function? onChanged;
  const TextArea(
      {required this.placeholder,
      required this.controller,
      this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 10,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: ThemeStyle.borderGray)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: ThemeStyle.borderGray)),
        hintText: placeholder,
        hintStyle: ThemeStyle.textStyle(color: ThemeStyle.gray),
      ),
      onChanged: (value) {
        if (onChanged != null) onChanged!(value);
      },
    );
  }
}
