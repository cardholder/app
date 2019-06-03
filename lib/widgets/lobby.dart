import 'package:cardholder/types/player.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cardholder/types/lobby.dart' as Type;
import 'package:web_socket_channel/io.dart';

class Lobby extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LobbyState();
  }
}

class LobbyState extends State<Lobby> {
  var channel;
  Type.Lobby _lobby;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        "ws://ec2-18-185-18-129.eu-central-1.compute.amazonaws.com:8000/lobby/${_lobby.id}");
  }

  @override
  Widget build(BuildContext context) {
    _lobby = ModalRoute.of(context).settings.arguments;
    if (_lobby.players == null) _lobby.players = new List<Player>();

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
                  ..._lobby.players?.map(
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
