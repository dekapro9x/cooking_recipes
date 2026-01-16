import 'package:flutter/material.dart';

class ChipWrap extends StatelessWidget {
  final List<String> items;
  final Set<String> selected;
  final void Function(String value) onTap;

  const ChipWrap({
    super.key,
    required this.items,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items.map((text) {
        final isSelected = selected.contains(text);
        return InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: () => onTap(text),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFBFA021) : Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isSelected ? const Color(0xFFBFA021) : Colors.black12,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
