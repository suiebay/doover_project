import 'package:doover_project_test/features/laundry/data/datasources/laundry_datasource.dart';
import 'package:doover_project_test/features/laundry/data/models/category.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:dio/dio.dart';

abstract class LaundryRepository {
  Future<List<Laundry>> getProducts();

  Future<List<Laundry>> getProductsBySearch(String word);

  Future<List<Laundry>> getProductsByCategory(String categoryId);

  Future<List<Category>> getCategories();
}

class LaundryRepositoryImpl implements LaundryRepository {
  final LaundryRemoteDataSource laundryRemoteDataSource;

  LaundryRepositoryImpl(this.laundryRemoteDataSource);

  @override
  Future<List<Laundry>> getProducts() async {
    Response response = await laundryRemoteDataSource.getProducts();
    return (response.data as List)
        .map((object) => Laundry.fromJson(object))
        .toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    Response response = await laundryRemoteDataSource.getCategories();
    return (response.data as List)
        .map((object) => Category.fromJson(object))
        .toList();
  }

  @override
  Future<List<Laundry>> getProductsByCategory(String categoryId) async {
    Response response = await laundryRemoteDataSource.getProductsByCategory(categoryId);
    return (response.data as List)
        .map((object) => Laundry.fromJson(object))
        .toList();
  }

  @override
  Future<List<Laundry>> getProductsBySearch(String word) async {
    Response response = await laundryRemoteDataSource.getProductsBySearch(word);
    return (response.data as List)
        .map((object) => Laundry.fromJson(object))
        .toList();
  }
}