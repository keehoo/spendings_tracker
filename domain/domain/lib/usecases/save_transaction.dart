import 'package:domain/model/transaction.dart';
import 'package:domain/repositories/transactions_repository.dart';

class SaveTransaction {
  final TransactionsRepository transactionsRepository;

  SaveTransaction(this.transactionsRepository);

  Future<void> call(Transaction transaction) async {
    return transactionsRepository.addTransaction(transaction);
  }
}
class GetTransactions {
  final TransactionsRepository repository;

  GetTransactions(this.repository);

  Future<List<Transaction>> call() {
    return repository.getTransactions();
  }
}

class DeleteTransaction {
  final TransactionsRepository repository;

  DeleteTransaction(this.repository);

  Future<void> call(int index) {
    return repository.deleteTransaction(index);
  }
}

class UpdateTransaction {
  final TransactionsRepository repository;

  UpdateTransaction(this.repository);

  Future<void> call(int index, Transaction transaction) {
    return repository.updateTransaction(index, transaction);
  }
}

class ClearTransactions {
  final TransactionsRepository repository;

  ClearTransactions(this.repository);

  Future<void> call() {
    return repository.clearTransactions();
  }
}