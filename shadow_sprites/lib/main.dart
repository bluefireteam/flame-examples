import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

void main() async {
  final size = await Flame.util.initialDimensions();

  runApp(ShadowSpriteGame(size).widget);
}

class ShadowSprite extends Sprite {
  final _shadowPaint = Paint()
      ..colorFilter = ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.srcATop);

  ShadowSprite(
    String fileName, {
    double x = 0.0,
    double y = 0.0,
    double width,
    double height,
  }): super(fileName, x: x, y: y, width: width, height: height);

  @override
  void renderRect(Canvas canvas, Rect rect, [Paint overridePaint]) {

    super.renderRect(canvas, rect.translate(10, 10), _shadowPaint);
    super.renderRect(canvas, rect, overridePaint);
  }
}

class ShadowSpriteGame extends Game {

  final _backgroundPaint = Paint()..color = const Color(0xFF38607c);

  final Size _screenSize;

  Sprite _player;
  Sprite _enemy;
  Sprite _ground;

  ShadowSpriteGame(this._screenSize) {
    _player = ShadowSprite("sprites.png", width: 48, height: 48);
    _enemy = ShadowSprite("sprites.png", x: 48, y: 32, width: 32, height: 16);
    _ground = ShadowSprite("sprites.png", y: 48, width: 80, height: 32);
  }

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, _screenSize.width, _screenSize.height), _backgroundPaint);

    _enemy.renderRect(canvas, Rect.fromLTWH(250, 200, 100, 50));
    _player.renderRect(canvas, Rect.fromLTWH(100, 100, 150, 150));
    _ground.renderRect(canvas, Rect.fromLTWH(100, 250, 250, 100));
  }
}
