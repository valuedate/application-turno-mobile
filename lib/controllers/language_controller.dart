import 'package:flutter/material.dart';

class LanguageController extends ChangeNotifier {
  String currentLang = "pt";

  void changeLanguage(String lang) {
    currentLang = lang;
    notifyListeners();
  }
}
