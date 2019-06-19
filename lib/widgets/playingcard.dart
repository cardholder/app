import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final symbols = {
  'd': '♦',
  'c': '♣',
  's': '♠',
  'h': '♥',
};

class PlayingCard extends StatelessWidget {
  final int id = 1;
  final String value = 'Q';
  final String symbol = 'd';
  final bool draggable = true;

  PlayingCard();

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      height: 150,
      width: 90,
      //transform: Matrix4.rotationZ(0.1),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 3,
              child: Text(
                value,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Positioned(
              top: 25,
              left: 3,
              child: Text(
                symbols[symbol],
                style: TextStyle(fontSize: 13),
              ),
            ),
            Center(
              child: Text(symbols[symbol]),
            ),
            Positioned(
              bottom: 7,
              right: -14,
              child: Container(
                transform: Matrix4.rotationZ(3.14159),
                child: Text(
                  symbols[symbol],
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              right: -13,
              child: Container(
                transform: Matrix4.rotationZ(3.14159),
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (!draggable) return card;

    return Draggable(
      feedback: card,
      child: card,
      childWhenDragging: Container(),
      data: this,
    );
  }
}
