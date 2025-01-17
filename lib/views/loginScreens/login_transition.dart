import 'dart:async';

import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';

class LoginTransition extends StatefulWidget {
  const LoginTransition({super.key});

  @override
  State<LoginTransition> createState() => _LoginTransitionState();
}

class _LoginTransitionState extends State<LoginTransition> {
  bool shrink = false;

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        shrink = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;

    return AnimatedContainer(
      width: sizes.width,
      curve: Curves.easeInOut,
      height: (shrink) ? 290 : sizes.height,
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.vertical(
            bottom: Radius.circular((shrink) ? sizes.width / 2 : 0)),
        gradient: ThemeStyle.loginTransition,
      ),
      child: Image.asset("assets/images/splash.png"),
    );
  }
}
