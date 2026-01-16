part of 'recipe_home_bloc.dart';

abstract class RecipeHomeEvent extends Equatable {
  const RecipeHomeEvent();

  @override
  List<Object> get props => [];
}

class GetRecipeHomeEvent extends RecipeHomeEvent {}
