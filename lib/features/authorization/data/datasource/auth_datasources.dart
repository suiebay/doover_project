import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doover_project_test/core/config.dart';
import 'package:doover_project_test/features/authorization/data/models/auth.dart';

abstract class AuthRemoteDataSource {
  Future<Response> getToken(Auth auth);

  Future<Response> verifyToken(String token);

  Future<Response> refreshToken(String refresh);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: '$API_URL/token/'));

  @override
  Future<Response> getToken(Auth auth) async {
    Response response = await dio.post(
      '',
      data: auth.toJson(),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    return response;
  }

  @override
  Future<Response> verifyToken(String token) async {
    Response response = await dio.post(
      'verify/',
      data: jsonEncode(<String, String>{'token': token}),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    return response;
  }

  @override
  Future<Response> refreshToken(String refresh) async {
    Response response = await dio.post(
      'refresh/',
      data: jsonEncode(<String, String>{'refresh': refresh}),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    return response;
  }

}