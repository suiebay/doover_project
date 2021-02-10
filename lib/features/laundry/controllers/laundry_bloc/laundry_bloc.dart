import 'package:doover_project_test/features/laundry/data/models/category.dart';
import 'package:doover_project_test/features/laundry/data/models/laundry.dart';
import 'package:doover_project_test/features/laundry/data/repositories/laundry_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'laundry_state.dart';
part 'laundry_event.dart';

class LaundryBloc extends Bloc<LaundryEvent, LaundryState> {
  final LaundryRepository laundryRepository;

  LaundryBloc(this.laundryRepository) : super(LaundryInitial());

  @override
  Stream<LaundryState> mapEventToState(
      LaundryEvent event
    ) async* {
    if(event is LaundryLoaded) {
      yield* _mapLaundryLoadedToState(event, state);
    } else if(event is LaundryProductsLoaded) {
      yield* _mapLaundryProductsLoadedToState(event, state);
    } else if(event is LaundrySearchActivated) {
      yield* _mapLaundrySearchActivatedToState(event, state);
    } else if(event is LaundryClean) {
      yield* _mapLaundryCleanActivatedToState();
    }
  }

  Stream<LaundryState> _mapLaundryLoadedToState (
      LaundryLoaded event,
      LaundryState state
    ) async* {
    if(event.categories == null)
      yield LaundryLoading();
    try {
      if(event.categories == null) {
        final List<Category> products = await laundryRepository.getCategories();

        yield LaundrySuccess(products);
      } else {
        yield LaundrySuccess(event.categories);
      }
    } on Exception catch (e) {
      yield LaundryFailure(e.toString());
      throw (e);

    }
  }

  Stream<LaundryState> _mapLaundryProductsLoadedToState (
      LaundryProductsLoaded event,
      LaundryState state
    ) async* {
    yield LaundryLoading();

    try {
      final List<Laundry> products = await laundryRepository.getProductsByCategory(event.id);

      yield LaundryProductsSuccess(products);
    } on Exception catch (e) {
      yield LaundryFailure(e.toString());
      // throw (e);

    }
  }

  Stream<LaundryState> _mapLaundrySearchActivatedToState (
      LaundrySearchActivated event,
      LaundryState state
    ) async* {
    yield LaundryLoading();

    try {
      final List<Laundry> products = await laundryRepository.getProductsBySearch(event.text);

      yield LaundrySearchSuccess(products);
    } on Exception catch (e) {
      yield LaundryFailure(e.toString());
      throw (e);

    }
  }

  Stream<LaundryState> _mapLaundryCleanActivatedToState () async* {
    yield LaundryInitial();
  }

}