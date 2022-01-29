import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

/// Platform 정보
class PlatformInfo {
  /// 모바일OS 여부
  static bool isMobileOS = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// Web 여부
  static bool isWeb = kIsWeb;

  /// Android 여부
  static bool isAndroid = !isWeb && Platform.isAndroid;

  /// iOS 여부
  static bool isIOS = !isWeb && Platform.isIOS;
}
