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
  List<PlayingCard> pile = [PlayingCard.undraggable(PlayingCard())];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.polymer),
                  Text('Name'),
                ],
              ),
            ],
          ),
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
                print('On Accept');
                pile.add(PlayingCard.undraggable(data));
                hand.remove(data);
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: <Widget>[
                DragTarget(
                  builder: (context, List<PlayingCard> candidateData, rejectedData) {
                    return Container(height: 135, child: Row(children: hand));
                  },
                  onWillAccept: (PlayingCard data) {
                    if (data.id == null) return true;
                    else return false;
                  },
                  onAccept: (PlayingCard data) {
                    setState(() {
                      hand.add(PlayingCard());
                    });
                  },
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).copyWith().size.width,
                  color: Colors.green,
                  child: Text('Playername'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
