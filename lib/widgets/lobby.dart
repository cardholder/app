import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:flutter/material.dart';

class Lobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardholderappbar(context),
      body: Column(
        children: <Widget>[
          Card(
            child: Text('Lobbylink'),
          ),
          Row(
            children: <Widget>[
              Card(
                child: Text('Kartenspiel'),
              ),
              Card(
                child: Text('Sichtbarkeit'),
              ),
            ],
          ),
          Card(
            child: Text('Spieler'),
          ),
        ],
      ),
    );
  }
}
