import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/components/component.dart';

void main() async {
  final screenSize = await Flame.util.initialDimensions();
  final game = SimpleCameraGame(screenSize);
  runApp(game.widget);

  Flame.util.addGestureRecognizer(TapGestureRecognizer()
      ..onTapDown = (TapDownDetails evt) {
        if (evt.globalPosition.dx >= screenSize.width / 2) {
          game.player.moveRight();
        } else {
          game.player.moveLeft();
        }
      }
      ..onTapUp = (TapUpDetails evt) {
        game.player.stopMoving();
      }
  );
}

class Platform extends PositionComponent {
  static final _white = Paint()..color = Color(0xFFFFFFFF);

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    canvas.drawRect(toRect(), _white);
  }
}

class BackgroundObject extends PositionComponent {
  static final _color = Paint()..color = Color(0xFF333333);

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    canvas.drawRect(toRect(), _color);
  }
}

class Player extends PositionComponent {
  static final _blue = Paint()..color = Color(0xFF0000FF);
  static const double SPEED = 300;

  Player(this.gameRef);

  final SimpleCameraGame gameRef;

  int _direction = 0;

  void moveRight() {
    _direction = 1;
  }

  void moveLeft() {
    _direction = -1;
  }

  void stopMoving() {
    _direction = 0;
  }

  @override
  void update(double dt) {
    final step = _direction * SPEED * dt;
    x += step;
    gameRef.camera.x += step;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(toRect(), _blue);
  }
}

class SimpleCameraGame extends BaseGame {
  Player player;

  SimpleCameraGame(Size screenSize) {
    size = screenSize;
    add(
        Platform()
        ..x = 50
        ..y = screenSize.height - 120
        ..width = screenSize.width * 2
        ..height = 100
    );

    for (int i = 1; i < 6; i++) {
      add(
          BackgroundObject()
          ..x = 250.0 * i
          ..y = screenSize.height - 220
          ..width = 100
          ..height = 100
      );
    }

    add(
        player = Player(this)
        ..x = 100
        ..y = screenSize.height - 220
        ..width = 50
        ..height = 100
    );
  }
}
