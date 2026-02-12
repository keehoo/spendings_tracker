import 'package:domain/model/financial_operation.dart';
import 'package:domain/model/transaction_category.dart';

typedef Spending = Transaction;

class Transaction implements FinancialOperation {
  @override
  final String amount;
  final TransactionCategory category;
  final DateTime date;
  @override
  final String description;

  Transaction({
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });
}
