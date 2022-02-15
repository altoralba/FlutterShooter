import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:shooter/player/player.dart';
import 'package:shooter/player/virtualjoystick.dart';

// Initializing the game
class Shooter extends FlameGame with PanDetector {
  late Player player;
  Offset? _pointerStartPosition;
  Offset? _pointerCurrentPosition;
  final double _joystickRadius = 60;

  // This method gets called by Flame before the game-loop begins
  // Asset loading and component adding should be done here
  @override
  Future<void> onLoad() async {
    await images.load('simpleSpace_tilesheet@2.png');

    final spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache('simpleSpace_tilesheet@2.png'),
      columns: 8,
      rows: 6,
    );

    player = Player(
      sprite: spriteSheet.getSpriteById(4),
      size: Vector2(64, 64),
      position: canvasSize / 2,
    );

    player.anchor = Anchor.center;

    add(player);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    virtualJoyStick(
      canvas,
      _pointerStartPosition,
      _pointerCurrentPosition,
      _joystickRadius,
    );

    super.render(canvas);
  }

  @override
  void onPanDown(DragDownInfo info) {
    debugPrint('Pan Down');
    super.onPanDown(info);
  }

  @override
  void onPanStart(DragStartInfo info) {
    debugPrint('Pan Start');
    _pointerStartPosition = info.raw.globalPosition;
    _pointerCurrentPosition = info.raw.globalPosition;
    super.onPanStart(info);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    debugPrint('Pan Update');
    _pointerCurrentPosition = info.raw.globalPosition;
    var delta = _pointerCurrentPosition! - _pointerStartPosition!;

    if (delta.distance > 10) {
      player.setMoveDirection(Vector2(delta.dx, delta.dy));
    } else {
      player.setMoveDirection(Vector2.zero());
    }

    super.onPanUpdate(info);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    debugPrint('Pan End');
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
    super.onPanEnd(info);
  }

  @override
  void onPanCancel() {
    debugPrint('Pan Cancel');
    _pointerStartPosition = null;
    _pointerCurrentPosition = null;
    player.setMoveDirection(Vector2.zero());
    super.onPanCancel();
  }
}
