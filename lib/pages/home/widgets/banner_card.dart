import 'package:dinhhaitrieu/pages/detail/detailScreen.dart';
import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final String imagePath;
  final String mealId;

  const BannerCard({
    super.key,
    required this.imagePath,
    this.mealId = '52772', // Default ID
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
                  Image.asset(
                    imagePath,
                    height: 140,
                    width: 206,
                    fit: BoxFit.cover,
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
                children: const [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "1 tiếng 20 phút",
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                      Icon(Icons.favorite_border, size: 18),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Cách chiên trứng một cách cung phu",
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
                          "Đinh Trọng Phúc",
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
}
