class CategoryEntity {
  String name;
  String categoryId;
  int totalExpenses;
  String icon;
  int color;

  CategoryEntity(
      {required this.name,
      required this.categoryId,
      required this.totalExpenses,
      required this.icon,
      required this.color});

  Map<String, Object?> toDocument() {
    return {
      'name': name,
      'categoryId': categoryId,
      'totalExpenses': totalExpenses,
      'icon': icon,
      'color': color
    };
  }

  static CategoryEntity fromDocument(Map<String, dynamic> doc) {
    return CategoryEntity(
        name: doc['name'] as String,
        categoryId: doc['categoryId'] as String,
        totalExpenses: doc['totalExpenses'] as int,
        icon: doc['icon'] as String,
        color: doc['color']);
  }
}
