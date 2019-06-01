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
    _fetchLobbies();
  }

  Future _fetchLobbies() async {
    channel.stream.listen((message) {
      print(message);
      List list = jsonDecode(message)['lobbies'] as List;
      if (list.length == 0) {
        // Fullscreen errormsg
        displaySnackBar('Keine Lobbys verfügbar');
      } else {
        setState(() {
          _lobbies = list.map((f) => Lobby.fromJson(f)).toList();
        });
      }
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
