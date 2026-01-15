import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:flutter/material.dart';

class RecentRecipeCard extends StatelessWidget {
  final String imagePath; // asset ảnh món ăn
  final String title; // "Trứng chiên"
  final String authorName; // "Nguyễn Đình Trọng"
  final String authorAvatar; // asset avatar (hoặc để rỗng)

  const RecentRecipeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.authorName,
    required this.authorAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 133,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              imagePath,
              width: 133,
              height: 133,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.primary900,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: authorAvatar.isEmpty
                    ? null
                    : AssetImage(authorAvatar),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  authorName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary950,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
