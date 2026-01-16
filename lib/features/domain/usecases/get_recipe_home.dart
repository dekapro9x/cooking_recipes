import 'package:dinhhaitrieu/features/data/model/home/respon_recipe_home_page.dart';
import 'package:dinhhaitrieu/features/domain/repositories/recipe_home_repository.dart';

class GetRecipeHome {
  final RecipeHomeRepository repository;

  GetRecipeHome(this.repository);

  Future<List<RecipeMealModel>> call() async {
    return await repository.getRecipeHomePage();
  }
}
