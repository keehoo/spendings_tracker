import 'package:domain/model/transaction_category.dart';

class Transaction {
  final String amount;
  final TransactionCategory category;
  final DateTime date;
  final String description;

  Transaction({
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });
}
