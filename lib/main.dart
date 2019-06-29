import 'package:cardholder/routes/home.dart';
import 'package:cardholder/routes/lobby.dart';
import 'package:cardholder/routes/lobbylist.dart';
import 'package:cardholder/routes/lobbysettings.dart';
import 'package:cardholder/routes/usernamedialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(Cardholder());

class Cardholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: Color.fromRGBO(110, 174, 173, 1),
        buttonColor: Color.fromRGBO(83, 98, 145, 1),
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 22),
          body2: TextStyle(
            fontSize: 22,
            color: Color.fromRGBO(128, 128, 128, 1),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/username': (context) => UsernameDialog(),
        '/lobbylist': (context) => LobbyList(),
        '/createlobby': (context) => LobbySettings(),
        '/lobby': (context) => Lobby(null),
      },
    );
  }
}
