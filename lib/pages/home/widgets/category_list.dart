import 'package:dinhhaitrieu/pages/home/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return const CategoryCard(
            title: "Trứng chiên",
            author: "Trần Đình Trọng",
            imagePath: "assets/images/banner2.jpg",
            time: "20 phút",
          );
        },
      ),
    );
  }
}
