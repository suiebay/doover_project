part of 'laundry_bloc.dart';

abstract class LaundryState {}

class LaundryInitial extends LaundryState {}

class LaundryLoading extends LaundryState {}

class LaundryFailure extends LaundryState {
  final String message;

  LaundryFailure(this.message);
}

class LaundrySuccess extends LaundryState {
  final List<Category> categories;

  LaundrySuccess(this.categories);
}

class LaundryProductsSuccess extends LaundryState{
  final List<Laundry> products;

  LaundryProductsSuccess(this.products);
}

class LaundrySearchSuccess extends LaundryState{
  final List<Laundry> products;

  LaundrySearchSuccess(this.products);
}
