import 'package:cardholder/types/player.dart';
import 'package:cardholder/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlayerIcon extends StatefulWidget {
  final Player _player;
  final bool _current;

  PlayerIcon(this._player, this._current);

  @override
  State<StatefulWidget> createState() {
    return PlayerIconState();
  }
}

class PlayerIconState extends State<PlayerIcon> {
  @override
  Widget build(BuildContext context) {
    List<PlayingCard> cards = [
      for (int i = 0; i < widget._player.remainingCards; i++)
        PlayingCard(id: null, draggable: false),
    ];

    Widget cardPile;

    if (widget._player.remainingCards == 0) {
      cardPile = Container(height: 135, width: 90);
    } else {
      cardPile = Transform.scale(
        scale: 0.6,
        child: Stack(
          children: cards
              .map((f) =>
                  Transform.rotate(angle: cards.indexOf(f) * 0.15, child: f))
              .toList(),
        ),
      );
    }

    var highlightColor;
    if (widget._current) highlightColor = Colors.greenAccent;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        cardPile,
        Text(widget._player.name,
            style:
                TextStyle(fontSize: 15, backgroundColor: highlightColor)),
      ],
    );
  }
}
