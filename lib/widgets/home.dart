import 'package:cardholder/widgets/button.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(
          'cardholder',
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(title: 'Lobby Suchen', onPressed: null),
            Button(title: 'Lobby erstellen', onPressed: null),
          ],
        ),
      ),
    );
  }
}
