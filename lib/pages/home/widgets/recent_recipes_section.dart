import 'package:dinhhaitrieu/features/domain/entities/meal.dart';
import 'package:dinhhaitrieu/pages/home/widgets/recent_recipe_card.dart';
import 'package:flutter/material.dart';

class RecentRecipesSection extends StatelessWidget {
  final List<Meal> recipes;

  const RecentRecipesSection({required this.recipes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 189,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 16),
        itemCount: recipes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final meal = recipes[index];
          return RecentRecipeCard(
            imagePath: meal.thumb.isNotEmpty
                ? meal.thumb
                : "assets/images/food1.jpg",
            title: meal.name,
            authorName: "Chef",
            authorAvatar: "assets/images/avata.png",
          );
        },
      ),
    );
  }
}
