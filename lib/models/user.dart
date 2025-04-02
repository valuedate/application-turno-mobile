import 'package:turno/utils/api.dart';
import 'package:flutter/material.dart';

class User with ChangeNotifier {
  String? _name;
  String? _image;
  String? _entity;
  dynamic _entityList;

  // New fields

  String? _email;
  String? _code;
  int? _id;
  int? _teamId;
  String? _contractType;
  String? _admission;
  String? _birthday;
  int? _mainContact;
  String? _color;
  String? _shiftAutoEnd;
  int? _shiftMaxTime;

  // Existing getters
  String? get name => _name;
  String? get image => _image;
  String? get entity => _entity;
  dynamic get entityList => _entityList;

  // New getters
  int? get id => _id;
  int? get teamId => _teamId;
  String? get contractType => _contractType;
  String? get admission => _admission;
  String? get birthday => _birthday;
  int? get mainContact => _mainContact;
  String? get color => _color;
  String? get shiftAutoEnd => _shiftAutoEnd;
  String? get email => _email;
  String? get code => _code;
  int? get shiftMaxTime => _shiftMaxTime;

  void clear() {
    _name = null;
    _image = null;
    _entity = null;
    _entityList = null;
    _email = null;
    _code = null;
    _id = null;
    _teamId = null;
    _contractType = null;
    _admission = null;
    _birthday = null;
    _mainContact = null;
    _color = null;
    _shiftAutoEnd = null;
    _shiftMaxTime = null;
  }

  Future<void> loadUser(token) async {
    dynamic responseList = await Api.coworkerDetail(token: token);
    dynamic response = responseList[0];
    if (response["id"] != null) {
      _id = response["id"];
      _teamId = response["team_id"];
      _name = response["name"];
      _image = response["photo"];
      _entity = response["team_name"];
      _code = response["cod"];
      _email = response["email"];
      _contractType = response["contract_type"];
      _admission = response["admission"];
      _birthday = response["birthday"];
      _mainContact = response["main_contact"];
      _color = response["color"];
      _shiftAutoEnd = response["shift_auto_end"];
      _shiftMaxTime = response["shift_max_time"];
      _entityList = await Api.listTeams(token: token);
    }
    notifyListeners(); // Notify listeners about the changes
    return;
  }
}
