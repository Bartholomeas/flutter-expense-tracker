import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import '../models/models.dart';

class ExpenseEntity {
  int amount;
  DateTime date;
  Category category;
  String expenseId;

  ExpenseEntity({
    required this.amount,
    required this.date,
    required this.category,
    required this.expenseId,
  });

  Map<String, Object?> toDocument() {
    return {
      'amount': amount,
      'date': date,
      'category': category.toEntity().toDocument(),
      'expenseId': expenseId,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      amount: doc['amount'],
      date: (doc['date'] as Timestamp).toDate(),
      category:
          Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
      expenseId: doc['expenseId'],
    );
  }
}
