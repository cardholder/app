import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/ch_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'ch_button.dart';

class CreateLobby extends StatefulWidget {
  CreateLobby({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateLobbyState();
  }
}

class CreateLobbyState extends State<CreateLobby> {
  Lobby lobby = Lobby(null, null, null, null, null);
  var cardgameOptions = ['Skat', 'Mau-Mau'];
  var maxPlayerOptions = ['2', '3', '4', '5', '6', '7', '8'];
  var visibilityOptions = ['Privat', 'Öffentlich'];

  @override
  Widget build(BuildContext context) {
    Widget body;
    body = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              CardholderFormField('Kartenspiel', cardgameOptions, cardgameCallback),
              CardholderFormField('Spieleranzahl', maxPlayerOptions, maxPlayerCallback),
              CardholderFormField('Sichtbarkeit', visibilityOptions, visibilityCallback),
            ],
          ),
          Column(
            children: <Widget>[
              Button(title: 'Lobby erstellen', onPressed: () async {
                print(lobby.toJson());
              }),
            ],
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: cardholderappbar(context),
      body: body,
    );
  }

  void cardgameCallback(var option) {
    lobby.game = option;
  }

  void maxPlayerCallback(var option) {
    lobby.maxPlayers = int.parse(option);
  }

  void visibilityCallback(var option) {
    lobby.visibility = option;
  }
}

// TODO: Sichtbarkeit als Switch
