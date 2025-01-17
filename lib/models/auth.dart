import 'package:turno/exceptions/auth_exceptions.dart';
import 'package:turno/utils/api.dart';
import 'package:turno/utils/routes.dart';
import 'package:turno/utils/store.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String? _token;

  bool get isAuth {
    return _token != null && _token != "";
  }

  String? get token {
    return isAuth ? _token : null;
  }

  Future<void> loginWithPass(
      String email, String password, bool saveData, ctx) async {
    dynamic response = await Api.loginWithEmail(email: email, pass: password);
    if (response["status"] >= 400) {
      throw AuthException(msg: response["message"]);
    } else {
      _token = response["token"];
      if (saveData) {
        await Store.saveString("token", _token!);
      } else {
        await Store.remove("token");
      }
      notifyListeners();
      Navigator.restorablePushReplacementNamed(ctx, MyRoutes.splash);
    }
  }

  Future<void> loginWithCode(String code, bool saveData, ctx) async {
    dynamic response = await Api.loginWithCode(code: code);
    if (response["status"] >= 400) {
      throw AuthException(msg: response["message"]);
    } else {
      _token = response["token"];
      if (saveData) {
        await Store.saveString("token", _token!);
      } else {
        await Store.remove("token");
      }
      notifyListeners();
      Navigator.restorablePushReplacementNamed(ctx, MyRoutes.splash);
    }
  }

  void logout(ctx) async {
    await Store.remove("token");
    _token = null;
    Navigator.restorablePushReplacementNamed(ctx, MyRoutes.login);
  }

  void recoveryPass() {
    //Existe tela desenhada para isso no figma, mas ainda não há endpoint para isso
    print("recovery pass WIP");
  }

  Future<void> tryAutoLogin() async {
    if (_token == null || _token == "") _token = await Store.getString("token");
    if (isAuth) return;
  }
}
