import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Player {
  int id;
  String name, role;

  Player(this.id, this.name, this.role);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  factory Player.fromJson(Map<String, dynamic> json) {
  return Player(
      json['id'] as int, json['name'] as String, json['role'] as String);
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role
    };
}
