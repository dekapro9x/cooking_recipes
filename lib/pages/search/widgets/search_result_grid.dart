import 'package:flutter/material.dart';
import '../models/recipe_item.dart';
import 'recipe_grid_card.dart';

class SearchResultGrid extends StatelessWidget {
  final List<RecipeItem> items;

  const SearchResultGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => RecipeGridCard(item: items[i]),
    );
  }
}
