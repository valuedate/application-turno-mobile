import 'package:permission_handler/permission_handler.dart';

class CustomLocationPermission {
  static Future<bool> getPermission() async {
    // Check current permission status
    PermissionStatus status = await Permission.locationWhenInUse.status;

    // If permission is already granted, return true
    if (status.isGranted) {
      return true;
    }

    // Request permission
    status = await Permission.locationWhenInUse.request();

    // If permission is still not granted after request
    if (!status.isGranted) {
      // If permission is denied but not permanently
      if (status.isDenied) {
        // Ask again
        return getPermission(); // Recursive call to ask again
      }

      // If permission is permanently denied, open app settings
      if (status.isPermanentlyDenied) {
        // Open app settings so user can enable permission manually
        await openAppSettings();

        // Check if permission was granted after settings opened
        return Permission.locationWhenInUse.isGranted;
      }

      return false;
    }

    return status.isGranted;
  }
}
