import 'package:domain/data_sources/local_storage_data_source.dart';
import 'package:domain/model/transaction.dart';

abstract class TransactionsRepository {

  final LocalStorageDataSource dataSource;

  TransactionsRepository({required this.dataSource});
  Future<Transaction?> addTransaction(Transaction transaction);


}