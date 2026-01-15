import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isSeeAll;
  const SectionHeader({super.key, required this.title, required this.isSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppColors.neuture950,
          ),
        ),
        Spacer(),
        isSeeAll
            ? Text(
                "Xem tất cả",
                style: TextStyle(
                  color: AppColors.primary600,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
