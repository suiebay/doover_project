part of 'notification_bloc.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

// enum NotificationFailureReason {
//
// }

class NotificationFailure extends NotificationState {
  final String message;

  NotificationFailure(this.message);
}

class NotificationSuccess extends NotificationState {
  final Settings settings;

  NotificationSuccess(this.settings);
}
