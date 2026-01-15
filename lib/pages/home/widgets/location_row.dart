import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:flutter/material.dart';

class LocationRow extends StatelessWidget {
  const LocationRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "TP. Hồ Chí Minh",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppColors.neuture950,
          ),
        ),
        Text(
          "Xem tất cả",
          style: TextStyle(
            color: AppColors.primary600,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
