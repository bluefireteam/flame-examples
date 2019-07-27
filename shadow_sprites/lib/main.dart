import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

void main() async {
  final size = await Flame.util.initialDimensions();

  runApp(ShadowSpriteGame(size).widget);
}

class ShadowSpriteGame extends Game {

  final _backgroundPaint = Paint()..color = const Color(0xFF38607c);

  final Size _screenSize;

  Sprite _player;
  Sprite _enemy;
  Sprite _ground;

  ShadowSpriteGame(this._screenSize) {
    _player = Sprite("sprites.png", width: 48, height: 48);
    _enemy = Sprite("sprites.png", x: 48, y: 32, width: 32, height: 16);
    _ground = Sprite("sprites.png", y: 48, width: 80, height: 32);
  }

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, _screenSize.width, _screenSize.height), _backgroundPaint);

    _player.renderRect(canvas, Rect.fromLTWH(100, 100, 150, 150));
    _enemy.renderRect(canvas, Rect.fromLTWH(250, 200, 100, 50));
    _ground.renderRect(canvas, Rect.fromLTWH(100, 250, 250, 100));
  }
}
