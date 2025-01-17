import 'package:turno/utils/theme.dart';
import 'package:turno/views/loginScreens/login_code.dart';
import 'package:turno/views/loginScreens/login_transition.dart';
import 'package:flutter/material.dart';

import 'login_pass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  int selectedIndex = 0;
  double opacity = 1.0;
  PageController? _pageController;
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeStyle.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LoginTransition(),
            GestureDetector(
              onTap: FocusScope.of(context).unfocus,
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: opacity,
                  child: <Widget>[
                    LoginPass(
                      changePage: _onChangePage,
                    ),
                    LoginCode(
                      changePage: _onChangePage,
                    )
                  ][selectedIndex]),
            ),
          ],
        ),
      ),
    );
  }

  void _onChangePage(int index) async {
    setState(() {
      opacity = 0;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      selectedIndex = index;
      opacity = 1;
    });
  }
}
