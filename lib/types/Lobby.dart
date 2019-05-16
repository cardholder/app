import 'package:cardholder/types/Player.dart';

class Lobby {
  String id, game, visibility;
  int maxPlayers;
  List<Player> players;

  Lobby(this.id, this.game, this.visibility, this.maxPlayers, this.players);
}
