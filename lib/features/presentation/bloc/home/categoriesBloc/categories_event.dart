abstract class CategoriesEvent {
  CategoriesEvent();
}

class CategoriesStarted extends CategoriesEvent {
  CategoriesStarted();
}

class CategoriesSelected extends CategoriesEvent {
  final String categoryName;
  CategoriesSelected(this.categoryName);
}
