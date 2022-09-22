import 'package:flutter/material.dart';

enum KeyPadType {
  telephone,
  calculator,
}

/// NumberPad widget
///
class NumPad extends StatelessWidget {
  final double? height;
  final ValueChanged<int> onPressed;
  final void Function()? onClear;
  final void Function()? onBackspace;

  /// Backspace widget, default(Icons.backspace_outlined)
  final Widget? backspaceWidget;
  final KeyPadType keypadType;

  const NumPad(
      {Key? key,
      required this.onPressed,
      this.height,
      this.onClear,
      this.onBackspace,
      this.backspaceWidget,
      this.keypadType = KeyPadType.calculator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (keypadType == KeyPadType.calculator) {
      children.add(Expanded(child: _buildRow('7', '8', '9')));
      children.add(Expanded(child: _buildRow('4', '5', '6')));
      children.add(Expanded(child: _buildRow('1', '2', '3')));
    } else {
      children.add(Expanded(child: _buildRow('1', '2', '3')));
      children.add(Expanded(child: _buildRow('4', '5', '6')));
      children.add(Expanded(child: _buildRow('7', '8', '9')));
    }
    children.add(Expanded(child: _buildRow('clear', '0', 'back')));

    return Container(
      height: height,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children,
      ),
    );
  }

  void _fireOnPressed(final String value) {
    final n = int.tryParse(value);
    if (n != null) {
      this.onPressed(n);
    } else {
      if (value == 'clear' && this.onClear != null) {
        this.onClear!();
      } else if (value == 'back' && this.onBackspace != null) {
        this.onBackspace!();
      }
    }
  }

  Widget _buildButton(final String label) {
    Widget child;
    final size = 25.0;

    if (label == 'clear') {
      child = Text('C',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: size));
    } else if (label == 'back') {
      child = backspaceWidget != null
          ? backspaceWidget!
          : Icon(
              Icons.backspace_outlined,
              size: size,
            );
    } else {
      child = Text(label,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: size));
    }
    return Expanded(
        child: Container(
            height: double.infinity,
            child: InkWell(
              child: Center(key: Key(label), child: child),
              onTap: () {
                _fireOnPressed(label);
              },
            )));
  }

  Widget _buildRow(final String c1, final String c2, final String c3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [_buildButton(c1), _buildButton(c2), _buildButton(c3)],
    );
  }
}
