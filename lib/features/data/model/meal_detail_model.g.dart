// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealDetailModelImpl _$$MealDetailModelImplFromJson(
  Map<String, dynamic> json,
) => _$MealDetailModelImpl(
  idMeal: json['idMeal'] as String,
  strMeal: json['strMeal'] as String,
  strMealThumb: json['strMealThumb'] as String,
  strCategory: json['strCategory'] as String,
  strArea: json['strArea'] as String,
  strInstructions: json['strInstructions'] as String,
  strYoutube: json['strYoutube'] as String?,
);

Map<String, dynamic> _$$MealDetailModelImplToJson(
  _$MealDetailModelImpl instance,
) => <String, dynamic>{
  'idMeal': instance.idMeal,
  'strMeal': instance.strMeal,
  'strMealThumb': instance.strMealThumb,
  'strCategory': instance.strCategory,
  'strArea': instance.strArea,
  'strInstructions': instance.strInstructions,
  'strYoutube': instance.strYoutube,
};
