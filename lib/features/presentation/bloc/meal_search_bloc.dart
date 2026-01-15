import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_meals.dart';
import 'meal_search_event.dart';
import 'meal_search_state.dart';

class MealSearchBloc extends Bloc<MealSearchEvent, MealSearchState> {
  final SearchMeals searchMeals;

  Timer? _debounce;

  MealSearchBloc(this.searchMeals) : super(const MealSearchState.initial()) {
    on<MealSearchEvent>((event, emit) {
      event.when(
        queryChanged: (query) => _onQueryChanged(query, emit),
        submitted: (query) => _onSubmitted(query, emit),
      );
    });
  }

  Future<void> _onQueryChanged(
    String query,
    Emitter<MealSearchState> emit,
  ) async {
    _debounce?.cancel();
    final q = query.trim();

    if (q.isEmpty) {
      emit(const MealSearchState.initial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () {
      add(MealSearchEvent.submitted(q));
    });
  }

  Future<void> _onSubmitted(String query, Emitter<MealSearchState> emit) async {
    final q = query.trim();
    if (q.isEmpty) return;

    emit(const MealSearchState.loading());
    try {
      final items = await searchMeals(q);
      if (items.isEmpty) {
        emit(const MealSearchState.empty());
      } else {
        emit(MealSearchState.loaded(items));
      }
    } catch (e) {
      emit(MealSearchState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
