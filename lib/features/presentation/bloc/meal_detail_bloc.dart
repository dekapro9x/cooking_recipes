import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_meal_detail.dart';
import 'meal_detail_event.dart';
import 'meal_detail_state.dart';

class MealDetailBloc extends Bloc<MealDetailEvent, MealDetailState> {
  final GetMealDetail getMealDetail;

  MealDetailBloc(this.getMealDetail) : super(const MealDetailState.initial()) {
    on<MealDetailEvent>((event, emit) {
      event.when(started: (id) => _onStarted(id, emit));
    });
  }

  Future<void> _onStarted(String id, Emitter<MealDetailState> emit) async {
    emit(const MealDetailState.loading());
    try {
      final detail = await getMealDetail(id);
      emit(MealDetailState.loaded(detail));
    } catch (e) {
      emit(MealDetailState.error(e.toString()));
    }
  }
}
