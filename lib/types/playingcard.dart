import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PlayingCard {
  int id;
  String value, color;

  PlayingCard(this.id, this.value, this.color);

  Map<String, dynamic> toJson() => _$PlayingCardToJson(this);

  factory PlayingCard.fromJson(Map<String, dynamic> json) {
  return PlayingCard(
      json['id'] as int, json['value'] as String, json['color'] as String);
}

Map<String, dynamic> _$PlayingCardToJson(PlayingCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'color': instance.color
    };
}
