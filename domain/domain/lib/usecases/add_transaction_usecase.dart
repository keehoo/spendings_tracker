import 'package:domain/model/transaction.dart';
import 'package:domain/repositories/transactions_repository.dart';

class AddTransactionUsecase {

  final TransactionsRepository repository;

  AddTransactionUsecase({required this.repository});

  Future<Transaction?> addTransaction({required Transaction transaction}) async {
    repository.addTransaction(transaction);

    return null;}
}