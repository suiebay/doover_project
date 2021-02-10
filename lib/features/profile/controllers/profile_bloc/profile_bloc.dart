import 'package:doover_project_test/features/profile/data/models/user.dart';
import 'package:doover_project_test/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository): super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
      ProfileEvent event
      ) async* {
    if(event is ProfileLoaded) {
      yield* _mapProfileSubmittedToState(event, state);
    }
  }

  Stream<ProfileState> _mapProfileSubmittedToState (
      ProfileLoaded event,
      ProfileState state
      ) async* {
    if(event.profile == null) {
      print(event.profile);
      yield ProfileLoading();
    }

    try {
      if(event.profile == null) {
        final User profile = await profileRepository.getUsersMe();

        Hive.box('auth').put('username', profile.username);
        Hive.box('auth').put('notify', profile.settings.notify);

        yield ProfileSuccess(profile);
      } else {
        yield ProfileSuccess(event.profile);
      }
    } on Exception catch (e) {
      yield ProfileFailure(e.toString());
      throw (e);

    }
  }

}