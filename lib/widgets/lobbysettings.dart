import 'dart:convert';

import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/ch_formfield.dart';
import 'package:cardholder/widgets/lobby.dart' as Route;
import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/rendering.dart';
import 'package:flutter_web/widgets.dart';
import 'package:web_socket_channel/io.dart';

import 'ch_button.dart';

class LobbySettings extends StatefulWidget {
  LobbySettings({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LobbySettingsState();
  }
}

class LobbySettingsState extends State<LobbySettings> {
  Map<String, dynamic> createLobbyMsg = {
    'game': null,
    'visibility': null,
    'max_players': null
  };
  var channel;
  var cardgameOptions = ['Mau-Mau', 'Durak'];
  var maxPlayerOptions = ['2', '3', '4', '5', '6'];
  var visibilityOptions = ['public', 'private'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardholderappbar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                CardholderFormField(
                    'Kartenspiel', cardgameOptions, cardgameCallback),
                CardholderFormField(
                    'Spieleranzahl', maxPlayerOptions, maxPlayerCallback),
                CardholderFormField(
                    'Sichtbarkeit', visibilityOptions, visibilityCallback),
              ],
            ),
            Column(
              children: <Widget>[
                Button(
                    title: 'Lobby erstellen',
                    onPressed: () async {
                      _createLobby(createLobbyMsg);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _createLobby(Map createLobbyMsg) async {
    Lobby _newLobby = Lobby.fromJson(createLobbyMsg);
    String id;
    channel = IOWebSocketChannel.connect(
        "ws://ec2-18-185-18-129.eu-central-1.compute.amazonaws.com:8000/create/");

    channel.sink.add(json.encode(createLobbyMsg));
    channel.stream.listen((response) {
      channel.sink.close();
      id = jsonDecode(response)['id'] as String;
      if (id.length == 7) {
        _newLobby.id = id;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Route.Lobby(_newLobby),
          ),
        );
      } else {}
    });
  }

  void cardgameCallback(var option) {
    createLobbyMsg['game'] = option;
  }

  void maxPlayerCallback(var option) {
    createLobbyMsg['max_players'] = int.parse(option);
  }

  void visibilityCallback(var option) {
    createLobbyMsg['visibility'] = option;
  }
}

// TODO: Sichtbarkeit als Switch
