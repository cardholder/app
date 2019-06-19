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
  ];
  List<PlayingCard> pile = List();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Player'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  PlayingCard(),
                  PlayingCard(),
                  PlayingCard(),
                  PlayingCard(),
                ],
              ),
              DragTarget(
                builder:
                    (context, List<PlayingCard> candidateData, rejectedData) {
                  return pile.length == 0 ? Container(width: 90, height: 150) : Stack(children: pile);
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  pile.add(data);
                  hand.remove(data);
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: hand,
          )
        ],
      ),
    );
  }
}
