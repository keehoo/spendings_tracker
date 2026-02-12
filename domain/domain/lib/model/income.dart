import 'package:domain/model/financial_operation.dart';
import 'package:domain/model/income_category.dart';

class Income implements FinancialOperation{
  @override
  final String amount;
  final IncomeCategory category;
  final DateTime date;
  @override
  final String description;

  Income({
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });
}
