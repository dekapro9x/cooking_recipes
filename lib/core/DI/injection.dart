import 'package:dinhhaitrieu/features/data/datasources/meals_remote_datasource.dart';
import 'package:dinhhaitrieu/features/data/repositories/meals_repository_impl.dart';
import 'package:dinhhaitrieu/features/domain/repositories/meals_repository.dart';
import 'package:dinhhaitrieu/features/domain/usecases/get_categories.dart';
import 'package:dinhhaitrieu/features/domain/usecases/get_meal_detail.dart';
import 'package:dinhhaitrieu/features/domain/usecases/search_meals.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/categoriesBloc/categories_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_detail_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/meal_search_bloc.dart';
import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> setupDI() async {
  // core
  sl.registerLazySingleton(() => DioClient());

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
}
