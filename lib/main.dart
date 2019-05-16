import 'package:cardholder/widgets/home.dart';
import 'package:cardholder/widgets/lobbylist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: Color.fromRGBO(110, 174, 173, 1),
        buttonColor: Color.fromRGBO(83, 98, 145, 1),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/lobbylist': (context) => LobbyList(),
      },
    );
  }
}
