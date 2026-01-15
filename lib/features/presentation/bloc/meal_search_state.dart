import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/meal.dart';
part 'meal_search_state.freezed.dart';

@freezed
class MealSearchState with _$MealSearchState {
  const factory MealSearchState.initial() = _Initial;
  const factory MealSearchState.loading() = _Loading;
  const factory MealSearchState.loaded(List<Meal> items) = _Loaded;
  const factory MealSearchState.empty() = _Empty;
  const factory MealSearchState.error(String message) = _Error;
}
