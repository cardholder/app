import 'package:cardholder/types/Lobby.dart';
import 'package:cardholder/types/Player.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/ch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LobbyList extends StatelessWidget {
  final List<Lobby> _lobbies = [
    Lobby('a', 'Skat', 'private', 6, [Player(1, 'name', 'role')])
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardholderappbar(context),
      body: ListView.builder(
        itemCount: _lobbies.length,
        itemBuilder: (BuildContext context, int index) {
          return GameCard(_lobbies[index]);
        },
      ),
    );
  }
}
