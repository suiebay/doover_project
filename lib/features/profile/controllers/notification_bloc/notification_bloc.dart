import 'package:doover_project_test/features/profile/data/models/settings.dart';
import 'package:doover_project_test/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';
part 'notification_event.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ProfileRepository profileRepository;

  NotificationBloc(this.profileRepository): super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
      NotificationEvent event
      ) async* {
    if(event is NotificationSwitched) {
      yield* _mapNotificationSwitchedToState(event, state);
    }
  }

  Stream<NotificationState> _mapNotificationSwitchedToState (
    NotificationSwitched event,
    NotificationState state
  ) async* {
    yield NotificationLoading();

    try {
      final settings  = await profileRepository.putUsersSettings(event.value);
      print(settings.notify);

      yield NotificationSuccess(settings);
    } on Exception catch (e) {
      yield NotificationFailure(e.toString());
      throw (e);

    }
  }

}