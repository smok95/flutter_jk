import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// Disable multi-touch
class SingleTouchDetector extends RawGestureDetector {
  SingleTouchDetector({
    Key key,
    Widget child,
    bool excludeFromSemantics = false,
    dynamic semantics,
  }) : super(
            key: key,
            child: child,
            gestures: {
              _OnlyOnePointerRecognizer: GestureRecognizerFactoryWithHandlers<
                  _OnlyOnePointerRecognizer>(
                () => _OnlyOnePointerRecognizer(),
                (_OnlyOnePointerRecognizer instance) {},
              )
            },
            behavior: HitTestBehavior.translucent,
            excludeFromSemantics: excludeFromSemantics,
            semantics: semantics);
}

class _OnlyOnePointerRecognizer extends OneSequenceGestureRecognizer {
  int _pointer = 0;

  @override
  void addPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
    GestureDisposition disposition;
    if (_pointer == 0) {
      _pointer = event.pointer;
      disposition = GestureDisposition.rejected;
    } else {
      disposition = GestureDisposition.accepted;
    }
    resolve(disposition);
  }

  @override
  String get debugDescription => 'OnlyOnePointerRecognizer';

  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _pointer) {
      _pointer = 0;
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
