import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  final String username;
  final String email;
  final String password;

  Auth(this.username, this.email, this.password);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}