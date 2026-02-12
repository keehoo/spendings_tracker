import 'package:domain/model/income.dart';

abstract class IncomeRepository {
  Future<void> addIncome(Income income);
  Future<List<Income>> getIncomes();
  Future<void> deleteIncome(int index);
  Future<void> updateIncome(int index, Income income);
  Future<void> clearIncomes();
}