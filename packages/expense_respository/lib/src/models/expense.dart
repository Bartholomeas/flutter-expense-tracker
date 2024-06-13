import 'package:expense_repository/expense_repository.dart';

class Expense {
  int amount;
  DateTime date;
  Category category;
  String expenseId;

  Expense({
    required this.amount,
    required this.date,
    required this.category,
    required this.expenseId,
  });

  static final empty = Expense(
      amount: 0, date: DateTime.now(), category: Category.empty, expenseId: '');

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      amount: amount,
      date: date,
      category: category,
      expenseId: expenseId,
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      amount: entity.amount,
      date: entity.date,
      category: entity.category,
      expenseId: entity.expenseId,
    );
  }
}
