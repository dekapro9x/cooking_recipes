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
