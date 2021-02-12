import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'hint.dart';

part 'laundry.g.dart';

@HiveType(typeId : 0)
@JsonSerializable()
class Laundry extends HiveObject{
  @HiveField(0)
  @JsonKey(name: 'uuid')
  final String productId;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String picture;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final double duration;

  @HiveField(6)
  final Hint hint;

  @HiveField(7)
  @JsonKey(ignore: true, defaultValue: 0)
  int counter = 0;

  Laundry({this.productId, this.category, this.name, this.picture, this.price, this.duration, this.hint });

  factory Laundry.fromJson(Map<String, dynamic> json) => _$LaundryFromJson(json);

  Map<String, dynamic> toJson() => _$LaundryToJson(this);
}

