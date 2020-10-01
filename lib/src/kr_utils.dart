class KrUtils {
  /// 숫자를 만원단위 문자열로 변환한다.
  ///
  /// 변환할 금액을 [value]에 입력하면 만원 단위로 변환 값이
  /// 리턴됩니다.
  ///
  /// ```dart
  /// final result = KrUtils.numberToManwon(195000000);
  /// print('결과=$result');
  /// // 결과=1억9500만원
  /// ```
  static numberToManwon(final int value) {
    int won = 0; // 원
    int manWon = 0; // 만원
    int eogWon = 0; // 억원
    int joWon = 0; // 조원
    int kyoungWon = 0; // 경원

    String result = '';
    manWon = value ~/ 10000; // 만
    won = value.remainder(10000); // 원

    /// 1만원 이상이면 억단위도 계산
    if (manWon > 0) {
      eogWon = manWon ~/ 10000;

      /// 1억원 이상이면 조단위도 계산
      if (eogWon > 0) {
        manWon = manWon.remainder(10000);
        joWon = eogWon ~/ 10000;

        /// 1조원 이상이면 경단위도 계산
        if (joWon > 0) {
          eogWon = eogWon.remainder(10000);
          kyoungWon = joWon ~/ 10000;

          if (kyoungWon > 0) {
            joWon = joWon.remainder(10000);
          }
        }
      }
    }

    if (kyoungWon > 0) result += '$kyoungWon경';
    if (joWon > 0) result += '$joWon조';
    if (eogWon > 0) result += '$eogWon억';
    if (manWon > 0) result += '$manWon만';
    if (won > 0) result += '$won';
    if (result.length == 0) result = '0';
    result += '원';
    return result;
  }
}
