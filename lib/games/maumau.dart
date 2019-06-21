import 'package:cardholder/widgets/playericon.dart';
import 'package:cardholder/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MauMau extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MauMauState();
  }
}

class MauMauState extends State<MauMau> {
  List<PlayingCard> hand = [
    PlayingCard(),
    PlayingCard(),
    PlayingCard(),
    PlayingCard(),
    PlayingCard(),
    PlayingCard(),
  ];
  List<PlayingCard> pile = [PlayingCard.undraggable(PlayingCard())];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PlayerIcon(),
            PlayerIcon(),
            PlayerIcon(),
            PlayerIcon(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              children: <Widget>[
                PlayingCard(id: null),
                PlayingCard(id: null),
                PlayingCard(id: null),
                PlayingCard(id: null),
              ],
            ),
            DragTarget(
              builder:
                  (context, List<PlayingCard> candidateData, rejectedData) {
                return Stack(children: pile);
              },
              onWillAccept: (data) {
                return hand.contains(data);
              },
              onAccept: (PlayingCard data) {
                pile.add(PlayingCard.undraggable(data));
                hand.remove(data);
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          children: <Widget>[
            DragTarget(
              builder:
                  (context, List<PlayingCard> candidateData, rejectedData) {
                return Container(
                  height: 135,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: hand
                        .map((f) => Positioned(
                            left: hand.indexOf(f) *
                                (MediaQuery.of(context).size.width /
                                    hand.length),
                            child: f))
                        .toList(),
                  ),
                );
              },
              onWillAccept: (data) {
                return true;
              },
              onAccept: (data) {
                setState(() {
                 hand.add(PlayingCard()); 
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
