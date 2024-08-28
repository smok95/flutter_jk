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

  group('근로소득세 계산', () {
    final ymd20240229 = DateTime(2024, 2, 29);
    final ymd20240301 = DateTime(2024, 3, 1);

    final calc24old = jk.IncomeTaxCalc(baseDate: ymd20240229);
    final calc24new = jk.IncomeTaxCalc(baseDate: ymd20240301);

    final income = 4000000;

    /// 월소득 400만원 기준
    /// 원천징수세율 100%, 부양가족 1명, 자녀 0명
    test('근로소득세 계산, 공제대상가족수1 (24.3.1일 이전)', () {
      int result = calc24old.calc(income, 1);
      expect(result, 210960);
    });

    test('근로소득세 계산, 공제대상가족수4 (24.3.1일 이전)', () {
      int result = calc24old.calc(income, 4);
      expect(result, 105840);
    });

    test('근로소득세 계산, 공제대상가족수1 (24.3.1일 이후)', () {
      int result = calc24new.calc(income, 1);
      expect(result, 195960);
    });

    test('근로소득세 계산, 공제대상가족수4 (24.3.1일 이후)', () {
      int result = calc24new.calc(income, 4);
      expect(result, 91670);
    });
  });

  group('4대 보험료 계산', () {
    final year2022 = DateTime(2022, 6, 1);
    final ymd20220701 = DateTime(2022, 7, 1);
    final ymd20230101 = DateTime(2023, 1, 1);
    final ymd20240301 = DateTime(2024, 3, 1);
    final calc2022 = jk.MajorInsuranceCalculator(baseDate: year2022);
    final calc20220701 = jk.MajorInsuranceCalculator(baseDate: ymd20220701);
    final calc20230101 = jk.MajorInsuranceCalculator(baseDate: ymd20230101);
    final calc20240301 = jk.MajorInsuranceCalculator(baseDate: ymd20240301);

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

    test('고용보험료 계산(22.7.1일 ~ )', () {
      int result =
          calc20220701.calcEmploymentInsurancePremium(income, onlyWorker: true);

      expect(result, 27000);
    });

    test('건강보험/장기요양보험 계산(22년)', () {
      final results =
          calc2022.calcHealthInsurancePremium(income, onlyWorker: true);
      expect(results[0], 104850);
      expect(results[1], 12860);
    });

    test('건강보험/장기요양보험 계산(23년)', () {
      final results =
          calc20230101.calcHealthInsurancePremium(income, onlyWorker: true);
      expect(results[0], 106350);
      expect(results[1], 13620);
    });

    test('국민연금 계산', () {
      final result = calc2022.calcNationalPension(income, onlyWorker: true);
      expect(result, 135000);
    });

    test('복권당첨금 세금 계산(23.1.1일 이전)', () {
      final ymd20221231 = DateTime(2022, 12, 31);
      final calc = jk.IncomeTaxCalc(baseDate: ymd20221231);
      int tax =
          calc.calcOtherIncomeTax(50000, type: jk.OtherIncomeType.lottery);
      expect(tax, 0);
      tax = calc.calcOtherIncomeTax(2000000, type: jk.OtherIncomeType.lottery);
      expect(tax, 400000);
    });

    test('복권당첨금 세금 계산(23.1.1일부터)', () {
      final ymd20230101 = DateTime(2023, 1, 1);
      final calc = jk.IncomeTaxCalc(baseDate: ymd20230101);
      int tax =
          calc.calcOtherIncomeTax(50000, type: jk.OtherIncomeType.lottery);
      expect(tax, 0);
      tax = calc.calcOtherIncomeTax(2000000, type: jk.OtherIncomeType.lottery);
      expect(tax, 0);
    });
  });
}
