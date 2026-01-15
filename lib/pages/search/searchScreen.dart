import 'package:dinhhaitrieu/core/theme/colorSystem.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final _controller = TextEditingController();

  // mock gợi ý (S1)
  final List<String> _suggestions = const [
    "Pizza hến xào",
    "Pipi đút lò",
    "Pizza thơm",
    "Pizza hải sản",
    "Pizza thịt xông khói",
  ];

  // mock data (S2)
  final List<RecipeItem> _allItems = List.generate(
    6,
    (i) => RecipeItem(
      title: "Salad bò kiểu Thái",
      author: "By Little Pony",
      time: "20m",
      image: "assets/images/food1.jpg",
    ),
  );

  String _query = "";

  bool get _hasResult => _query.trim().isNotEmpty;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String v) {
    setState(() => _query = v);
  }

  void _onTapSuggestion(String text) {
    _controller.text = text;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
    setState(() => _query = text);
    FocusScope.of(context).unfocus();
  }

  Future<void> _openFilter() async {
    final result = await openFilterSheet(context);
    if (result != null) {
      // TODO: bạn nối filter vào data sau
      debugPrint(
        "Filter: ${result.categories} / ${result.ingredients} / ${result.regions}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2), // nền giống mock
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            children: [
              _SearchBar(
                controller: _controller,
                onChanged: _onChanged,
                showFilter: _hasResult, // S2 mới hiện filter
                onTapFilter: _openFilter,
              ),
              const SizedBox(height: 14),

              Expanded(
                child: _hasResult
                    ? _SearchResultGrid(items: _allItems)
                    : _SuggestionList(
                        items: _suggestions,
                        onTapItem: _onTapSuggestion,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool showFilter;
  final VoidCallback onTapFilter;

  const _SearchBar({
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

class _SuggestionList extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onTapItem;

  const _SuggestionList({required this.items, required this.onTapItem});

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

class _SearchResultGrid extends StatelessWidget {
  final List<RecipeItem> items;
  const _SearchResultGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) => _RecipeGridCard(item: items[i]),
    );
  }
}

class _RecipeGridCard extends StatelessWidget {
  final RecipeItem item;
  const _RecipeGridCard({required this.item});

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

class RecipeItem {
  final String title;
  final String author;
  final String time;
  final String image; // asset path

  RecipeItem({
    required this.title,
    required this.author,
    required this.time,
    required this.image,
  });
}

class FilterResult {
  final Set<String> categories;
  final Set<String> ingredients;
  final Set<String> regions;

  const FilterResult({
    required this.categories,
    required this.ingredients,
    required this.regions,
  });
}

Future<FilterResult?> openFilterSheet(BuildContext context) {
  return showModalBottomSheet<FilterResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _FilterSheet(),
  );
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet();

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  // mặc định giống hình
  final Set<String> _cat = {"Danh mục 1"};
  final Set<String> _ing = {"Thịt gà"};
  final Set<String> _reg = {"Long An"};

  final List<String> catItems = const [
    "Danh mục 1",
    "Danh mục 2",
    "Danh mục 3",
    "Danh mục 4",
  ];
  final List<String> ingItems = const [
    "Thịt gà",
    "Thịt heo",
    "Danh mục",
    "Ức gà",
    "Chân gà",
  ];
  final List<String> regItems = const [
    "TP.HCM",
    "Bình Phước",
    "Đồng Nai",
    "An Giang",
    "Long An",
  ];

  void _reset() {
    setState(() {
      _cat
        ..clear()
        ..add("Danh mục 1");
      _ing
        ..clear()
        ..add("Thịt gà");
      _reg
        ..clear()
        ..add("Long An");
    });
  }

  void _toggle(Set<String> set, String value) {
    setState(() {
      if (set.contains(value)) {
        set.remove(value);
      } else {
        set.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return SizedBox(
      height: h * 0.85,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Text(
                        "Lọc",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _reset,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF6F1DA),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Đặt lại",
                        style: TextStyle(color: Color(0xFFB68B00)),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FilterGroup(
                        icon: Icons.bookmark_border,
                        title: "Danh mục",
                        child: _ChipWrap(
                          items: catItems,
                          selected: _cat,
                          onTap: (v) => _toggle(_cat, v),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _FilterGroup(
                        icon: Icons.restaurant_menu,
                        title: "Nguyên liệu",
                        child: _ChipWrap(
                          items: ingItems,
                          selected: _ing,
                          onTap: (v) => _toggle(_ing, v),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _FilterGroup(
                        icon: Icons.location_on_outlined,
                        title: "Khu vực",
                        child: _ChipWrap(
                          items: regItems,
                          selected: _reg,
                          onTap: (v) => _toggle(_reg, v),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        FilterResult(
                          categories: _cat,
                          ingredients: _ing,
                          regions: _reg,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBFA021),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Xác nhận",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class _FilterGroup extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _FilterGroup({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: Colors.black54),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _ChipWrap extends StatelessWidget {
  final List<String> items;
  final Set<String> selected;
  final void Function(String value) onTap;

  const _ChipWrap({
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
