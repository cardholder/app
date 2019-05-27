import 'dart:convert';

import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/ch_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'ch_button.dart';

class LobbySettings extends StatefulWidget {
  LobbySettings({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LobbySettingsState();
  }
}

class LobbySettingsState extends State<LobbySettings> {
  Map<String, dynamic> createLobbyMsg = Map();
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
                print(json.encode(createLobbyMsg));
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
