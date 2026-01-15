import 'package:freezed_annotation/freezed_annotation.dart';
part 'meal_model.freezed.dart';
part 'meal_model.g.dart';

@freezed
class MealModel with _$MealModel {
  const factory MealModel({
    @JsonKey(name: "idMeal") required String idMeal,
    @JsonKey(name: "strMeal") required String strMeal,
    @JsonKey(name: "strMealThumb") required String strMealThumb,
  }) = _MealModel;

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);
}
