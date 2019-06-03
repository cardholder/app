import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/widgets/lobby.dart' as Route;
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final Lobby _lobby;

  GameCard(this._lobby);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 15, top: 15, right: 15),
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
                ),
                Text(
                  'Spieler ${_lobby.players.length.toString()} / ${_lobby.maxPlayers}',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.body2,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Route.Lobby(_lobby),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
