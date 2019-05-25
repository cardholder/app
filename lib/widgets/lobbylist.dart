import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/ch_gamecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class LobbyList extends StatefulWidget {
  LobbyList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LobbyListState();
  }
}

class LobbyListState extends State<LobbyList> {
  var channel;
  List<Lobby> _lobbies = [];

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        "ws://ec2-18-185-18-129.eu-central-1.compute.amazonaws.com:8000/lobbylist/");
    fetchLobbies();
  }

  Future fetchLobbies() async {
    await channel.stream.listen((message) {
      var list = jsonDecode(message)['lobbies'] as List;
      setState(() {
        _lobbies = list.map((f) => Lobby.fromJson(f)).toList();
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardholderappbar(context),
      body: ListView.builder(
        itemCount: _lobbies.length,
        itemBuilder: (BuildContext context, int index) {
          // TODO: Key zur Identifikation nutzen
          return GameCard(_lobbies[index]);
        },
      ),
    );
  }
}
