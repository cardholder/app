import 'package:cardholder/widgets/button.dart';
import 'package:cardholder/widgets/ch_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cardholderappbar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
                title: 'Lobby suchen',
                onPressed: () {
                  Navigator.pushNamed(context, '/lobbylist');
                }),
            Button(title: 'Lobby erstellen', onPressed: null),
          ],
        ),
      ),
    );
  }
}
