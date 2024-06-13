import 'package:expense_repository/expense_repository.dart';

class Category {
  String name;
  String categoryId;
  int totalExpenses;
  String icon;
  int color;

  Category(
      {required this.name,
      required this.categoryId,
      required this.totalExpenses,
      required this.icon,
      required this.color});

  static final empty =
      Category(name: '', categoryId: '', totalExpenses: 0, icon: '', color: 0);

  CategoryEntity toEntity() {
    return CategoryEntity(
        name: name,
        categoryId: categoryId,
        totalExpenses: totalExpenses,
        icon: icon,
        color: color);
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
        name: entity.name,
        categoryId: entity.categoryId,
        totalExpenses: entity.totalExpenses,
        icon: entity.icon,
        color: entity.color);
  }
}
