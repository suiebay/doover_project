import 'package:dio/dio.dart';
import 'package:doover_project_test/features/authorization/data/models/auth.dart';
import 'package:doover_project_test/features/authorization/data/models/token.dart';
import 'package:doover_project_test/features/authorization/data/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository): super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event
  ) async* {
    if(event is AuthSubmitted) {
      yield* _mapAuthSubmittedToState(event, state);
    }
  }

  Stream<AuthState> _mapAuthSubmittedToState (
    AuthSubmitted event,
    AuthState state
  ) async* {
    yield AuthLoading();

    try {
      final Token tokens = await authRepository.getTokens(event.auth);

      yield AuthSuccess(tokens);
    } on DioError catch (e) {
      yield AuthFailure(e.toString());
    } catch (e, s) {
      debugPrintStack(label: e, stackTrace: s);

      // TODO: IMlsdjnfoividvjpi
    }
  }

}