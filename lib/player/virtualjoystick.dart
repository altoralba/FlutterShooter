import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

void virtualJoyStick(Canvas canvas, Offset? pointerStartPosition,
    Offset? pointerCurrentPosition, double joystickRadius) {
  if (pointerStartPosition != null) {
    canvas.drawCircle(
      pointerStartPosition,
      joystickRadius,
      Paint()..color = Colors.grey.withAlpha(100),
    );
  }

  if (pointerCurrentPosition != null) {
    var delta = pointerCurrentPosition - pointerStartPosition!;

    if (delta.distance > joystickRadius) {
      delta = pointerStartPosition +
          (Vector2(delta.dx, delta.dy).normalized() * joystickRadius)
              .toOffset();
    } else {
      delta = pointerCurrentPosition;
    }

    canvas.drawCircle(
      delta,
      20,
      Paint()..color = Colors.white.withAlpha(100),
    );
  }
}
