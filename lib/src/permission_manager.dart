import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  /// Camera 권한 요청 (권한이 없는 경우에만)
  ///
  /// 권한을 부여받은 적이 없거나, 사용자가 이전에 거부한 경우에만 요청한다.
  /// returns : 현재 권한이 있으면 true 없으면 false
  static Future<bool> checkAndRequestCamera() async {
    return _checkAndRequestPermission(Permission.camera);
  }

  /// Storage 권한 요청 (권한이 없는 경우에만)
  ///
  /// 권한을 부여받은 적이 없거나, 사용자가 이전에 거분한 경우에만 요청한다.
  /// returns : 현재 권한이 있으면 treu 없으면 false
  static Future<bool> checkAndRequestStorate() async {
    return _checkAndRequestPermission(Permission.storage);
  }

  static Future<bool> _checkAndRequestPermission(Permission p) async {
    var status = await p.status;
    if (status.isUndetermined || status.isDenied) {
      status = await p.request();
    }

    return status.isGranted;
  }
}
