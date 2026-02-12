import 'package:data/models/transaction_category_entity.dart';
import 'package:data/models/transaction_entity.dart';
import 'package:domain/data_sources/local_storage_data_source.dart';
import 'package:domain/model/transaction.dart';
import 'package:domain/model/transaction_category.dart';
import 'package:hive_flutter/adapters.dart';

class LocalStorageDataSourceImpl extends LocalStorageDataSource {
  final Box<TransactionEntity> box;

  LocalStorageDataSourceImpl({required this.box});

  @override
  Future<void> saveTransaction(Transaction transaction) async {
    final entity = _TransactionMapper.toEntity(transaction);
    await box.add(entity);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    return box.values
        .map((entity) => _TransactionMapper.toDomain(entity))
        .toList();
  }

  @override
  Future<void> deleteTransaction(int index) async {
    await box.deleteAt(index);
  }

  @override
  Future<void> updateTransaction(int index, Transaction transaction) async {
    final entity = _TransactionMapper.toEntity(transaction);
    await box.putAt(index, entity);
  }

  @override
  Future<void> clear() async {
    await box.clear();
  }
}

// TODO: move to seperate file
class _TransactionCategoryMapper {
  static TransactionCategoryEntity toEntity(TransactionCategory category) {
    // Map domain enum to data entity enum
    return TransactionCategoryEntity.values[category.index];
  }

  static TransactionCategory toDomain(TransactionCategoryEntity entity) {
    // Map data entity enum to domain enum
    return TransactionCategory.values[entity.index];
  }
}

// TODO: move to seperate file
class _TransactionMapper {
  static TransactionEntity toEntity(Transaction transaction) {
    return TransactionEntity(
      amount: transaction.amount,
      category: _TransactionCategoryMapper.toEntity(transaction.category),
      date: transaction.date,
      description: transaction.description,
    );
  }

  static Transaction toDomain(TransactionEntity entity) {
    return Transaction(
      amount: entity.amount,
      category: _TransactionCategoryMapper.toDomain(entity.category),
      date: entity.date,
      description: entity.description,
    );
  }
}
