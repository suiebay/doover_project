import 'package:doover_project_test/features/profile/data/models/settings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'uuid')
  final String userId;
  final String email;
  final String username;
  final String dateJoined;
  final String lastLogin;
  final bool isActive;
  final Settings settings;

  User({this.userId, this.email, this.username, this.dateJoined, this.lastLogin, this.isActive, this.settings});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}