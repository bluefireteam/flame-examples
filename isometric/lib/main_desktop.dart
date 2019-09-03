import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/flame.dart';

import 'game.dart';
import 'game_wrapper.dart';

void main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  final screenSize = await Flame.util.initialDimensions();
  final game = IsoGame(screenSize);

  runApp(GameWrapper(
      child: game.widget,
      onMoveLeft: () {
        game.movePlayerLeft();
      },
      onMoveRight: () {
        game.movePlayerRight();
      },
      onMoveUp: () {
        game.movePlayerUp();
      },
      onMoveDown: () {
        game.movePlayerDown();
      }));
}
