import 'package:doover_project_test/features/authorization/data/datasource/auth_datasources.dart';
import 'package:doover_project_test/features/authorization/data/models/auth.dart';
import 'package:doover_project_test/features/authorization/data/models/token.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

abstract class AuthRepository {
  Future<Token> getTokens(Auth auth);

  Future<dynamic> verifyToken(String token);

  Future<Token> refreshToken(String refresh);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  var box = Hive.box('auth');

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Token> getTokens(Auth auth) async {
    Response response = await authRemoteDataSource.getToken(auth);
    Token token = Token.fromJson(response.data);

    box.put('access', token.access);
    box.put('refresh', token.refresh);

    return token;
  }

  @override
  Future<Token> refreshToken(String refresh) async {
    Response response = await authRemoteDataSource.refreshToken(refresh);
    Token token = Token.fromJson(response.data);

    box.put('access', token.access);
    box.put('refresh', token.refresh);

    return token;
  }

  @override
  Future verifyToken(String token) async {
    Response response = await authRemoteDataSource.verifyToken(token);
    return response.data;
  }
}