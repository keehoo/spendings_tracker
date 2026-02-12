import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 13)
enum IncomeCategoryEntity {
  @HiveField(0)
  salary,
  @HiveField(1)
  stocks,
  @HiveField(2)
  dividends,
  @HiveField(3)
  other,
}
