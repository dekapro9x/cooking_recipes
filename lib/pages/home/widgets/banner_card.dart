import 'package:dinhhaitrieu/pages/meal_detail/meal_detail_screen.dart';
import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final String imagePath;
  final String mealId;
  final String? title;
  final int? timeCooking;
  final String? authorName;

  const BannerCard({
    super.key,
    required this.imagePath,
    this.mealId = '52772', // Default ID
    this.title,
    this.timeCooking,
    this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(mealId: mealId)),
        );
      },
      child: Container(
        width: 206,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.network(
                    imagePath,
                    height: 140,
                    width: 206,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
                        width: 206,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey),
                      );
                    },
                  ),

                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.white),
                          SizedBox(width: 3),
                          Text(
                            "5",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Positioned.fill(
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
                        child: Icon(Icons.play_arrow, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _formatTimeCooking(timeCooking),
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                      Icon(Icons.favorite_border, size: 18),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    title ?? "Cách chiên trứng một cách cung phu",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("assets/images/avata.png"),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          authorName ?? "Đinh Trọng Phúc",
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeCooking(int? minutes) {
    if (minutes == null) return "Không xác định";

    if (minutes < 60) {
      return "$minutes phút";
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return "$hours tiếng";
      } else {
        return "$hours tiếng $remainingMinutes phút";
      }
    }
  }
}
