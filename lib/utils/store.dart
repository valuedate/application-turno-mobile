import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<bool> saveString(String key, String value) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(key, value);
  }

  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    return saveString(key, jsonEncode(value));
  }

  static Future<String> getString(String key,
      [String defaultValue = '']) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? defaultValue;
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      return jsonDecode(await getString(key));
    } catch (_) {
      return {};
    }
  }

  static Future<bool> remove(String key) async {
    final pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}
