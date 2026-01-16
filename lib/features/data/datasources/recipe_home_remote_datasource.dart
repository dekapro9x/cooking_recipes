import 'package:dinhhaitrieu/core/network/api_client_public.dart';
import 'package:dinhhaitrieu/features/data/model/home/respon_recipe_home_page.dart';

abstract class RecipeHomeRemoteDataSource {
  Future<List<RecipeMealModel>> getRecipeHomePage();
}

class RecipeHomeRemoteDataSourceImpl implements RecipeHomeRemoteDataSource {
  final PublicApiClient apiClient;

  RecipeHomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<RecipeMealModel>> getRecipeHomePage() async {
    final response = await apiClient.get(
      '/api/v1/featured_recipe_list/recipe_home_page',
    );

    if (response.data == null) {
      throw Exception('No data received from API');
    }

    return RecipeMealModel.listFromJson(response.data as List<dynamic>);
  }
}
