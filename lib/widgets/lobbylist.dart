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
  BuildContext scaffoldContext;
  var channel;
  List<Lobby> _lobbies = [];

  @override
  void initState() {
    super.initState();
    try {
      channel = IOWebSocketChannel.connect(
          "ws://ec2-18-185-18-129.eu-central-1.compute.amazonaws.com:8000/lobbylist/");
    } catch (all) {
      displaySnackBar('Keine Verbindung zum Server');
    }
    _subscribeLobbyList();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  Future _subscribeLobbyList() async {
    channel.stream.listen((message) {
      Map<String, dynamic> response = jsonDecode(message);
      if (response['lobbies'] != null) {
        _setLobbies(response);
      } else if (response['lobby'] != null) {
        _updateLobby(response);
      } else if (response['lobby_id'] != null) {
        _removeLobby(response['lobby_id']);
      }
    });
  }

  Future _setLobbies(Map response) async {
    List list = await response['lobbies'] as List;
    if (list.length > 0) {
      setState(() {
        _lobbies = list.map((f) => Lobby.fromJson(f)).toList();
      });
    } else {
      displaySnackBar('Keine Lobbies verfügbar.');
    }
  }

  Future _updateLobby(Map response) async {
    var newLobby = Lobby.fromJson(response['lobby']);
    var index = _lobbies.indexWhere((lobby) => lobby.id == newLobby.id);
    if (index < 0) {
      setState(() {
        _lobbies.add(newLobby);
      });
    } else {
      setState(() {
        _lobbies[index] = newLobby;
      });
    }
  }

  Future _removeLobby(String lobbyId) async {
    setState(() {
      _lobbies.removeWhere((lobby) => lobby.id == lobbyId);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: cardholderappbar(context),
        body: Builder(
          builder: (BuildContext context) {
            scaffoldContext = context;
            return ListView.builder(
              itemCount: _lobbies.length,
              itemBuilder: (BuildContext context, int index) {
                return GameCard(_lobbies[index]);
              },
            );
          },
        ));
  }

  void displaySnackBar(String content) {
    final snackBar =
        new SnackBar(content: new Text(content), backgroundColor: Colors.red);
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }
}
