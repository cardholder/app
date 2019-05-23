import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:flutter/material.dart';
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
  String dropdownValue = 'Skat';

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Kartenspiel:'),
          Card(
            margin: EdgeInsets.all(15),
            child: Text('help'),
          ),
          Button(title: 'Lobby erstellen', onPressed: null),
        ],
      );
    }

    if (Theme.of(context).platform == TargetPlatform.android) {
      body = DropdownButton<String>(
        value: dropdownValue,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Skat', 'Mau-Mau']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    }

    return Scaffold(
      appBar: cardholderappbar(context),
      body: body,
    );
  }
}

// TODO: Sichtbarkeit als Switch
