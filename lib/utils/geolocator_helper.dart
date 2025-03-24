import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static final GeolocatorPlatform _geolocatorPlatform =
      GeolocatorPlatform.instance;

  static Future<Position> getCurrentPosition() async {
    try {
      return await _geolocatorPlatform.getCurrentPosition();
    } catch (e) {
      // Return default position (0,0) if position wasn't allowed
      return Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
      );
    }
  }
}
