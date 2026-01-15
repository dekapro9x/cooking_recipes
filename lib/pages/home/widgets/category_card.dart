import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String author;
  final String imagePath;
  final String time;

  const CategoryCard({
    super.key,
    required this.title,
    required this.author,
    required this.imagePath,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 213,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 40,
            child: Container(
              width: 150,
              height: 173,
              padding: const EdgeInsets.fromLTRB(12, 48, 12, 12),
              decoration: BoxDecoration(
                color: AppColors.miscellaneousTintedFill,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Tạo bởi\n$author",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.neuture950,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.neuture950,
                        ),
                      ),
                      const Icon(Icons.chat_bubble_outline, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(radius: 40, backgroundImage: AssetImage(imagePath)),
        ],
      ),
    );
  }
}
