import 'package:dio/dio.dart';
import 'package:doover_project_test/core/config.dart';
import 'package:hive/hive.dart';

abstract class LaundryRemoteDataSource {
  Future<Response> getProducts();

  Future<Response> getProductsBySearch(String word);

  Future<Response> getProductsByCategory(String categoryId);

  Future<Response> getCategories();
}

class LaundryRemoteDataSourceImpl implements LaundryRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: '$API_URL/products/'));
  String token = Hive.box('auth').get('access');

  @override
  Future<Response> getCategories() async {
    Response response = await dio.get(
        'categories',
        options: Options(headers: {
          'Authorization': 'Bearer $token'
        })
    );

    return response;
  }

  @override
  Future<Response> getProducts() async {
    Response response = await dio.get(
      '',
      options: Options(headers: {
        'Authorization': 'Bearer $token'
      })
    );

    return response;
  }

  @override
  Future<Response> getProductsByCategory(String categoryId) async {
    Response response = await dio.get(
      '?category=$categoryId',
      options: Options(headers: {
        'Authorization': 'Bearer $token'
      })
    );

    return response;
  }

  @override
  Future<Response> getProductsBySearch(String word) async {
    Response response = await dio.get(
      '?search=$word',
      options: Options(headers: {
        'Authorization': 'Bearer $token'
      })
    );

    return response;
  }

}