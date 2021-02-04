part of 'laundry_bloc.dart';

abstract class LaundryEvent {}

class LaundryLoaded extends LaundryEvent {}

class LaundryProductsLoaded extends LaundryEvent {
  final String id;

  LaundryProductsLoaded(this.id);
}

class LaundrySearchActivated extends LaundryEvent {
  final String text;

  LaundrySearchActivated(this.text);

}