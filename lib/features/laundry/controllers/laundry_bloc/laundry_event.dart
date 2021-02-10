part of 'laundry_bloc.dart';

abstract class LaundryEvent {}


class LaundryClean extends LaundryEvent {}

class LaundryLoaded extends LaundryEvent {
  final List<Category> categories;

  LaundryLoaded(this.categories);
}

class LaundryProductsLoaded extends LaundryEvent {
  final String id;

  LaundryProductsLoaded(this.id);
}

class LaundrySearchActivated extends LaundryEvent {
  final String text;

  LaundrySearchActivated(this.text);

}