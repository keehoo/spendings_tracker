import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 10)
enum TransactionCategoryEntity {
  @HiveField(0)
  grocery,

  @HiveField(1)
  bill,

  @HiveField(2)
  treats,

  @HiveField(3)
  electronics,

  @HiveField(4)
  none,
}