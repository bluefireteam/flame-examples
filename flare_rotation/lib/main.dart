import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flare_animation.dart';
import 'package:flame/components/flare_component.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        '/game': (BuildContext context) => GameWidget(),
        '/base-game': (BuildContext context) => BaseGameWidget(),
      }
    );
  }
}

class FlareGame extends Game {
  FlareAnimation _flareAnimation;

  FlareGame() {
    _start();
  }

  void _start() async {
    _flareAnimation = await FlareAnimation.load("assets/Bob_Minion.flr");

    _flareAnimation.updateAnimation("Stand");
    _flareAnimation
        ..width = 306
        ..height = 228;
  }

  @override
  void update(double dt) {
    if (_flareAnimation != null)
      _flareAnimation.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.save();

    if (_flareAnimation != null) {
      canvas.translate(200, 100);
      canvas.rotate(1.5);

      _flareAnimation.render(canvas, x: 0, y: 0);
    }

    canvas.restore();
  }
}


class FlareBaseGame extends BaseGame {
  bool debugMode() => true;

  FlareBaseGame() {
    final flareAnimation =
        FlareComponent("assets/Bob_Minion.flr", "Stand", 306, 228)
        ..x = 200
        ..y = 100
        ..angle = 1.5;

    add(flareAnimation);
  }
}

class GameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlareGame().widget;
  }
}

class BaseGameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlareBaseGame().widget;
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(height: 50),
          RaisedButton(
              child: Text('Game'),
              onPressed: () {
                Navigator.of(context).pushNamed('/game');
              }
          ),
          RaisedButton(
              child: Text('BaseGame'),
              onPressed: () {
                Navigator.of(context).pushNamed('/base-game');
              }
          ),
        ]
    );
  }
}

