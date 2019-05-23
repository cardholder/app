// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playingcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayingCard _$PlayingCardFromJson(Map<String, dynamic> json) {
  return PlayingCard(
      json['id'] as int, json['value'] as String, json['color'] as String);
}

Map<String, dynamic> _$PlayingCardToJson(PlayingCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'color': instance.color
    };
