import 'dart:convert';

import 'package:cardholder/types/Lobby.dart';
import 'package:cardholder/types/Player.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/ch_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class LobbyList extends StatelessWidget {
  final channel = IOWebSocketChannel.connect("ws://ec2-18-185-18-129.eu-central-1.compute.amazonaws.com:8000/lobbylist/");
  // I/flutter ( 9922): {"lobbies": [{"id": "hAsfh8n", "game": "Durak", "visibility": "private", "max_players": 8, "players": [{"id": 0, "name": "Player 1", "role": "leader"}]}]}

  LobbyList() {
    channel.stream.listen((message) {
      print(message);
    });
  }

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
