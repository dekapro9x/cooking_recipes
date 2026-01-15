abstract class CategoriesState {
  CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  CategoriesInitial();
}

class CategoriesLoading extends CategoriesState {
  CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  final List<String> categories;
  final int selectedIndex;
  CategoriesLoaded({required this.categories, required this.selectedIndex});

  String get selectedCategory =>
      categories.isEmpty ? '' : categories[selectedIndex];

  CategoriesLoaded copyWith({List<String>? categories, int? selectedIndex}) {
    final newCategories = categories ?? this.categories;
    var newSelectedIndex = selectedIndex ?? this.selectedIndex;
    if (newCategories.isEmpty) {
      newSelectedIndex = 0;
    } else if (newSelectedIndex < 0) {
      newSelectedIndex = 0;
    } else if (newSelectedIndex >= newCategories.length) {
      newSelectedIndex = 0;
    }
    return CategoriesLoaded(
      categories: newCategories,
      selectedIndex: newSelectedIndex,
    );
  }
}

class CategoriesError extends CategoriesState {
  final String error;
  CategoriesError(this.error);
}
