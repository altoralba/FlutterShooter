import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:shooter/game.dart';

void main() {
  // Ensure Flame App runs on full screen
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  // Run the app
  runApp(GameWidget(game: Shooter()));
}
