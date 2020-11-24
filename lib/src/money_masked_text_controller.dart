import 'package:flutter/material.dart';

/// 원래 소스 : https://pub.dev/packages/flutter_masked_text
class MoneyMaskedTextController extends TextEditingController {
  MoneyMaskedTextController(
      {double initialValue = 0.0,
      this.decimalSeparator = ',',
      this.thousandSeparator = '.',
      this.rightSymbol = '',
      this.leftSymbol = '',
      this.precision = 2,
      this.maximumValueLength = 12}) {
    _validateConfig();

    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });

    this.updateValue(initialValue);
  }

  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;
  final int maximumValueLength;

  Function afterChange = (String maskedValue, double rawValue) {};

  double _lastValue = 0.0;

  void updateValue(double value) {
    double valueToUse = value;

    if (value.toStringAsFixed(0).length > maximumValueLength) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }

    String masked = this._applyMask(valueToUse);

    if (rightSymbol.length > 0) {
      masked += rightSymbol;
    }

    if (leftSymbol.length > 0) {
      masked = leftSymbol + masked;
    }

    if (masked != this.text) {
      this.text = masked;

      var cursorPosition = super.text.length - this.rightSymbol.length;
      this.selection = new TextSelection.fromPosition(
          new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    List<String> parts =
        _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');

    return double.tryParse(parts.join()) ?? 0.0;
  }

  /// 숫자값 입력
  bool insertInt(int number) {
    /// 0~9만 허용
    if (0 > number || 9 < number) return false;

    final ch = number.toString();
    if (selection.start >= 0) {
      final length = text?.length ?? 0;

      /// 맨앞에 0을 추가하는 경우
      if (ch == '0' && selection.start == 0 && length > 0) return false;

      int newPosition = selection.start + ch.length;

      final thousandSepLength = thousandSeparator?.length ?? 0;
      text = text.replaceRange(selection.start, selection.end, ch);

      /// 숫자값 추가 후 thousandSeparator가 추가된 경우
      /// thousandSeparator길이만큼 position을 변경해준다.
      if (text.length > length + thousandSepLength)
        newPosition += thousandSepLength;

      selection = TextSelection(
        baseOffset: newPosition,
        extentOffset: newPosition,
      );
    } else {
      text += ch;
    }

    return true;
  }

  void removeNumber() {
    print('removeNumber ${selection.start}');
    if (selection.start <= 0) return;

    int start = selection.start - 1;
    final thousandSepLen = thousandSeparator?.length ?? 0;

    /// 현재 cursor 오른쪽 글자수
    final rightLength = text.substring(selection.start).length;

    /// 1000단위 구분자가 설정되어 있으면
    if (thousandSepLen > 0) {
      final leftString = text.substring(0, selection.start);

      /// 1000단위 구분자까지 삭제처리
      if (leftString.endsWith(thousandSeparator)) {
        start -= thousandSepLen;
      }
    }

    text = text.replaceRange(start, selection.start, '');

    start = text.length - rightLength;
    if (start < 0) start = 0;
    selection = TextSelection(baseOffset: start, extentOffset: start);
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(this.rightSymbol).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("rightSymbol must not have numbers.");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = new RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    return textRepresentation.reversed.join('');
  }
}
