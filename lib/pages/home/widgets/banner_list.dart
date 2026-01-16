import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dinhhaitrieu/features/presentation/bloc/recipe_home_bloc.dart';
import 'banner_card.dart';

class BannerList extends StatefulWidget {
  const BannerList();

  @override
  State<BannerList> createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeHomeBloc>().add(GetRecipeHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeHomeBloc, RecipeHomeState>(
      builder: (context, state) {
        if (state is RecipeHomeLoading) {
          return const SizedBox(
            height: 252,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is RecipeHomeError) {
          return SizedBox(
            height: 252,
            child: Center(child: Text('Error: ${state.message}')),
          );
        }

        if (state is RecipeHomeLoaded) {
          return SizedBox(
            height: 252,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.recipes.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final recipe = state.recipes[index];
                return BannerCard(
                  imagePath: recipe.avatar,
                  mealId: recipe.id,
                  title: recipe.title,
                  timeCooking: recipe.timeCooking,
                  authorName: recipe.name,
                );
              },
            ),
          );
        }

        return const SizedBox(
          height: 252,
          child: Center(child: Text('No data available')),
        );
      },
    );
  }
}
