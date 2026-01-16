import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool showFilter;
  final VoidCallback onTapFilter;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.showFilter,
    required this.onTapFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE9E9E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.black38, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tìm kiếm",
                      hintStyle: TextStyle(color: Colors.black38),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showFilter) ...[
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onTapFilter,
            child: const Icon(
              Icons.filter_alt,
              size: 26,
              color: Color(0xFFBFA021),
            ),
          ),
        ],
      ],
    );
  }
}
