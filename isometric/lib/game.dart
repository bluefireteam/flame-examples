import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

class IsoGame extends Game {
  static const double SIZE = 100.0;

  final _whiteStroke = Paint()
    ..color = Color(0xffffffff)
    ..style = PaintingStyle.stroke;

  final _red = Paint()..color = Color(0xffff0000);
  final _blue = Paint()..color = Color(0xff0000ff);
  final _yellow = Paint()..color = Color(0xfff0ea3c);

  final _lightSquare = Sprite("tiles.png", width: 19, height: 19);
  final _darkSquare = Sprite("tiles.png", x: 19, width: 19, height: 19);

  final Size screenSize;

  Position playerPos = Position(0, 0);

  IsoGame(this.screenSize);

  final board = [
    [1, 0, 1, 0, 1, 0, 1, 0],
    [0, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1, 0],
    [0, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1, 0],
    [0, 1, 0, 1, 0, 1, 0, 1],
    [1, 0, 1, 0, 1, 0, 1, 0],
    [0, 1, 0, 1, 0, 1, 0, 1],
  ];

  @override
  void update(double dt) {}

  void movePlayerRight() {
    playerPos = playerPos.add(Position(1, 0));
  }

  void movePlayerLeft() {
    playerPos = playerPos.add(Position(-1, 0));
  }

  void movePlayerUp() {
    playerPos = playerPos.add(Position(0, -1));
  }

  void movePlayerDown() {
    playerPos = playerPos.add(Position(0, 1));
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    // making the 0, 0 on the middle of the screen
    // adding the board.length to give a sense of depth, but this is probably an ugly workaround, there may be a better way to calculate this
    canvas.translate(screenSize.width / 2,
        screenSize.height / 2 - (board.length * SIZE / 2));

    for (var y = 0; y < board.length; y++) {
      for (var x = 0; x < board[y].length; x++) {
        drawTile(canvas, Position(x.toDouble(), y.toDouble()), board[y][x]);
      }
    }

    final playerProjectedPosition =
        cartesianToIso(playerPos.clone().times(SIZE));

    final rect = Rect.fromLTWH(
        playerProjectedPosition.x, playerProjectedPosition.y - SIZE, SIZE, SIZE);
    canvas.drawOval(rect, _yellow);

    canvas.restore();
  }

  Position cartesianToIso(Position p) {
    final isoX = p.x - p.y;
    final isoY = (p.x + p.y) / 2;

    return Position(isoX, isoY);
  }

  void drawTile(Canvas c, Position point, int value) {
    final projectedPosition = cartesianToIso(point.times(SIZE));

    c.save();
    c.translate(projectedPosition.x, projectedPosition.y);

    final coord = SIZE / 2 * -1;
    final rect =
        Rect.fromLTWH(coord, coord, SIZE * 2, SIZE);

    final sprite = value == 1 ? _lightSquare : _darkSquare;
    sprite.renderRect(c, rect);

    c.restore();
  }
}
