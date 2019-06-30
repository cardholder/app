import 'dart:convert';

import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/types/player.dart';
import 'package:cardholder/widgets/playericon.dart';
import 'package:cardholder/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';
import 'package:cardholder/types/constants.dart';

class MauMau extends StatefulWidget {
  final Lobby _lobby;
  final int _myId;

  MauMau(this._lobby, this._myId);

  @override
  State<StatefulWidget> createState() {
    return MauMauState();
  }
}

class MauMauState extends State<MauMau> {
  var channel;
  String nextSymbol;
  Player me, currentPlayer;
  Color bottomAccentColor = Colors.grey;
  List<PlayingCard> hand = List();
  List<PlayingCard> stack = [PlayingCard(id: null)];
  List<PlayingCard> pile = [PlayingCard(id: null, draggable: false)];

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(url + 'maumau/${widget._lobby.id}/');
    _subscribeGameChannel();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  Future _subscribeGameChannel() async {
    channel.sink.add(jsonEncode({'player_id': widget._lobby.players[0].id}));
    channel.stream.listen((message) {
      Map<String, dynamic> response = jsonDecode(message);
      if (response['players'] != null) {
        _initPlayers(response);
      }

      if (response['cards'] != null) {
        _initCards(response);
      }

      if (response['current_player'] != null) {
        _setCurrentPlayer(response);
      }

      if (response['remaining_cards'] != null) {
        _setRemainingCards(response);
      }

      if (response['top_card_of_discard_pile'] != null) {
        _addToPile(response);
      }

      if (response['cards_drawn'] != null) {
        _drawCard(response);
      }

      if (response['player'] != null) {
        _updatePlayer(response);
      }

      if (response['symbol'] != null) {
        _updateSymbol(response);
      }

      if (response['message'] != null) {
        _updateStatus(response);
      }
    });
  }

  Future _initPlayers(Map response) async {
    List<Player> players = (response['players'] as List)
        .map((player) => Player.fromJson(player))
        .toList();
    me = players.firstWhere((player) => player.id == widget._myId);
    players.remove(me);
    setState(() {
      widget._lobby.players = players;
    });
  }

  Future _initCards(Map response) async {
    setState(() {
      hand = (response['cards'] as List)
          .map((card) => PlayingCard.fromJson(card))
          .toList();
    });
  }

  Future _setCurrentPlayer(Map response) async {
    setState(() {
      currentPlayer = Player.fromJson(response['current_player']);
      bottomAccentColor =
          (currentPlayer == me) ? Colors.greenAccent : Colors.grey;
    });
  }

  Future _setRemainingCards(Map response) async {
    setState(() {
      stack = [
        for (int i = 0; i < response['remaining_cards']; i++)
          PlayingCard(id: null)
      ];
    });
  }

  Future _addToPile(Map response) async {
    var card = response['top_card_of_discard_pile'];
    setState(() {
      pile.add(PlayingCard.undraggable(PlayingCard.fromJson(card)));
      nextSymbol = null;
    });
  }

  Future _drawCard(Map response) async {
    setState(() {
      hand.addAll((response['cards_drawn'] as List)
          .map((card) => PlayingCard.fromJson(card))
          .toList());
    });
  }

  Future _updatePlayer(Map response) async {
    Player player = Player.fromJson(response['player']);
    int index = widget._lobby.players.indexOf(player);
    setState(() {
      widget._lobby.players[index] = player;
    });
  }

  Future _updateSymbol(Map response) async {
    setState(() {
      nextSymbol = response['symbol'];
    });
  }

  Future _updateStatus(Map response) async {
    switch (response['message']) {
      case 'Sieger':
        _winnerDialog(response['player_id']);
        break;
      case 'Wuensch dir was':
        _selectCard();
        break;
      default:
    }
  }

  // Clientactions from here

  Future _pickCardFromStack(PlayingCard card) async {
    var msg = jsonEncode({'player': me.toJson()});
    channel.sink.add(msg);
  }

  Future _putCardOnPile(PlayingCard card) async {
    var msg = jsonEncode({'card': card.toJson(), 'player': me.toJson()});
    channel.sink.add(msg);
  }

  Future _selectCard() async {
    List<Widget> options = List();
    symbols.forEach((k, v) {
      options.add(GestureDetector(
        child: Text(v, style: TextStyle(fontSize: 35)),
        onTap: () => Navigator.pop(context, k),
      ));
    });
    var nextColor = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Farbe wählen:'),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: options,
            ),
          ],
        );
      },
    );
    var msg = jsonEncode({'symbol': nextColor});
    channel.sink.add(msg);
  }

  Future _winnerDialog(int playerId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Sieger: $playerId'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Zur Liste'),
              onPressed: () => Navigator.popUntil(
                  context, ModalRoute.withName('/lobbylist')),
            ),
            SimpleDialogOption(
              child: Text('Noch eine Runde'),
              onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/lobby')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ...widget._lobby.players?.map((player) {
                return PlayerIcon(player, (player?.id == currentPlayer?.id));
              }),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                ...stack,
                if (nextSymbol != null) ...{
                  Positioned(
                    left: 260,
                    top: 0,
                    child: Text(symbols[nextSymbol]),
                  )
                }
              ],
            ),
            DragTarget(
              builder:
                  (context, List<PlayingCard> candidateData, rejectedData) {
                return Stack(children: pile);
              },
              onWillAccept: (data) {
                return hand.contains(data);
              },
              onAccept: (PlayingCard data) {
                _putCardOnPile(data);
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                DragTarget(
                  builder:
                      (context, List<PlayingCard> candidateData, rejectedData) {
                    return Container(
                      height: 135,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: hand
                                ?.map(
                                  (f) => Positioned(
                                      left: hand.indexOf(f) *
                                          (MediaQuery.of(context).size.width /
                                              hand.length),
                                      child: f),
                                )
                                ?.toList() ??
                            [],
                      ),
                    );
                  },
                  onWillAccept: (PlayingCard data) {
                    return !hand.contains(data);
                  },
                  onAccept: (PlayingCard data) {
                    _pickCardFromStack(data);
                  },
                ),
                Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  color: bottomAccentColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(me?.name ?? ''),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
