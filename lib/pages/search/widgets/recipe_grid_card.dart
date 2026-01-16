import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:flutter/material.dart';
import '../models/recipe_item.dart';

class RecipeGridCard extends StatelessWidget {
  final RecipeItem item;

  const RecipeGridCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210, // theo mẫu (hug ~210)
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Corner/Medium
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== IMAGE (chiếm phần lớn card) =====
              Expanded(
                flex: 130,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(item.image, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 34,
                        width: 34,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.favorite,
                          size: 18,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ===== CONTENT =====
              Expanded(
                flex: 80,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title lớn hơn
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.neuture950,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Row: author (trái) + time (phải)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.author, // ví dụ: "By Little Pony"
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.neuture400,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.access_time_filled,
                            size: 14,
                            color: Color(
                              0xFF6A5ACD,
                            ), // tím giống mẫu, muốn đổi thì đổi
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.time, // "20m"
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.neuture700,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
