import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  /// Camera 권한 요청 (권한이 없는 경우에만)
  ///
  /// 권한을 부여받은 적이 없거나, 사용자가 이전에 거부한 경우에만 요청한다.
  /// returns : 현재 권한이 있으면 true 없으면 false
  static Future<bool> checkAndRequestCamera() async {
    var status = await Permission.camera.status;
    if (status.isUndetermined || status.isDenied) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }
}
