import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  @JsonKey(name: 'uuid')
  final String categoryId;
  final String name;
  final String picture;
  final String description;
  final String parent;

  Category({this.categoryId, this.name, this.picture, this.description, this.parent});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}