import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final symbols = {
  'd': '♦',
  'c': '♣',
  's': '♠',
  'h': '♥',
};

class PlayingCard extends StatelessWidget {
  final int id;
  final String value;
  final String symbol;
  final bool draggable;

  PlayingCard(
      {this.id = 0,
      this.value = 'J',
      this.symbol = 'h',
      this.draggable = true});

  factory PlayingCard.undraggable(PlayingCard playingCard) {
    return PlayingCard(
      id: playingCard.id,
      value: playingCard.value,
      symbol: playingCard.symbol,
      draggable: false,
    );
  }

  factory PlayingCard.fromJson(Map<String, dynamic> json) {
    return PlayingCard(
      id: json['id'] as int,
      value: json['value'] as String,
      symbol: json['symbol'] as String,
      draggable: true,
    );
  }

  Map<String, dynamic> toJson() =>
    <String, dynamic>{
      'id': this.id,
      'value': this.value,
      'symbol': this.symbol
    };

  @override
  Widget build(BuildContext context) {
    Widget layout;

    if (id != null) {
      layout = Stack(
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
      );
    } else {
      layout = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(symbols['h']),
              Text(symbols['c']),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(symbols['s']),
              Text(symbols['d']),
            ],
          )
        ],
      );
    }

    Widget card = Container(
      height: 135,
      width: 90,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: layout,
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
