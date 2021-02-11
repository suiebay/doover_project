import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import 'config.dart';

class AppInterceptors extends Interceptor {

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    options.headers["Authorization"] = "Bearer " + Hive.box('auth').get('access');
  }

  @override
  Future<dynamic> onError(DioError dioError) async {
    Dio dio = Dio(BaseOptions(baseUrl: '$API_URL/token/'));
    if(dioError.response?.statusCode == 401) {

      String refresh = Hive.box('auth').get('refresh');
      if(refresh != null) {

        Response response = await dio.post(
          'refresh/',
          data: jsonEncode(<String, String>{'refresh': refresh}),
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        if(response.statusCode == 200) {
          Hive.box('auth').put('access', response.data['access']);
          Hive.box('auth').put('refresh', response.data['refresh']);
        }
      }
    }
  }

  @override
  Future<dynamic> onResponse(Response options) async {
  }

}