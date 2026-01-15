import 'package:dinhhaitrieu/features/domain/repositories/meals_repository.dart';

class GetCategories {
  final MealsRepository repository;

  GetCategories(this.repository);

  Future<List<String>> call() async {
    return await repository.getCategories();
  }
}
