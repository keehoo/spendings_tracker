import 'package:data/models/income_category_entity.dart';
import 'package:data/models/income_entity.dart';
import 'package:data/models/transaction_category_entity.dart';
import 'package:data/models/transaction_entity.dart';
import 'package:domain/data_sources/local_storage_data_source.dart';
import 'package:domain/model/income.dart';
import 'package:domain/model/income_category.dart';
import 'package:domain/model/transaction.dart';
import 'package:domain/model/transaction_category.dart';
import 'package:hive_flutter/adapters.dart';

class LocalStorageDataSourceImpl extends LocalStorageDataSource {
  final Box<TransactionEntity> transactionBox;
  final Box<IncomeEntity> incomeBox;

  LocalStorageDataSourceImpl({
    required this.transactionBox,
    required this.incomeBox,
  });

  @override
  Future<void> saveTransaction(Transaction transaction) async {
    final entity = _TransactionMapper.toEntity(transaction);
    await transactionBox.add(entity);
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    return transactionBox.values
        .map((entity) => _TransactionMapper.toDomain(entity))
        .toList();
  }

  @override
  Future<void> deleteTransaction(int index) async {
    await transactionBox.deleteAt(index);
  }

  @override
  Future<void> updateTransaction(int index, Transaction transaction) async {
    final entity = _TransactionMapper.toEntity(transaction);
    await transactionBox.putAt(index, entity);
  }

  @override
  Future<void> clear() async {
    await transactionBox.clear();
  }

  // ---------- Income CRUD ----------
  @override
  Future<void> saveIncome(Income income) async {
    final entity = _IncomeMapper.toEntity(income);
    await incomeBox.add(entity);
  }

  @override
  Future<List<Income>> getIncomes() async {
    return incomeBox.values.map(_IncomeMapper.toDomain).toList();
  }

  @override
  Future<void> deleteIncome(int index) async {
    await incomeBox.deleteAt(index);
  }

  @override
  Future<void> updateIncome(int index, Income income) async {
    final entity = _IncomeMapper.toEntity(income);
    await incomeBox.putAt(index, entity);
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

class _IncomeMapper {
  static IncomeEntity toEntity(Income income) {
    return IncomeEntity(
      amount: income.amount,
      category: _IncomeCategoryMapper.toEntity(income.category),
      date: income.date,
      description: income.description,
    );
  }

  static Income toDomain(IncomeEntity entity) {
    return Income(
      amount: entity.amount,
      category: _IncomeCategoryMapper.toDomain(entity.category),
      date: entity.date,
      description: entity.description,
    );
  }
}

class _IncomeCategoryMapper {
  static IncomeCategoryEntity toEntity(IncomeCategory category) {
    return IncomeCategoryEntity.values[category.index];
  }

  static IncomeCategory toDomain(IncomeCategoryEntity entity) {
    return IncomeCategory.values[entity.index];
  }
}
