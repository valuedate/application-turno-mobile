import 'package:turno/utils/api.dart';
import 'package:turno/utils/store.dart';
import 'package:flutter/material.dart';

class Shift with ChangeNotifier {
  dynamic _currentShift;
  dynamic _currentStartedShift;
  List<dynamic>? _nextShift;
  List<dynamic>? _shiftHistory;
  bool? _startedShift;
  bool? _startedShiftExtra;

  dynamic get currentShift {
    return _currentShift ?? {};
  }

  dynamic get currentStartedShift {
    return _currentStartedShift;
  }

  List<dynamic>? get nextShift {
    return _nextShift ?? [];
  }

  List<dynamic>? get shiftHistory {
    return _shiftHistory ?? [];
  }

  bool get startedShift {
    return _startedShift ?? false;
  }

  void startedShiftDefined({required bool value, bool extra = false}) {
    if (extra) {
      _startedShiftExtra = value;
    } else {
      _startedShift = value;
    }
  }

  bool get startedShiftExtra {
    return _startedShiftExtra ?? false;
  }

  //use
  Future<void> loadCurrentShift(token) async {
    await loadTimeSheetRunning(token);
    dynamic responseList = await Api.currentShift(token: token);
    if (_currentStartedShift.isNotEmpty) {
      DateTime now = DateTime.now();
      if (now
              .difference(DateTime.parse(_currentStartedShift["start_at"]))
              .inDays >
          1) {
        clearStartedShift();
      } else {
        if (_currentStartedShift["public_key_uuid"] ==
            responseList[0]["public_key_uuid"]) {}
        if (_currentStartedShift["shift_desc"]
                .toString()
                .substring(0, 2)
                .toUpperCase() ==
            "EX") {
          _startedShiftExtra = true;
        } else {
          _startedShift = true;
          String yearMonth = responseList[0]["rotation_period"];
          String day = responseList[0]["day_period"] < 10
              ? "0${responseList[0]["day_period"]}"
              : responseList[0]["day_period"].toString();
          DateTime end =
              DateTime.parse("$yearMonth-$day ${responseList[0]["sh_end_at"]}");
          DateTime start = DateTime.parse(
              "$yearMonth-$day ${responseList[0]["sh_start_at"]}");
          _currentStartedShift["duration"] =
              end.difference(start).inMinutes.toString();
        }
      }
    }

    if (responseList.length > 0 &&
        responseList[0]["shift_cod"] != "F" &&
        responseList[0]["shift_cod"] != "EX") {
      _currentShift = responseList[0];
      String yearMonth = _currentShift!["rotation_period"];
      String day = _currentShift!["day_period"] < 10
          ? "0${_currentShift!["day_period"]}"
          : _currentShift!["day_period"].toString();
      String shStart = _currentShift!["sh_start_at"];
      String shEnd = _currentShift!["sh_end_at"];
      DateTime start = DateTime.parse("$yearMonth-$day $shStart");
      DateTime end = DateTime.parse("$yearMonth-$day $shEnd");
      if (int.parse(shStart.split(":")[0]) >= int.parse(shEnd.split(":")[0])) {
        end = end.add(const Duration(days: 1));
      }
      _currentShift["start_dateTime"] = start.toString();
      _currentShift["end_dateTime"] = end.toString();
      _currentShift["duration"] = end.difference(start).inMinutes.toString();
    } else {
      _currentShift = {};
      // _startedShift = false;
      // _currentStartedShift = {};
      // conferir se turno extra aparece aqui;
    }

    return;
  }

  //use
  Future<void> loadNextShift(token) async {
    dynamic responseList = await Api.nextShift(token: token);
    _nextShift = responseList;
    return;
  }

  Future<void> timeSheetPunch(
      {required token,
      lat,
      lon,
      status,
      rate,
      note,
      required DateTime time}) async {
    String formatTime = time
        .toString()
        .replaceAll("-", "")
        .replaceAll(" ", "")
        .replaceAll(":", "")
        .split(".")[0];
    dynamic responseList = await Api.timeSheetPunch(
      token: token,
      time: formatTime,
      lat: lat,
      lon: lon,
      note: note,
      rate: rate,
      status: status,
    );
    _currentStartedShift = await Api.timeSheetRunning(token: token);
    _startedShift = true;
  }

  Future<void> loadTimeSheetRunning(token) async {
    dynamic response = await Api.timeSheetRunning(token: token);
    if (response["status"] == null) {
      _startedShift = false;
      _startedShiftExtra = false;
      _currentStartedShift = {};
    } else {
      _currentStartedShift = response;
    }
    notifyListeners();
    return;
  }

  Future<void> clearStartedShift() async {
    _currentStartedShift = {};
    _currentShift = {};
    _startedShift = false;
    _startedShiftExtra = false;
  }

  Future<void> loadHistory(token) async {
    dynamic history = await Api.timeSheetHistory(token: token);
    _shiftHistory = history;
    return;
  }

  Future<bool> checkIfStarted() async {
    if (_currentShift["shift_id"] != null && _shiftHistory!.isNotEmpty) {
      for (var item in _shiftHistory!) {
        if (item["shift_id"] == _currentShift["shift_id"]) {
          if (item["end_at"] == null) {
            dynamic storeShift = {
              "last": {"time": item["start_at"], "next": "SAIDA"},
              "rotation_token": "",
              "start_at": item["start_at"],
              "paused_at": [],
              "lunch_start_at": "",
              "lunch_end_at": "",
            };
            String yearMonth = _currentShift!["rotation_period"];
            String day = _currentShift!["day_period"] < 10
                ? "0${_currentShift!["day_period"]}"
                : _currentShift!["day_period"].toString();
            String shStart = _currentShift!["sh_start_at"];
            String shEnd = _currentShift!["sh_end_at"];
            DateTime start = DateTime.parse("$yearMonth-$day $shStart");
            DateTime end = DateTime.parse("$yearMonth-$day $shEnd");
            if (int.parse(shStart.split(":")[0]) >=
                int.parse(shEnd.split(":")[0])) {
              end = end.add(const Duration(days: 1));
            }
            storeShift["duration"] = end.difference(start).inMinutes.toString();
            await Store.saveMap("currentShift", storeShift);
            // _currentStartedShift = storeShift;
            return true;
          } else {
            await Store.remove("currentShift");
          }
        }
      }
    }
    await Store.remove("currentShift");
    // _currentStartedShift = {};
    return false;
  }

  Future<void> timeSheetPunchExtra(
      {required token,
      lat,
      lon,
      status,
      note,
      rate,
      team,
      required DateTime time}) async {
    String formatTime = time
        .toString()
        .replaceAll("-", "")
        .replaceAll(" ", "")
        .replaceAll(":", "")
        .split(".")[0];
    await Api.timeSheetPunchExtra(
        time: formatTime,
        token: token,
        lat: lat,
        lon: lon,
        team: team,
        status: status,
        note: note);
    _currentStartedShift = await Api.timeSheetRunning(token: token);
    _startedShiftExtra = true;
    return;
  }
}
