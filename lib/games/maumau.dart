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

  List<PlayingCard> hand = [PlayingCard(true), PlayingCard(true), PlayingCard(true),];

  @override
  Widget build(BuildContext context) {
    bool accepted = false;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 150,
            width: 90,
            child: DragTarget(
              builder: (context, List<PlayingCard> candidateData, rejectedData) {
                return accepted ? PlayingCard(true) : Container(child: Text('Target'),);
              },
              onWillAccept: (data) {
                print('Will Accept');
                return true;
              },
              onAccept: (data) {
                print('On Accept');
                accepted = true;
              },
            ),
          ),
          Row(
            children: hand,
          )
        ],
      ),
    );
  }
}
