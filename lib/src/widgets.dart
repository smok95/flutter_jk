import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
            onTap: this.onPressed,
            child: Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(5.0)),
                  icon,
                  Text(text),
                  Padding(padding: EdgeInsets.all(5.0)),
                ],
              ),
            )));
  }
}
