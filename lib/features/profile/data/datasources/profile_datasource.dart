import 'dart:convert';

import 'package:doover_project_test/core/app_interceptors.dart';
import 'package:doover_project_test/core/config.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

abstract class ProfileRemoteDataSource {
  Future<Response> getUsers();

  Future<Response> getUsersMe();

  Future<Response> getUsersSettings();

  Future<Response> putUsersSettings(bool notify);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: '$API_URL/users/'))..interceptors.add(AppInterceptors());
  String token = Hive.box('auth').get('access');

  @override
  Future<Response> getUsers() async {
    Response response = await dio.get('');

    return response;
  }

  @override
  Future<Response> getUsersMe() async {
    Response response = await dio.get('me/');

    return response;
  }

  @override
  Future<Response> getUsersSettings() async {
    Response response = await dio.get('settings/');

    return response;
  }

  @override
  Future<Response> putUsersSettings(bool notify) async {
    Response response = await dio.put(
      'settings/',
      data: jsonEncode(<String, bool>{'notify': notify}),
    );

    return response;
  }

}