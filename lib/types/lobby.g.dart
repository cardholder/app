// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lobby.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lobby _$LobbyFromJson(Map<String, dynamic> json) {
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
