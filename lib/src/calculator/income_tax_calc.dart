import 'income_tax_table2020.dart';

enum OtherIncomeType {
  /// 일반적인 기타소득
  normal,

  /// 복권 당첨금과 승마투표권 등의 구매자가 받는 환급금
  lottery,

  /// 연금계좌에서 발생하는 연금외 기타소득
  /// 세액공제를 받은 연금납입액
  /// 연금게좌의 운용실적에 따라 증가된 금액 등
  pensionAccount,
}

/// IncomeTaxCalc
/// 2020-11-01 IncometaxTable에서 IncomeTaxCalc로 이름 변경
/// 2021-04-29 각 메서드에서 별도로 기준년도 설정하지 않고 baseDate사용하도록 변경
class IncomeTaxCalc {
  /// 계산기준일
  final DateTime baseDate;

  IncomeTaxCalc({DateTime? baseDate})
      : this.baseDate = baseDate ?? DateTime.now() {
    final ymd20210218 = DateTime(2021, 2, 18);

    if (this.baseDate.isBefore(ymd20210218)) {
      // 2021.02.17일 이후부터 2021년 기준적용됨.
      _calculator = _Calc2020();
    } else {
      _calculator = _Calc2021();
    }
  }

  /// 근로소득세 확인
  /// [income]에 월급여액(단위:원)을
  /// [dependents]에 공제대상가족수를 입력한다.
  /// 공제대상가족수는 본인포함 부양가족+20세 이하 자녀수
  /// [taxRate] 세율 80%(0.8), 100%(1.0). 120%(1.2) 중 입력
  /// Returns 입력값이 비정싱인 경우 -1이 리턴됨.
  int calc(int income, int dependents, {double taxRate = 1.0}) {
    int tax = _calculator.calc(income, dependents);

    // 선택세율 적용
    tax = (tax.toDouble() * taxRate).toInt();

    // 원단위 절사
    return (tax ~/ 10) * 10;
  }

  /// 지방소득세 계산
  /// 소득세값을 [incomeTax]에 설정한다.
  int calcLocalIncomeTax(int incomeTax) {
    final localIncomeTax = incomeTax ~/ 10;
    // 원단위 절사
    return (localIncomeTax ~/ 10) * 10;
  }

  /// 주민세 계산
  /// 소득세값[incomeTax]을 입력한다.
  int calcResidentTax(int incomeTax) {
    final residentTax = incomeTax ~/ 10;
    // 원단위 절사
    return (residentTax ~/ 10) * 10;
  }

  /// 기타소득세 계산
  /// 국세청 페이지
  /// [https://www.nts.go.kr/support/support_03.asp?cinfo_key=MINF4920100726151013]
  /// 기타소득액[income]을 입력한다.
  /// 기타소득금액= 총수입금액 - 필요경비
  int calcOtherIncomeTax(int income,
      {OtherIncomeType type = OtherIncomeType.normal}) {
    // 과세최저한 : 건별 5만원 이하는 과세안함.
    // 상세정보 : https://www.nts.go.kr/support/support_view.asp?cinfo_key=MINF4920100726151013&cbsinfo_key=MBS20200527135739127&menu_a=30&menu_b=200&menu_c=3000
    if (income <= 50000) return 0;

    // 원천징수세율
    // https://www.nts.go.kr/support/support_view.asp?cinfo_key=MINF4920100726151013&cbsinfo_key=MBS20161116155830180&menu_a=30&menu_b=200&menu_c=3000
    // !! 연금계좌의 기타소득 15% 계산처리는 추후에 해보자...

    var tax = 0;
    switch (type) {
      case OtherIncomeType.lottery:
        final ymd20040101 = DateTime(2004, 1, 1);
        final ymd20070101 = DateTime(2007, 1, 1);

        /// 세금 30% 적용되는 시작 당첨금
        var startPrizeTax30 = 0;

        if (baseDate.isBefore(ymd20040101)) {
          // 04.1.1일 이전
          // 복권 20%
          startPrizeTax30 = income;
        } else if (baseDate.isBefore(ymd20070101)) {
          // 07.1.1일 이전
          // 복권 20% (5억 초과분은 30% 적용)
          startPrizeTax30 = 500000000;
        } else {
          // 07.1.1일 부터
          // 복권 20% (3억 초과분은 30% 적용)
          startPrizeTax30 = 300000000;
        }

        if (income > startPrizeTax30) {
          tax += ((income - startPrizeTax30) * 0.3).toInt();
          income = startPrizeTax30;
        }

        tax += (income * 0.2).toInt();
        break;
      case OtherIncomeType.pensionAccount:
        // 연금계좌 기타소득 15%
        tax = (income * 0.15).toInt();
        break;
      default:
        // 일반 20%
        tax = (income * 0.2).toInt();
        break;
    }

    // 원단위 절사
    return (tax ~/ 10) * 10;
  }

  /// 도움말
  String helpText(String key) {
    return _calculator.helpText(key);
  }

  late IncomeTaxCalculator _calculator;
}

abstract class IncomeTaxCalculator {
  int calc(final int income, final int dependents);
  String helpText(String key);
}

class _Calc2020 extends IncomeTaxCalculator {
  @override
  int calc(final int income, final int dependents) {
    // 1000원 단위
    int salary = income ~/ 1000;
    int row = 0;
    int col = dependents - 1;
    int additionalTax = 0;

    late List<List<int>> table;
    if (salary < 1000) {
      // 100만원 미만
      return 0;
    } else if (1000 <= salary && salary < 1500) {
      // 100만원 이상 150만원 미만
      row = (salary - 1000) ~/ 5;
      table = taxTable100to150;
    } else if (1500 <= salary && salary < 3000) {
      // 150만원 이상 300만원 미만
      row = (salary - 1500) ~/ 10;
      table = taxTable150to300;
    } else if (3000 <= salary) {
      // 300만원 이상
      row = (salary - 3000) ~/ 20;
      table = taxTable300to1000;

      // 1000만원을 초과하는 경우에는 테이블 마지막 세금표 사용
      if (row >= table.length) row = table.length - 1;

      if (salary <= 10000) {
        // 300만원 이상 1000만원 이하
      } else if (10000 < salary && salary <= 14000) {
        // 1000만원 초과 1400만원 이하
        salary -= 10000;
        additionalTax = (((salary.toDouble() * 0.98) * 0.35) * 1000).toInt();
      } else if (14000 < salary && salary <= 28000) {
        // 1400만원 초과 2800만원 이하
        salary -= 14000;
        additionalTax =
            1372000 + (((salary.toDouble() * 0.98) * 0.38) * 1000).toInt();
      } else if (28000 < salary && salary <= 30000) {
        // 2800만원 초과 3000만원 이하
        salary -= 28000;
        additionalTax =
            6585600 + (((salary.toDouble() * 0.98) * 0.4) * 1000).toInt();
      } else if (30000 < salary && salary <= 45000) {
        // 3000만원 초과 4500만원 이하
        salary -= 30000;
        additionalTax = 7385600 + ((salary.toDouble() * 0.4) * 1000).toInt();
      } else {
        // 4500만원 초과
        salary -= 45000;
        additionalTax = 13385600 + ((salary.toDouble() * 0.42) * 1000).toInt();
      }
    }

    // 공제대상가족의 수가 11명을 초과하는 경우
    if (dependents > 11) {
      final taxOf11 = calc(income, 11);
      final tax = taxOf11 - (calc(income, 10) - taxOf11) * (dependents - 11);
      return tax < 0 ? 0 : tax;
    } else {
      return table[row][col] + additionalTax;
    }
  }

  @override
  String helpText(String key) {
    switch (key) {
      case 'income-tax':
        return '공제대상가족의 수(부양가족수 + 20세 이하 자녀수)에 따라, ' +
            '2020년 국세청 근로소득 간이세액표를 기준으로 공제됩니다.' +
            '\n단, 연간 소득이 100만원을 초과하는 자는 부양가족 및 20세 이하 자녀에서 제외됩니다.\n' +
            '또한 월급여가 106만원 미만인 경우에는 근로소득세가 없습니다.';
      case 'local-income-tax':
        return '근로소득세의 10%';
      default:
        return '';
    }
  }
}

class _Calc2021 extends IncomeTaxCalculator {
  @override
  int calc(final int income, final int dependents) {
    // 1000원 단위
    int salary = income ~/ 1000;
    int row = 0;
    int col = dependents - 1;
    int additionalTax = 0;

    late List<List<int>> table;
    if (salary < 1000) {
      // 100만원 미만
      return 0;
    } else if (1000 <= salary && salary < 1500) {
      // 100만원 이상 150만원 미만
      row = (salary - 1000) ~/ 5;
      table = taxTable100to150;
    } else if (1500 <= salary && salary < 3000) {
      // 150만원 이상 300만원 미만
      row = (salary - 1500) ~/ 10;
      table = taxTable150to300;
    } else if (3000 <= salary) {
      // 300만원 이상
      row = (salary - 3000) ~/ 20;
      table = taxTable300to1000;

      // 1000만원을 초과하는 경우에는 테이블 마지막 세금표 사용
      if (row >= table.length) row = table.length - 1;

      if (salary <= 10000) {
        // 300만원 이상 1000만원 이하
      } else if (10000 < salary && salary <= 14000) {
        // 1000만원 초과 1400만원 이하
        salary -= 10000;
        additionalTax = (((salary.toDouble() * 0.98) * 0.35) * 1000).toInt();
      } else if (14000 < salary && salary <= 28000) {
        // 1400만원 초과 2800만원 이하
        salary -= 14000;
        additionalTax =
            1372000 + (((salary.toDouble() * 0.98) * 0.38) * 1000).toInt();
      } else if (28000 < salary && salary <= 30000) {
        // 2800만원 초과 3000만원 이하
        salary -= 28000;
        additionalTax =
            6585600 + (((salary.toDouble() * 0.98) * 0.4) * 1000).toInt();
      } else if (30000 < salary && salary <= 45000) {
        // 3000만원 초과 4500만원 이하
        salary -= 30000;
        additionalTax = 7369600 + ((salary.toDouble() * 0.4) * 1000).toInt();
      } else if (45000 < salary && salary <= 87000) {
        // 4500만원 초과 8700만원 이하
        salary -= 45000;
        additionalTax = 13369600 + ((salary.toDouble() * 0.42) * 1000).toInt();
      } else {
        // 8700만원 초과
        salary -= 87000;
        additionalTax = 31009600 + ((salary.toDouble() * 0.45) * 1000).toInt();
      }
    }

    // 공제대상가족의 수가 11명을 초과하는 경우
    if (dependents > 11) {
      final taxOf11 = calc(income, 11);
      final tax = taxOf11 - (calc(income, 10) - taxOf11) * (dependents - 11);
      return tax < 0 ? 0 : tax;
    } else {
      return table[row][col] + additionalTax;
    }
  }

  @override
  String helpText(String key) {
    switch (key) {
      case 'income-tax':
        return '공제대상가족의 수(부양가족수 + 7세 이상 20세 이하 자녀수)에 따라, ' +
            '2021년 국세청 근로소득 간이세액표를 기준으로 공제됩니다.' +
            '\n단, 연간 소득이 100만원을 초과하는 자는 부양가족 및 7세 이상 20세 이하 자녀에서 제외됩니다.\n' +
            '또한 월급여가 106만원 미만인 경우에는 근로소득세가 없습니다.';
      case 'local-income-tax':
        return '근로소득세의 10%';
      default:
        return '';
    }
  }
}
