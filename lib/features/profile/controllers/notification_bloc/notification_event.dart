part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class NotificationSwitched extends NotificationEvent{
  final bool value;

  NotificationSwitched(this.value);
}
