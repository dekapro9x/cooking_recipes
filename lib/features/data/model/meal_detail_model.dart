import 'package:freezed_annotation/freezed_annotation.dart';
part 'meal_detail_model.freezed.dart';
part 'meal_detail_model.g.dart';

@freezed
class MealDetailModel with _$MealDetailModel {
  const factory MealDetailModel({
    @JsonKey(name: "idMeal") required String idMeal,
    @JsonKey(name: "strMeal") required String strMeal,
    @JsonKey(name: "strMealThumb") required String strMealThumb,
    @JsonKey(name: "strCategory") required String strCategory,
    @JsonKey(name: "strArea") required String strArea,
    @JsonKey(name: "strInstructions") required String strInstructions,
    @JsonKey(name: "strYoutube") String? strYoutube,
  }) = _MealDetailModel;

  factory MealDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MealDetailModelFromJson(json);
}
