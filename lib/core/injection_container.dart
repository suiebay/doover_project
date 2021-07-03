import 'package:doover_project_test/features/authorization/controllers/auth_bloc/auth_bloc.dart';
import 'package:doover_project_test/features/authorization/data/datasource/auth_datasources.dart';
import 'package:doover_project_test/features/authorization/data/repositories/auth_repository.dart';
import 'package:doover_project_test/features/laundry/data/datasources/laundry_datasource.dart';
import 'package:doover_project_test/features/laundry/data/repositories/laundry_repository.dart';
import 'package:doover_project_test/features/laundry/controllers/laundry_bloc/laundry_bloc.dart';
import 'package:doover_project_test/features/profile/controllers/notification_bloc/notification_bloc.dart';
import 'package:doover_project_test/features/profile/controllers/profile_bloc/profile_bloc.dart';
import 'package:doover_project_test/features/profile/data/datasources/profile_datasource.dart';
import 'package:doover_project_test/features/profile/data/repositories/profile_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupInjections() {
  // getIt.registerLazySingleton<AppInterceptors>(
  //       () => AppInterceptors(getIt()),
  // );

  getIt.registerLazySingleton<LaundryRemoteDataSource>(
        () => LaundryRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<LaundryRepository>(
        () => LaundryRepositoryImpl(getIt()),
  );

  getIt.registerFactory<LaundryBloc>(
        () => LaundryBloc(getIt()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(getIt()),
  );

  getIt.registerFactory<AuthBloc>(
        () => AuthBloc(getIt()),
  );

  getIt.registerLazySingleton<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(getIt()),
  );

  getIt.registerFactory<ProfileBloc>(
        () => ProfileBloc(getIt()),
  );

  getIt.registerFactory<NotificationBloc>(
        () => NotificationBloc(getIt()),
  );
}
