import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/widgets/cardholderappbar.dart';
import 'package:cardholder/widgets/lobbylistentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:cardholder/types/constants.dart';

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
      channel = IOWebSocketChannel.connect(url + 'lobbylist/');
    } catch (SocketException) {
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
      }

      if (response['lobby'] != null) {
        _updateLobby(response);
      }

      if (response['lobby_id'] != null) {
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
    var _newLobby = Lobby.fromJson(response['lobby']);
    var index = _lobbies.indexWhere((lobby) => lobby.id == _newLobby.id);
    if (index < 0) {
      setState(() {
        _lobbies.add(_newLobby);
      });
    } else {
      setState(() {
        _lobbies[index] = _newLobby;
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
              return LobbyListEntry(_lobbies[index]);
            },
          );
        },
      ),
    );
  }

  void displaySnackBar(String content) {
    final snackBar =
        new SnackBar(content: new Text(content), backgroundColor: Colors.red);
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }
}
