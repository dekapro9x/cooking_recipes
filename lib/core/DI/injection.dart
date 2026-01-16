import 'package:dinhhaitrieu/core/config/app_config.dart';
import 'package:dinhhaitrieu/core/network/api_client_public.dart';
import 'package:dinhhaitrieu/features/data/datasources/meals_remote_datasource.dart';
import 'package:dinhhaitrieu/features/data/datasources/recipe_home_remote_datasource.dart';
import 'package:dinhhaitrieu/features/data/repositories/meals_repository_impl.dart';
import 'package:dinhhaitrieu/features/data/repositories/recipe_home_repository_impl.dart';
import 'package:dinhhaitrieu/features/domain/repositories/meals_repository.dart';
import 'package:dinhhaitrieu/features/domain/repositories/recipe_home_repository.dart';
import 'package:dinhhaitrieu/features/domain/usecases/get_categories.dart';
import 'package:dinhhaitrieu/features/domain/usecases/get_meal_detail.dart';
import 'package:dinhhaitrieu/features/domain/usecases/get_recipe_home.dart';
import 'package:dinhhaitrieu/features/domain/usecases/search_meals.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/home/categoriesBloc/categories_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_detail_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_search_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/recipe_home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> setupDI() async {
  final appConfig = AppConfig(
    baseUrl: 'https://696a54653a2b2151f847cce9.mockapi.io',
  );

  sl.registerSingleton<AppConfig>(appConfig);

  // DioClient
  sl.registerLazySingleton(() => DioClient(sl<AppConfig>().baseUrl));

  // PublicApiClient
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton(
    () => PublicApiClient(sl<AppConfig>().baseUrl, sl<SharedPreferences>()),
  );

  // datasource
  sl.registerLazySingleton<MealsRemoteDataSource>(
    () => MealsRemoteDataSourceImpl(sl<DioClient>()),
  );

  // repo
  sl.registerLazySingleton<MealsRepository>(
    () => MealsRepositoryImpl(sl<MealsRemoteDataSource>()),
  );

  // usecases
  sl.registerLazySingleton(() => SearchMeals(sl<MealsRepository>()));
  sl.registerLazySingleton(() => GetMealDetail(sl<MealsRepository>()));

  // blocs
  sl.registerFactory(() => MealSearchBloc(sl<SearchMeals>()));
  sl.registerFactory(() => MealDetailBloc(sl<GetMealDetail>()));

  // usecases
  sl.registerLazySingleton(() => GetCategories(sl<MealsRepository>()));

  // blocs
  sl.registerFactory(() => CategoriesBloc(sl<GetCategories>()));

  // Recipe Home Page
  sl.registerLazySingleton<RecipeHomeRemoteDataSource>(
    () => RecipeHomeRemoteDataSourceImpl(sl<PublicApiClient>()),
  );

  sl.registerLazySingleton<RecipeHomeRepository>(
    () => RecipeHomeRepositoryImpl(sl<RecipeHomeRemoteDataSource>()),
  );

  sl.registerLazySingleton(() => GetRecipeHome(sl<RecipeHomeRepository>()));

  sl.registerFactory(() => RecipeHomeBloc(getRecipeHome: sl<GetRecipeHome>()));
}
