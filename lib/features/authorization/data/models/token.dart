import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  final String access;
  final String refresh;

  Token({this.access, this.refresh});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

}