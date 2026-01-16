part of 'recipe_home_bloc.dart';

abstract class RecipeHomeState extends Equatable {
  const RecipeHomeState();

  @override
  List<Object> get props => [];
}

class RecipeHomeInitial extends RecipeHomeState {}

class RecipeHomeLoading extends RecipeHomeState {}

class RecipeHomeLoaded extends RecipeHomeState {
  final List<RecipeMealModel> recipes;

  const RecipeHomeLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeHomeError extends RecipeHomeState {
  final String message;

  const RecipeHomeError(this.message);

  @override
  List<Object> get props => [message];
}
