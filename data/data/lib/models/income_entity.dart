import 'package:data/models/income_category_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 12)
class IncomeEntity extends HiveObject {
  @HiveField(0)
  final String amount;

  @HiveField(1)
  final IncomeCategoryEntity category;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String description;

  IncomeEntity({
    required this.amount,
    required this.category,
    required this.date,
    required this.description,
  });
}
