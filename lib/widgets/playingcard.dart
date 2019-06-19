import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlayingCard extends StatelessWidget {
  final bool draggable;

  PlayingCard(this.draggable);

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      height: 150,
      width: 90,
      child: Card(
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
      childWhenDragging: Container(height: 150, width: 90, child: Text('Stack')),
      data: this,
    );
  }
}
