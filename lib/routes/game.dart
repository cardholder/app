import 'package:cardholder/games/maumau.dart';
import 'package:cardholder/types/lobby.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Game extends StatelessWidget {
  final Lobby _lobby;
  final int _myId;

  Game(this._lobby, this._myId);

  @override
  Widget build(BuildContext context) {
    Widget selectedGame;
    switch (_lobby.game) {
      case 'Mau Mau':
        selectedGame = MauMau(_lobby, _myId);
        break;
      default:
        Navigator.pop(context);
    }
    return Scaffold(
      body: selectedGame,
    );
  }
}
