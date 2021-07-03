part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileLoaded extends ProfileEvent {
  final User profile;

  ProfileLoaded(this.profile);
}
