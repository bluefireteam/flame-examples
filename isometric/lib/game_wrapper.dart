import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  final String label;
  final void Function() onTap;

  GameButton({this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
            width: 100,
            height: 100,
            child: Container(
                color: const Color(0xFFe5e5e5),
                child: Center(child: Text(label)))));
  }
}

class GameWrapper extends StatelessWidget {
  final Widget child;
  final void Function() onMoveLeft;
  final void Function() onMoveRight;
  final void Function() onMoveUp;
  final void Function() onMoveDown;

  GameWrapper(
      {this.child,
      this.onMoveLeft,
      this.onMoveRight,
      this.onMoveUp,
      this.onMoveDown});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                color: const Color(0xFF000000),
                child: Stack(children: [
                  child,
                  Positioned(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GameButton(
                              onTap: () {
                                onMoveLeft();
                              },
                              label: 'Left',
                            ),
                            GameButton(
                              onTap: () {
                                onMoveRight();
                              },
                              label: 'Right',
                            ),
                            GameButton(
                              onTap: () {
                                onMoveUp();
                              },
                              label: 'Up',
                            ),
                            GameButton(
                              onTap: () {
                                onMoveDown();
                              },
                              label: 'Down',
                            ),
                          ])),
                ]))));
  }
}
