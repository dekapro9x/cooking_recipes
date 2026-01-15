import 'package:dinhhaitrieu/pages/home/widgets/recent_recipe_card.dart';
import 'package:flutter/material.dart';

class RecentSection extends StatelessWidget {
  const RecentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(6, (i) => i);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 189,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return RecentRecipeCard(
                imagePath: "assets/images/food1.jpg",
                title: "Trứng chiên",
                authorName: "Nguyễn Đình Trọng",
                authorAvatar: "assets/images/avata.png",
              );
            },
          ),
        ),
      ],
    );
  }
}
