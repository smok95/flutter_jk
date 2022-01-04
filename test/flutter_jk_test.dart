import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_jk/flutter_jk.dart' as jk;

void main() {
  test('GetXMessages test', () {
    final msgs = jk.Translations();
    final len = msgs.keys.entries.first.value.length;
    for (var key in msgs.keys.keys) {
      expect(msgs.keys[key]!.length, len, reason: '언어별로 모든 메시지의 개수는 동일해야함.');
    }
  });
}
