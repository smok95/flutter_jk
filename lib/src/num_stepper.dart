import 'package:flutter/material.dart';

/// Setpper 버튼 위치
enum StepperAlignment {
  /// 좌측
  start,

  /// 우측
  end,

  /// 양쪽
  between,
}

class NumStepper extends StatefulWidget {
  NumStepper(
      {Key key,
      this.value = 0,
      this.step = 1,
      this.alignment = StepperAlignment.end,
      this.minimum,
      this.maximum,
      this.textStyle,
      this.width,
      this.onChanged,
      this.rightSymbol = ''})
      : super(key: key);

  @override
  _NumStepperState createState() => _NumStepperState();

  /// 최소값
  final num minimum;

  /// 최대값
  final num maximum;

  /// 단위
  final num step;

  /// 값
  num value;

  /// [value] 오른쪽에 표시할 문자열
  final String rightSymbol;
  final TextStyle textStyle;
  final double width;
  final ValueChanged<int> onChanged;
  final StepperAlignment alignment;
}

class _NumStepperState extends State<NumStepper> {
  @override
  void initState() {
    super.initState();

    if (widget.minimum != null && widget.minimum > widget.value) {
      widget.value = widget.minimum;
    } else if (widget.maximum != null && widget.maximum < widget.value) {
      widget.value = widget.maximum;
    }
  }

  Widget _iconButton(IconData data, void Function() onPressed) {
    final decoration = null;
    /*BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.all(Radius.circular(10.0)));*/

    return Container(
      decoration: decoration,
      margin: EdgeInsets.all(1.0),
      child: IconButton(
          icon: Icon(data),
          padding: EdgeInsets.all(5),
          splashRadius: widget.textStyle.fontSize * 1.3,
          iconSize: widget.textStyle.fontSize * 1.3,
          constraints: BoxConstraints.tightForFinite(),
          focusColor: Colors.transparent,
          highlightColor: Colors.amber,
          onPressed: onPressed),
    );
  }

  void _decrease() {
    setState(() {
      widget.value -= widget.step;

      if (widget.minimum != null && widget.minimum > widget.value) {
        widget.value = widget.minimum;
      }

      _fireOnChanged(widget.value);
    });
  }

  void _increase() {
    setState(() {
      widget.value += widget.step;

      if (widget.maximum != null && widget.maximum < widget.value) {
        widget.value = widget.maximum;
      }

      _fireOnChanged(widget.value);
    });
  }

  void _fireOnChanged(num value) {
    if (widget.onChanged != null) widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.textStyle ?? TextStyle(fontSize: 24.0);

    List<Widget> children = List<Widget>();

    final plusButton = _iconButton(Icons.add, _increase);
    final minusButton = _iconButton(Icons.remove, _decrease);
    final text = Expanded(
        child: Text(
      '${widget.value}${widget.rightSymbol}',
      style: style,
      textAlign: TextAlign.right,
    ));

    switch (widget.alignment) {
      case StepperAlignment.start:
        children..add(minusButton)..add(plusButton)..add(text);
        break;
      case StepperAlignment.end:
        children..add(text)..add(minusButton)..add(plusButton);
        break;
      default:
        children..add(minusButton)..add(text)..add(plusButton);
    }

    return SizedBox(
      width: widget.width,
      child: Row(children: children),
    );
  }
}
