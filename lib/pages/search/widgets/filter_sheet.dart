import 'package:flutter/material.dart';
import '../models/filter_result.dart';
import 'filter_group.dart';
import 'chip_wrap.dart';

Future<FilterResult?> openFilterSheet(BuildContext context) {
  return showModalBottomSheet<FilterResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const FilterSheet(),
  );
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => FilterSheetState();
}

class FilterSheetState extends State<FilterSheet> {
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
                      FilterGroup(
                        icon: Icons.bookmark_border,
                        title: "Danh mục",
                        child: ChipWrap(
                          items: catItems,
                          selected: _cat,
                          onTap: (v) => _toggle(_cat, v),
                        ),
                      ),
                      const SizedBox(height: 18),
                      FilterGroup(
                        icon: Icons.restaurant_menu,
                        title: "Nguyên liệu",
                        child: ChipWrap(
                          items: ingItems,
                          selected: _ing,
                          onTap: (v) => _toggle(_ing, v),
                        ),
                      ),
                      const SizedBox(height: 18),
                      FilterGroup(
                        icon: Icons.location_on_outlined,
                        title: "Khu vực",
                        child: ChipWrap(
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
