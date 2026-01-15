import '../entities/meal_detail.dart';
import '../repositories/meals_repository.dart';

class GetMealDetail {
  final MealsRepository repo;
  GetMealDetail(this.repo);

  Future<MealDetail> call(String id) => repo.getMealDetail(id);
}
