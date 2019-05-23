import 'package:json_annotation/json_annotation.dart';
import 'package:cardholder/types/player.dart';

part 'lobby.g.dart';

@JsonSerializable()
class Lobby {
  String id, game, visibility;
  @JsonKey(name: 'max_players')
  int maxPlayers;
  List<Player> players;

  Lobby(this.id, this.game, this.visibility, this.maxPlayers, this.players);

  factory Lobby.fromJson(Map<String, dynamic> json) => _$LobbyFromJson(json);

  Map<String, dynamic> toJson() => _$LobbyToJson(this);
}
