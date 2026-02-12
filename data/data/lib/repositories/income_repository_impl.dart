import 'package:domain/data_sources/local_storage_data_source.dart';
import 'package:domain/model/income.dart';
import 'package:domain/repositories/income_repository.dart';

class IncomeRepositoryImpl extends IncomeRepository {
  final LocalStorageDataSource dataSource;

  IncomeRepositoryImpl({required this.dataSource});

  @override
  Future<void> addIncome(Income income) {
    return dataSource.saveIncome(income);
  }

  @override
  Future<List<Income>> getIncomes() {
    return dataSource.getIncomes();
  }

  @override
  Future<void> deleteIncome(int index) {
    return dataSource.deleteIncome(index);
  }

  @override
  Future<void> updateIncome(int index, Income income) {
    return dataSource.updateIncome(index, income);
  }

  @override
  Future<void> clearIncomes() {
    return dataSource.clear(); // do not use, will clear all, not only incomes
  }
}
