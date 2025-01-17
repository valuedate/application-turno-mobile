import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum InputType { text, email, pass }

class CustomTextInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final InputType type;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const CustomTextInput(
      {required this.label,
      required this.placeholder,
      required this.type,
      required this.controller,
      this.keyboardType = TextInputType.text,
      super.key});

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          width: double.maxFinite,
          child: Text(
            widget.label,
            style: ThemeStyle.textStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ),
        Stack(
          children: [
            TextFormField(
              cursorColor: ThemeStyle.primary,
              style: ThemeStyle.textStyle(),
              obscureText:
                  (widget.type == InputType.pass && !showPass) ? true : false,
              controller: widget.controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(5),
                ),
                hoverColor: ThemeStyle.primary,
                hintText: widget.placeholder,
                hintStyle: ThemeStyle.textStyle(color: ThemeStyle.gray),
              ),
              keyboardType: (widget.type == InputType.email)
                  ? TextInputType.emailAddress
                  : (widget.keyboardType == TextInputType.phone)
                      ? TextInputType.phone
                      : null,
              autofillHints: (widget.type == InputType.email)
                  ? [AutofillHints.email]
                  : null,
              validator: (value) {
                return validateForm(widget.type, value ?? "", context);
              },
            ),
            if (widget.type == InputType.pass)
              Positioned(
                  right: 10,
                  bottom: 12,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                    child: Icon(
                      (showPass) ? Icons.visibility : Icons.visibility_off,
                      color: ThemeStyle.gray,
                    ),
                  )),
          ],
        ),
      ],
    );
  }
}

String? validateForm(InputType type, String value, ctx) {
  switch (type) {
    case InputType.email:
      {
        final email = value;
        if (email.trim().isEmpty || !email.contains('@')) {
          return AppLocalizations.of(ctx)!.invalid_mail;
        }
        return null;
      }
    case InputType.pass:
      {
        final pass = value;
        if (pass.trim().isEmpty || pass.length < 4) {
          return AppLocalizations.of(ctx)!.invalid_pass;
        }
      }
    default:
      return null;
  }
  return null;
}
