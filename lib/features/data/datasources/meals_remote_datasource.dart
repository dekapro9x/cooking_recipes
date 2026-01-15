import 'package:dinhhaitrieu/features/data/model/meal_detail_model.dart';
import 'package:dinhhaitrieu/features/data/model/meal_model.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';

abstract class MealsRemoteDataSource {
  Future<List<MealModel>> searchMeals(String query);
  Future<MealDetailModel> getMealDetail(String id);
  Future<List<String>> getCategories();
}

class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final DioClient client;
  MealsRemoteDataSourceImpl(this.client);

  @override
  Future<List<MealModel>> searchMeals(String query) async {
    final res = await client.dio.get(
      "search.php",
      queryParameters: {"s": query},
    );
    final data = res.data as Map<String, dynamic>;

    final meals = data["meals"];
    if (meals == null) return [];

    return (meals as List)
        .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MealDetailModel> getMealDetail(String id) async {
    final res = await client.dio.get("lookup.php", queryParameters: {"i": id});
    final data = res.data as Map<String, dynamic>;
    final meals = data["meals"] as List?;
    if (meals == null || meals.isEmpty) {
      throw DioException(
        requestOptions: res.requestOptions,
        message: "Meal not found",
      );
    }
    return MealDetailModel.fromJson(meals.first as Map<String, dynamic>);
  }

  @override
  Future<List<String>> getCategories() async {
    final res = await client.dio.get("categories.php");
    final data = res.data as Map<String, dynamic>;
    final list = data["categories"] as List?;
    if (list == null) return [];
    return list
        .map(
          (e) => (e as Map<String, dynamic>)["strCategory"]?.toString() ?? "",
        )
        .where((name) => name.trim().isNotEmpty)
        .toList();
  }
}
