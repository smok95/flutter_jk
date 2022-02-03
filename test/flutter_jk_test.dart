import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_jk/flutter_jk.dart' as jk;

void main() {
  group('GetX Messages test', () {
    test('언어별 리소스 개수 일치하는지 확인', () {
      final msgs = jk.Translations();
      final len = msgs.keys.entries.first.value.length;
      for (var key in msgs.keys.keys) {
        expect(msgs.keys[key]!.length, len, reason: '언어별로 모든 메시지의 개수는 동일해야함.');
      }
    });
  });

  group('4대 보험료 계산', () {
    final year2022 = DateTime(2022, 6, 1);
    final calc2022 = jk.MajorInsuranceCalculator(baseDate: year2022);

    /// 월소득 300만원 기준
    /// 고용보험료 24000원
    /// 건강보험 104850원
    /// 장기요향보험 12860원
    /// 국민연금 135000원
    final income = 3000000;

    test('고용보험료 계산', () {
      int result =
          calc2022.calcEmploymentInsurancePremium(income, onlyWorker: true);

      expect(24000, result);
    });

    test('건강보험/장기요양보험 계산', () {
      final results =
          calc2022.calcHealthInsurancePremium(income, onlyWorker: true);
      expect(104850, results[0]);
      expect(12860, results[1]);
    });

    test('국민연금 계산', () {
      final result = calc2022.calcNationalPension(income, onlyWorker: true);
      expect(135000, result);
    });
  });
}
