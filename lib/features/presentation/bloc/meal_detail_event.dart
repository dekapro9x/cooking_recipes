import 'package:freezed_annotation/freezed_annotation.dart';
part 'meal_detail_event.freezed.dart';

@freezed
class MealDetailEvent with _$MealDetailEvent {
  const factory MealDetailEvent.started(String id) = _Started;
}
