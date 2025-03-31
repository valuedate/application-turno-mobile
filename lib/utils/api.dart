import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Api {
  static String baseUrl = "https://www.turno.pt/api/v1/mobile/";

  static Future<Object> loginWithEmail(
      {required String email, required String pass}) async {
    final Uri url = Uri.parse(
        "${baseUrl}loginemail?email=${Uri.encodeComponent(email)}&password=$pass");
    Uri.encodeComponent("${baseUrl}loginemail?email=$email&password=$pass");
    final response = await http.post(url);
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> loginWithCode({required String code}) async {
    final url = "${baseUrl}logincode?code=$code";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> coworkerDetail({required String token}) async {
    final url = "${baseUrl}coworkerdetail?token=$token";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> currentShift({required String token}) async {
    final url = "${baseUrl}currentshift?token=$token";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> nextShift({required String token}) async {
    final url = "${baseUrl}nextshift?token=$token";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> listRotation({required String token}) async {
    final url = "${baseUrl}listrotation?token=$token";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> timeSheetPunch({
    required String token,
    required String time,
    String? status,
    String? note,
    String? rate,
    double? lat,
    double? lon,
  }) async {
    String location = (lat != null && lon != null) ? "&lat=$lat&lon=$lon" : "";
    String sendStatus = (status != null) ? "&status$status" : "";
    String sendRate = (status != null) ? "&rate$rate" : "";
    String sendNote = (status != null) ? "&note$note" : "";
    String app = (Platform.isAndroid) ? "&app=Android" : "&app=iOS";
    final url =
        "${baseUrl}timesheetpunch?token=$token&time=$time$sendStatus$location$sendStatus$sendRate$sendNote$app";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> timeSheetHistory({required String token}) async {
    final url = "${baseUrl}timesheethistory?token=$token";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> timeSheetPunchExtra({
    required String token,
    required String time,
    team,
    String? status,
    double? lat,
    double? lon,
    String? note,
    String? rate,
  }) async {
    String location = (lat != null && lon != null) ? "&lat=$lat&lon=$lon" : "";
    String sendStatus = (status != null) ? "&status$status" : "";
    String sendNote = (note != null) ? "&note$note" : "";
    String sendRate = (status != null) ? "&rate$rate" : "";
    String app = (Platform.isAndroid) ? "&app=Android" : "&app=iOS";
    String teamId = (team != null) ? "&team=$team" : "";
    final url =
        "${baseUrl}timesheetpunchextra?token=$token&time=$time$sendStatus$location$sendStatus$sendNote$sendRate$app$teamId";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> timeSheetRunning({required String token}) async {
    final url = "${baseUrl}timesheetrunning?token=$token";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<Object> listTeams({required String token}) async {
    final url = "${baseUrl}listteams?token=$token";
    final response = await http.post(Uri.parse(url));
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
