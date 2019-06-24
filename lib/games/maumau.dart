import 'dart:convert';

import 'package:cardholder/types/lobby.dart';
import 'package:cardholder/types/player.dart';
import 'package:cardholder/widgets/playericon.dart';
import 'package:cardholder/widgets/playingcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/io.dart';

class MauMau extends StatefulWidget {
  final Lobby _lobby;

  MauMau(this._lobby);

  @override
  State<StatefulWidget> createState() {
    return MauMauState();
  }
}

class MauMauState extends State<MauMau> {
  var channel;
  Player me, currentPlayer;
  List<PlayingCard> hand = List();
  List<PlayingCard> stack = List();
  List<PlayingCard> pile = [PlayingCard(id: null, draggable: false)];

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        "ws://ec2-18-185-18-129.eu-central-1.compute.amazonaws.com:8000/maumau/${widget._lobby.id}/");
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
      print(message);
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

      if (response['top_card_of_discard_pile'] != null ||
          response['card'] != null) {
        _addToPile(response);
      }

      if (response['cards_drawn'] != null) {
        _drawCard(response);
      }

      if (response['player'] != null) {
        _updatePlayer(response);
      }
    });
  }

  Future _initPlayers(Map response) async {
    widget._lobby.players = (response['players'] as List)
        .map((player) => Player.fromJson(player))
        .toList();
    setState(() {
      me = widget._lobby.players[0];
      widget._lobby.players.remove(me);
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
    var card = response['top_card_of_discard_pile'] != null
        ? response['top_card_of_discard_pile']
        : response['card'];
    pile.add(PlayingCard.undraggable(PlayingCard.fromJson(card)));
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

  // Clientactions from here

  Future _pickCardFromStack(PlayingCard card) async {
    var msg = jsonEncode({'player': me.toJson()});
    channel.sink.add(msg);
  }

  Future _putCardOnPile(PlayingCard card) async {
    var msg = jsonEncode({'card': card.toJson(), 'player': me.toJson()});
    channel.sink.add(msg);
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
              children: <Widget>[
                PlayingCard(id: null),
                PlayingCard(id: null),
                PlayingCard(id: null),
                PlayingCard(id: null),
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
                //pile.add(PlayingCard.undraggable(data));
                //hand.remove(data);
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
                                ?.map((f) => Positioned(
                                    left: hand.indexOf(f) *
                                        (MediaQuery.of(context).size.width /
                                            hand.length),
                                    child: f))
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
                  color: Colors.greenAccent,
                  child: Text('Username'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
