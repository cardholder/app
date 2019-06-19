import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        child: Center(
          child: Text('Card'),
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
