import 'package:data/models/transaction_category_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 11)
class TransactionEntity extends HiveObject {
  @HiveField(0)
  final String amount;

  @HiveField(1)
  final TransactionCategoryEntity category;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String description;

  TransactionEntity({
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });
}
