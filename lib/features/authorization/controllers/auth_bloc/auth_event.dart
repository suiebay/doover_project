part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSubmitted extends AuthEvent {
  final Auth auth;

  AuthSubmitted(this.auth);

}
