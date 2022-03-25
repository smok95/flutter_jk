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
    final ymd20220701 = DateTime(2022, 7, 1);
    final calc2022 = jk.MajorInsuranceCalculator(baseDate: year2022);
    final calc20220701 = jk.MajorInsuranceCalculator(baseDate: ymd20220701);

    /// 월소득 300만원 기준
    /// 고용보험료 24000원
    /// 건강보험 104850원
    /// 장기요향보험 12860원
    /// 국민연금 135000원
    final income = 3000000;

    test('고용보험료 계산(22.7.1일 이전)', () {
      int result =
          calc2022.calcEmploymentInsurancePremium(income, onlyWorker: true);

      expect(result, 24000);
    });

    test('고용보험료 계산(22.7.1일 부터)', () {
      int result =
          calc20220701.calcEmploymentInsurancePremium(income, onlyWorker: true);

      expect(result, 27000);
    });

    test('건강보험/장기요양보험 계산', () {
      final results =
          calc2022.calcHealthInsurancePremium(income, onlyWorker: true);
      expect(results[0], 104850);
      expect(results[1], 12860);
    });

    test('국민연금 계산', () {
      final result = calc2022.calcNationalPension(income, onlyWorker: true);
      expect(result, 135000);
    });
  });
}
