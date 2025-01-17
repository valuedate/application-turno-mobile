import 'package:turno/views/loginScreens/login_main.dart';
import 'package:turno/views/mainScreens/main_screens.dart';
import 'package:turno/views/menu/menu.dart';
import 'package:turno/views/splashScreen/splash.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  static const String home = "/home";
  static const String login = "/login";
  static const String splash = "/splash";
  static const String menu = "/menu";

  static getRoutes(settings, ctx) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (ctx) {
          return const MainScreens();
        });
      case login:
        return MaterialPageRoute(builder: (ctx) {
          return const Login();
        });
      case splash:
        return MaterialPageRoute(builder: (ctx) {
          return const Splash();
        });
      case menu:
        return MaterialPageRoute(builder: (ctx) {
          return const Menu();
        });
    }
  }
}
