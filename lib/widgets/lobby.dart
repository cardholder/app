import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cardholder/types/lobby.dart' as Type;

class Lobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Type.Lobby _lobby = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: cardholderappbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Lobbylink'),
                  Text(
                    'http://cardholder.com/${_lobby?.id}',
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Kartenspiel'),
                      Text(
                        _lobby?.game,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(right: 15, bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Sichtbarkeit'),
                      Text(
                        _lobby?.visibility,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Spieler'),
                  ..._lobby.players.map(
                    (player) => Text(player?.name,
                        style: Theme.of(context).textTheme.body2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
