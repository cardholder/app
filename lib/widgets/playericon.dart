import 'package:cardholder/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlayerIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlayerIconState();
  }
}

class PlayerIconState extends State<PlayerIcon> {
  List<PlayingCard> cards = [
    PlayingCard(
      id: null,
      draggable: false,
    ),
    PlayingCard(
      id: null,
      draggable: false,
    ),
    PlayingCard(
      id: null,
      draggable: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Transform.scale(
          scale: 0.6,
          child: Stack(
            children: cards
                .map((f) =>
                    Transform.rotate(angle: cards.indexOf(f) * 0.15, child: f))
                .toList(),
          ),
        ),
        Text('Username', style: TextStyle(fontSize: 15, backgroundColor: Colors.greenAccent)),
      ],
    );
  }
}
