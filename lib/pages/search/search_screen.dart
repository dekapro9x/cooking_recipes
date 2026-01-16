import 'package:flutter/material.dart';
import 'models/recipe_item.dart';
import 'widgets/search_bar.dart' as custom;
import 'widgets/suggestion_list.dart';
import 'widgets/search_result_grid.dart';
import 'widgets/filter_sheet.dart';

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
              custom.SearchBar(
                controller: _controller,
                onChanged: _onChanged,
                showFilter: _hasResult, // S2 mới hiện filter
                onTapFilter: _openFilter,
              ),
              const SizedBox(height: 14),

              Expanded(
                child: _hasResult
                    ? SearchResultGrid(items: _allItems)
                    : SuggestionList(
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
