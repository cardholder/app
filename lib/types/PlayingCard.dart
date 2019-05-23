import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PlayingCard {
  int id;
  String value, color;

  PlayingCard(this.id, this.value, this.color);

  factory PlayingCard.fromJson(Map<String, dynamic> json) =>
      _$PlayingCardFromJson(json);

  Map<String, dynamic> toJson() => _$PlayingCardToJson(this);
}
