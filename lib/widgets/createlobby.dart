import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:cardholder/widgets/ch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return Scaffold(
      appBar: cardholderappbar(context),
      body: DropdownButton<String>(
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
      ),
    );
  }
}

// TODO: Sichtbarkeit als Switch
