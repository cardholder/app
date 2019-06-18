import 'package:cardholder/types/player.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

class PlayerEntry extends StatelessWidget {
  final Player _player;
  final int _myId;
  final int _leaderId;
  final Function _kickCallback;

  PlayerEntry(this._player, this._myId, this._leaderId, this._kickCallback);

  @override
  Widget build(BuildContext context) {
    var nameTextStyle = _player.id == _myId
        ? Theme.of(context).textTheme.body1
        : Theme.of(context).textTheme.body2;
    List<Widget> entry = List();

    if (_player.id == _leaderId) {
      entry.add(
        Padding(
          padding: const EdgeInsets.only(right: 3),
          child: Icon(
            Icons.star,
            color: Color.fromRGBO(201, 190, 145, 1),
          ),
        ),
      );
    } else {
      entry.add(Padding(
        padding: const EdgeInsets.only(right: 3),
        child: Icon(null),
      ));
    }
    entry.add(Text(
      _player?.name,
      style: nameTextStyle,
    ));
    if (_myId == _leaderId && _myId != _player.id) {
      entry.add(
        GestureDetector(
          onTap: () => {_kickCallback(_player)},
          child: Icon(
            Icons.close,
            size: 30,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: entry,
      ),
    );
  }
}
