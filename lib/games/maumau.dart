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
  List<PlayingCard> hand;
  List<PlayingCard> pile = [PlayingCard.undraggable(PlayingCard())];

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
    currentPlayer = Player.fromJson(response['current_player']);
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
                pile.add(PlayingCard.undraggable(data));
                hand.remove(data);
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
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    setState(() {
                      hand.add(PlayingCard());
                    });
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
