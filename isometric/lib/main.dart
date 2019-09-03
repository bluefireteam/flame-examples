import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import './game.dart';

void main() async {
  final screenSize = await Flame.util.initialDimensions();
  runApp(IsoGame(screenSize).widget);
}
