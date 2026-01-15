import 'package:dinhhaitrieu/features/domain/usecases/get_categories.dart';

import '../../domain/entities/meal.dart';
import '../../domain/entities/meal_detail.dart';
import '../../domain/repositories/meals_repository.dart';
import '../datasources/meals_remote_datasource.dart';

class MealsRepositoryImpl implements MealsRepository {
  final MealsRemoteDataSource remote;
  MealsRepositoryImpl(this.remote);

  @override
  Future<List<Meal>> searchMeals(String query) async {
    final models = await remote.searchMeals(query);
    return models
        .map((m) => Meal(id: m.idMeal, name: m.strMeal, thumb: m.strMealThumb))
        .toList();
  }

  @override
  Future<MealDetail> getMealDetail(String id) async {
    final m = await remote.getMealDetail(id);
    return MealDetail(
      id: m.idMeal,
      name: m.strMeal,
      thumb: m.strMealThumb,
      category: m.strCategory,
      area: m.strArea,
      instructions: m.strInstructions,
      youtube: m.strYoutube,
    );
  }

  @override
  Future<List<String>> getCategories() async {
    return await remote.getCategories();
  }
}
