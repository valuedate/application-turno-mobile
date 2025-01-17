import 'package:turno/models/auth.dart';
import 'package:turno/models/shift.dart';
import 'package:turno/models/user.dart';
import 'package:turno/utils/routes.dart';
import 'package:turno/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context, listen: false);
    User user = Provider.of(context, listen: false);
    Shift shift = Provider.of(context, listen: false);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: SplashScreen());
        } else if (snapshot.error != null) {
          return const Scaffold(
            body: SplashScreen(),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            auth.isAuth
                ? await initialLoads(user, shift, auth.token, context)
                : Navigator.restorablePushReplacementNamed(
                    context, MyRoutes.login);
          });
          return const Scaffold(body: SplashScreen());
        }
      },
    );
  }

  Future<void> initialLoads(User user, Shift shift, token, ctx) async {
    await Future.wait([
      user.loadUser(token),
      shift.loadNextShift(token),
      shift.loadCurrentShift(token),
      shift.loadHistory(token),
    ]);
    Navigator.restorablePushReplacementNamed(ctx, MyRoutes.home);
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: ThemeStyle.loginTransition,
      ),
      child: Image.asset("assets/images/splash.png"),
    );
  }
}
