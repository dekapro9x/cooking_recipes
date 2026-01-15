import 'package:flutter/material.dart';
import 'banner_card.dart';

class BannerList extends StatelessWidget {
  const BannerList();

  @override
  Widget build(BuildContext context) {
    final items = [
      "assets/images/banner1.jpg",
      "assets/images/banner1.jpg",
      "assets/images/banner1.jpg",
    ];

    return SizedBox(
      height: 252,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return BannerCard(imagePath: items[index]);
        },
      ),
    );
  }
}
