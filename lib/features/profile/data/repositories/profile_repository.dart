import 'package:doover_project_test/features/profile/data/datasources/profile_datasource.dart';
import 'package:doover_project_test/features/profile/data/models/settings.dart';
import 'package:doover_project_test/features/profile/data/models/user.dart';
import 'package:dio/dio.dart';

abstract class ProfileRepository {
  Future<List<User>> getUsers();

  Future<User> getUsersMe();

  Future<Settings> getUsersSettings();

  Future<Settings> putUsersSettings(bool notify);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(this.profileRemoteDataSource);


  @override
  Future<List<User>> getUsers() async {
    Response response = await profileRemoteDataSource.getUsers();
    return (response.data as List)
        .map((object) => User.fromJson(object))
        .toList();
  }

  @override
  Future<User> getUsersMe() async {
    Response response = await profileRemoteDataSource.getUsersMe();
    return User.fromJson(response.data);
  }

  @override
  Future<Settings> getUsersSettings() async {
    Response response = await profileRemoteDataSource.getUsersSettings();
    return Settings.fromJson(response.data);
  }

  @override
  Future<Settings> putUsersSettings(bool notify) async {
    Response response = await profileRemoteDataSource.putUsersSettings(notify);
    return Settings.fromJson(response.data);
  }
}