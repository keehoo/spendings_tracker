import 'package:domain/model/income.dart';
import 'package:domain/repositories/income_repository.dart';

class SaveIncome {
  final IncomeRepository repository;

  SaveIncome(this.repository);

  Future<void> call(Income income) {
    return repository.addIncome(income);
  }
}

class GetIncomes {
  final IncomeRepository repository;

  GetIncomes(this.repository);

  Future<List<Income>> call() {
    return repository.getIncomes();
  }
}

class DeleteIncome {
  final IncomeRepository repository;

  DeleteIncome(this.repository);

  Future<void> call(int index) {
    return repository.deleteIncome(index);
  }
}

class UpdateIncome {
  final IncomeRepository repository;

  UpdateIncome(this.repository);

  Future<void> call(int index, Income income) {
    return repository.updateIncome(index, income);
  }
}

class ClearIncomes {
  final IncomeRepository repository;

  ClearIncomes(this.repository);

  Future<void> call() {
    return repository.clearIncomes();
  }
}
