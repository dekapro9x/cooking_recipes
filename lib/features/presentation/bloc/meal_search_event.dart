import 'package:freezed_annotation/freezed_annotation.dart';
part 'meal_search_event.freezed.dart';

@freezed
class MealSearchEvent with _$MealSearchEvent {
  const factory MealSearchEvent.queryChanged(String query) = _QueryChanged;
  const factory MealSearchEvent.submitted(String query) = _Submitted;
}
