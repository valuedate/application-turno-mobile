import 'package:turno/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:turno/utils/store.dart';

class User with ChangeNotifier {
  String? _name;
  String? _image;
  String? _entity;
  dynamic _entityList;

  String? get name {
    return _name;
  }

  String? get image {
    return _image;
  }

  String? get entity {
    return _entity;
  }

  dynamic get entityList {
    return _entityList;
  }

  void clear() {
    _name = null;
    _image = null;
    _entity = null;
    _entityList = null;
  }

  Future<void> loadUser(token) async {
    dynamic responseList = await Api.coworkerDetail(token: token);
    dynamic response = responseList[0];
    if (response["id"] != null) {
      _name = response["name"];
      _image = response["photo"];
      _entity = response["team_name"];
      _entityList = await Api.listTeams(token: token);
    }
    return;
  }
}
