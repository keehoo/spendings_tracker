import 'package:domain/model/income.dart';
import 'package:domain/model/transaction.dart';

abstract class LocalStorageDataSource {
  Future<void> saveTransaction(Transaction transaction);
  Future<List<Transaction>> getTransactions();
  Future<void> deleteTransaction(int index);
  Future<void> updateTransaction(int index, Transaction transaction);
  Future<void> clear();

  Future<void> saveIncome(Income income);
  Future<List<Income>> getIncomes();
  Future<void> deleteIncome(int index);
  Future<void> updateIncome(int index, Income income);
}