import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  int id;
  String name, role;
  @JsonKey(name: 'card_amount')
  int remainingCards;

  Player(this.id, this.name, this.role, this.remainingCards);

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
