import 'package:dinhhaitrieu/features/data/datasources/recipe_home_remote_datasource.dart';
import 'package:dinhhaitrieu/features/data/model/home/respon_recipe_home_page.dart';
import 'package:dinhhaitrieu/features/domain/repositories/recipe_home_repository.dart';

class RecipeHomeRepositoryImpl implements RecipeHomeRepository {
  final RecipeHomeRemoteDataSource remoteDataSource;

  RecipeHomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RecipeMealModel>> getRecipeHomePage() async {
    return await remoteDataSource.getRecipeHomePage();
  }
}
