import 'dart:convert';
import 'package:cardholder/singletons/userdata.dart';
import 'package:cardholder/types/player.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/ch_button.dart';
import 'package:cardholder/widgets/ch_playerentry.dart';
import 'package:cardholder/routes/game.dart';
import 'package:flutter/material.dart';
import 'package:cardholder/types/lobby.dart' as Type;
import 'package:flutter/services.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:web_socket_channel/io.dart';

class Lobby extends StatefulWidget {
  final Type.Lobby _lobby;

  Lobby(this._lobby);

  @override
  State<StatefulWidget> createState() {
    return LobbyState();
  }
}

class LobbyState extends State<Lobby> {
  var channel;
  Type.Lobby _lobby;
  int _myId;
  Player _leader;
  Map<String, String> usernameJson = {'name': userData.username};

  @override
  void initState() {
    super.initState();
    _lobby = widget._lobby;
    if (_lobby.players == null) _lobby.players = new List<Player>();
    _subscribeLobby();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  Future _subscribeLobby() async {
    channel = IOWebSocketChannel.connect(
        "ws://ec2-18-185-18-129.eu-central-1.compute.amazonaws.com:8000/lobby/${_lobby.id}/");
    channel.sink.add(jsonEncode(usernameJson));
    channel.stream.listen((message) {
      print(message); //TODO remove
      Map<String, dynamic> response = jsonDecode(message);
      if (response['your_id'] != null) {
        _myId = response['your_id'];
      } else if (response['players'] != null) {
        _setPlayers(response);
      } else if (response['lobby'] != null) {
        //TODO Lobbyinfos abrufen wenn join über Link
      } else if (response['message'] != null) {
        _updateStatus(response);
      }
    });
  }

  void _setPlayers(Map response) {
    List list = response['players'] as List;
    if (list.length > 0) {
      setState(() {
        _lobby.players = list.map((f) => Player.fromJson(f)).toList();
      });
      _leader =
          (_lobby.players.firstWhere((player) => player.role == 'leader'));
    }
  }

  void _updateStatus(Map response) {
    switch (response['message']) {
      case 'You got kicked!':
        Navigator.pop(context);
        break;
      case 'Lobby is full!':
        Navigator.pop(context);
        break;
      case 'Game is started':
        _startGame();
        break;
    }
  }

  void _kickPlayer(Player _player) {
    showAlert(
      context: context,
      title: '${_player.name} wirklich kicken?',
      actions: [
        AlertAction(
          text: 'Ja',
          isDestructiveAction: true,
          onPressed: () async {
            if (channel != null) {
              channel.sink.add(jsonEncode({'player_id': _player.id}));
            }
          },
        ),
        AlertAction(
          text: 'Nein',
          onPressed: null,
          automaticallyPopNavigation: true,
        ),
      ],
    );
  }

  void _triggerGameStart() {
    if (_leader.id == _myId && channel != null) {
      channel.sink.add(jsonEncode({'message': 'start'}));
    }
  }

  void _startGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Game(_lobby, _myId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget startButton;
    if (_leader?.id == _myId) {
      startButton = Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Button(
              title: 'Spiel starten',
              onPressed: () => _triggerGameStart(),
            ),
          ),
        ],
      );
    } else {
      startButton = Container();
    }

    return Scaffold(
      appBar: cardholderappbar(context),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Lobbylink'),
                              GestureDetector(
                                child: Icon(
                                  Icons.content_copy,
                                  size: 20,
                                ),
                                onTap: () {
                                  Clipboard.setData(new ClipboardData(
                                      text:
                                          'http://cardholder.surge.sh/${_lobby?.id}'));
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Lobbylink kopiert.'),
                                    backgroundColor: Colors.green,
                                  ));
                                },
                              ),
                            ],
                          ),
                          Text(
                            'cardholder.surge.sh/${_lobby?.id}',
                            style: Theme.of(context).textTheme.body2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Card(
                        margin:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Spieler'),
                              Text(
                                '${_lobby.players?.length}/${_lobby?.maxPlayers}',
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ],
                          ),
                          ..._lobby.players?.map((player) => PlayerEntry(
                                player,
                                _myId,
                                _leader?.id,
                                _kickPlayer,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              startButton,
            ],
          );
        },
      ),
    );
  }
}