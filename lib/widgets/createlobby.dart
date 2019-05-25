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
  var cardGameOptions = ['Skat', 'Mau-Mau'];
  var maxPlayerOptions = ['1', '2', '3', '4', '5', '6', '7', '8'];
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
              CardholderFormField('Kartenspiel', cardGameOptions),
              CardholderFormField('Spieleranzahl', maxPlayerOptions),
              CardholderFormField('Sichtbarkeit', visibilityOptions),
            ],
          ),
          Column(
            children: <Widget>[
              Button(title: 'Lobby erstellen', onPressed: null),
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
}

// TODO: Sichtbarkeit als Switch
