import 'package:json_annotation/json_annotation.dart';
import 'package:cardholder/types/player.dart';

@JsonSerializable()
class Lobby {
  String id, game, visibility;
  @JsonKey(name: 'max_players')
  int maxPlayers;
  List<Player> players;

  Lobby(this.id, this.game, this.visibility, this.maxPlayers, this.players);

  Map<String, dynamic> toJson() => _$LobbyToJson(this);

  factory Lobby.fromJson(Map<String, dynamic> json) {
    return Lobby(
        json['id'] as String,
        json['game'] as String,
        json['visibility'] as String,
        json['max_players'] as int,
        (json['players'] as List)
            ?.map((e) =>
                e == null ? null : Player.fromJson(e as Map<String, dynamic>))
            ?.toList());
  }

  Map<String, dynamic> _$LobbyToJson(Lobby instance) => <String, dynamic>{
        'id': instance.id,
        'game': instance.game,
        'visibility': instance.visibility,
        'max_players': instance.maxPlayers,
        'players': instance.players
      };
}
