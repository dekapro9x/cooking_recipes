import 'package:dinhhaitrieu/features/domain/usecases/get_categories.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/categoriesBloc/categories_event.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/categoriesBloc/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories _getCategories;

  CategoriesBloc(this._getCategories) : super(CategoriesInitial()) {
    on<CategoriesStarted>(_onStarted);
    on<CategoriesSelected>(_onSelected);
  }

  void _onStarted(
    CategoriesStarted event,
    Emitter<CategoriesState> emit,
  ) async {
    if (state is CategoriesLoaded) {
      return;
    }
    emit(CategoriesLoading());
    await _loadCategories(emit);
  }

  void _onSelected(CategoriesSelected event, Emitter<CategoriesState> emit) {
    final current = state;
    if (current is! CategoriesLoaded) {
      return;
    }
    final idx = current.categories.indexOf(event.categoryName);
    if (idx == -1) return;

    emit(current.copyWith(selectedIndex: idx));
  }

  Future<void> _loadCategories(Emitter<CategoriesState> emit) async {
    try {
      final categories = await _getCategories();
      if (categories.isNotEmpty) {
        emit(CategoriesLoaded(categories: categories, selectedIndex: 0));
      } else {
        emit(CategoriesError('No categories found'));
      }
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
