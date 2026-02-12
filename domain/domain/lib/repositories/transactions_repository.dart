import 'package:domain/data_sources/local_storage_data_source.dart';
import 'package:domain/model/transaction.dart';

abstract class TransactionsRepository {
  final LocalStorageDataSource dataSource;

  TransactionsRepository({required this.dataSource});

  Future<void> addTransaction(Transaction transaction);

  Future<List<Transaction>> getTransactions();

  Future<void> deleteTransaction(int index);

  Future<void> updateTransaction(int index, Transaction transaction);

  Future<void> clearTransactions();
}
