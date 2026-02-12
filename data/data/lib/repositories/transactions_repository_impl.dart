import 'package:domain/model/transaction.dart';
import 'package:domain/repositories/transactions_repository.dart';

class TransactionsRepositoryImpl extends TransactionsRepository {
  TransactionsRepositoryImpl({required super.dataSource});

  @override
  Future<void> addTransaction(Transaction transaction) {
    return dataSource.saveTransaction(transaction);
  }

  @override
  Future<List<Transaction>> getTransactions() {
    return dataSource.getTransactions();
  }

  @override
  Future<void> deleteTransaction(int index) {
    return dataSource.deleteTransaction(index);
  }

  @override
  Future<void> updateTransaction(int index, Transaction transaction) {
    return dataSource.updateTransaction(index, transaction);
  }

  @override
  Future<void> clearTransactions() {
    return dataSource.clear();
  }
}
