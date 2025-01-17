import 'package:permission_handler/permission_handler.dart';

class CustomLocationPermission {
  static getPermission() async {
    await Permission.locationWhenInUse.request();
  }
}
