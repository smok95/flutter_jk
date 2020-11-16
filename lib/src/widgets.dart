import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

export 'num_stepper.dart';

/// 모든 모서리가 둥글게 처리된 BoxDecoration
class RoundBoxDecoration extends BoxDecoration {
  RoundBoxDecoration({
    Color color,
    DecorationImage image,
    BoxBorder border,
    double radius = 10.0,
    List<BoxShadow> boxShadow,
    Gradient gradient,
    BlendMode backgroundBlendMode,
  }) : super(
            color: color,
            image: image,
            border: border,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            boxShadow: boxShadow,
            gradient: gradient,
            backgroundBlendMode: backgroundBlendMode,
            shape: BoxShape.rectangle);
}

/// 상단에 아이콘 하단에 텍스트가 표시되는 IconButton
///
/// jkqrcode/my_icon_button.dart 에서 가져옴.
/// 추후 jkqrcode도 여기걸로 변경할 것!
class IconTextButton extends StatelessWidget {
  IconTextButton(this.icon, this.text, {Key key, this.onPressed})
      : super(key: key);

  final String text;

  /// The icon to display inside the button.
  ///
  /// The [Icon.size] and [Icon.color] of the icon is configured automatically
  /// based on the [iconSize] and [color] properties of _this_ widget using an
  /// [IconTheme] and therefore should not be explicitly given in the icon
  /// widget.
  ///
  /// This property must not be null.
  ///
  /// See [Icon], [ImageIcon].
  final Widget icon;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback onPressed;

  /// Whether the button is enabled or disabled.
  ///
  /// Buttons are disabled by default. To enable a button, set its [onPressed]
  /// properties to a non-null value.
  bool get enabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Color iconColor;
    Color textColor;
    if (onPressed == null) {
      textColor = iconColor = theme.disabledColor;
    }

    return Expanded(
        child: InkWell(
            onTap: this.onPressed,
            child: Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(5.0)),
                  IconTheme.merge(
                    data: IconThemeData(
                      //size: iconSize,
                      color: iconColor,
                    ),
                    child: icon,
                  ),
                  Text(
                    text,
                    style: TextStyle(color: textColor),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                ],
              ),
            )));
  }
}

/// 양수/음수 입력 버튼바
///
/// 계산기에서 금액 단위별로 빠르게 입력할 수 있도록 구현한 위젯
///
/// 모양은 아래와 같다.
/// ---------------------------------
/// +/-  +1000만 +100만 +10만 +1만
/// ---------------------------------
class NumberButtonBar extends StatefulWidget {
  final Color borderColor;

  /// 각각의 숫자버튼 뒤에 붙일 문자열
  final String suffix;

  final EdgeInsetsGeometry padding;

  /// 버튼 클릭 이벤트
  final ValueChanged<num> onPressed;

  /// 화면에 표시할 입력 숫자 리스트
  final List<num> numbers;

  NumberButtonBar(this.numbers,
      {Key key,
      this.borderColor = const Color(0xFFEEEEEE),
      this.suffix,
      this.onPressed,
      this.padding = const EdgeInsets.only(top: 5)})
      : assert(numbers != null && numbers.length > 0),
        super(key: key);

  @override
  _NumberButtonBarState createState() => _NumberButtonBarState();
}

class _NumberButtonBarState extends State<NumberButtonBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>();

    // +/- 버튼
    children.add(
      IconButton(
          icon: Icon(
            Icons.exposure,
            color: Colors.grey[700],
          ),
          onPressed: () {
            setState(() {
              _plusMode = !_plusMode;
            });
          }),
    );

    children.addAll(widget.numbers
        .map((e) => _buildEasyMoneyButton(_plusMode ? e : -e))
        .toList());

    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: widget.borderColor, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }

  Widget _buildEasyMoneyButton(int unit) {
    final absValue = unit.abs();
    final text = '${absValue}${widget.suffix}';
    final iconData = unit < 0 ? Icons.remove : Icons.add;
    const radius = const Radius.circular(5.0);
    final size = 15.0;
    return InkWell(
      borderRadius: BorderRadius.all(radius),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        child: Row(
          children: [
            Icon(iconData, size: size),
            Text(text, style: TextStyle(fontSize: size))
          ],
        ),
      ),
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed(unit);
        }
      },
    );
  }

  /// +/- 모드
  bool _plusMode = true;
}
