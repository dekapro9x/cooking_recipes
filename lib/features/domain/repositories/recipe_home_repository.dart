import 'package:dinhhaitrieu/features/data/model/home/respon_recipe_home_page.dart';

abstract class RecipeHomeRepository {
  Future<List<RecipeMealModel>> getRecipeHomePage();
}
