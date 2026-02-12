import 'package:domain/model/transaction.dart';

abstract class LocalStorageDataSource {
  Future<void> saveTransaction(Transaction transaction);
  Future<List<Transaction>> getTransactions();
  Future<void> deleteTransaction(int index);
  Future<void> updateTransaction(int index, Transaction transaction);
  Future<void> clear();
}