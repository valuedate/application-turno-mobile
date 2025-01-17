import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static final GeolocatorPlatform _geolocatorPlatform =
      GeolocatorPlatform.instance;

  static Future<dynamic> getCurrentPosition() async {
    return await _geolocatorPlatform.getCurrentPosition();
  }
}
