import '../entities/meal.dart';
import '../repositories/meals_repository.dart';

class SearchMeals {
  final MealsRepository repo;
  SearchMeals(this.repo);

  Future<List<Meal>> call(String query) => repo.searchMeals(query);
}
