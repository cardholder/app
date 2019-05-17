import 'package:cardholder/types/Lobby.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final Lobby _lobby;

  GameCard(this._lobby);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _lobby.game,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  'Spieler ${_lobby.players.length.toString()} / ${_lobby.maxPlayers}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.play_arrow,
                  size: 60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
