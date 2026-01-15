import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/meal_detail.dart';
part 'meal_detail_state.freezed.dart';

@freezed
class MealDetailState with _$MealDetailState {
  const factory MealDetailState.initial() = _Initial;
  const factory MealDetailState.loading() = _Loading;
  const factory MealDetailState.loaded(MealDetail detail) = _Loaded;
  const factory MealDetailState.error(String message) = _Error;
}
