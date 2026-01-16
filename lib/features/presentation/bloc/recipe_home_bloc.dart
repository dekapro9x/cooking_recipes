import 'package:bloc/bloc.dart';
import 'package:dinhhaitrieu/features/data/model/home/respon_recipe_home_page.dart';
import 'package:dinhhaitrieu/features/domain/usecases/get_recipe_home.dart';
import 'package:equatable/equatable.dart';

part 'recipe_home_event.dart';
part 'recipe_home_state.dart';

class RecipeHomeBloc extends Bloc<RecipeHomeEvent, RecipeHomeState> {
  final GetRecipeHome getRecipeHome;

  RecipeHomeBloc({required this.getRecipeHome}) : super(RecipeHomeInitial()) {
    on<GetRecipeHomeEvent>(_onGetRecipeHome);
  }

  Future<void> _onGetRecipeHome(
    GetRecipeHomeEvent event,
    Emitter<RecipeHomeState> emit,
  ) async {
    emit(RecipeHomeLoading());
    try {
      final recipes = await getRecipeHome();
      emit(RecipeHomeLoaded(recipes));
    } catch (e) {
      emit(RecipeHomeError(e.toString()));
    }
  }
}
