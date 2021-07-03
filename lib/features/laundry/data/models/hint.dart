import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hint.g.dart';

@HiveType(typeId : 1)
@JsonSerializable()
class Hint {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  Hint({this.title, this.description});

  factory Hint.fromJson(Map<String, dynamic> json) => _$HintFromJson(json);

  Map<String, dynamic> toJson() => _$HintToJson(this);
}