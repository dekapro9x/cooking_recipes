import '../entities/meal.dart';
import '../entities/meal_detail.dart';

abstract class MealsRepository {
  Future<List<Meal>> searchMeals(String query);
  Future<MealDetail> getMealDetail(String id);
  Future<List<String>> getCategories();
}
