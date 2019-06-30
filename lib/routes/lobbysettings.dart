import 'dart:convert';
import 'package:cardholder/widgets/button.dart';
import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/widgets/cardholderappbar.dart';
import 'package:cardholder/widgets/cardholderformfield.dart';
import 'package:cardholder/routes/lobby.dart' as Route;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';
import 'package:cardholder/types/constants.dart';

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
  var scaffoldContext;

  _createLobby(Map createLobbyMsg) {
    Lobby _newLobby = Lobby.fromJson(createLobbyMsg);
    String id;
    channel = IOWebSocketChannel.connect(url + 'create/');

    channel.sink.add(json.encode(createLobbyMsg));
    channel.stream.listen(
      (response) {
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
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Fehler beim Erstellen einer Lobby'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  void cardgameCallback(var option) {
    createLobbyMsg['game'] = option;
  }

  void maxPlayerCallback(var option) {
    createLobbyMsg['max_players'] = int.parse(option);
  }

  void visibilityCallback(var option) {
    createLobbyMsg['visibility'] = visibilityTranslate[option];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardholderappbar(context),
      body: Builder(
        builder: (BuildContext context) {
          scaffoldContext = context;
          return Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 35),
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
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
