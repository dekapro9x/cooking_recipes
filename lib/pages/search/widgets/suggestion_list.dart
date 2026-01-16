import 'package:flutter/material.dart';

class SuggestionList extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onTapItem;

  const SuggestionList({
    super.key,
    required this.items,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () => onTapItem(items[i]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(items[i], style: const TextStyle(fontSize: 14)),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Color(0xFFBFA021),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
