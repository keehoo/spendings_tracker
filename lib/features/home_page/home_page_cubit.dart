import 'package:domain/model/financial_operation.dart';
import 'package:domain/model/income.dart';
import 'package:domain/model/transaction.dart';
import 'package:domain/usecases/income_usecases.dart';
import 'package:domain/usecases/save_transaction.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final SaveTransaction _saveTransaction;
  final SaveIncome _saveIncome;
  final GetTransactions _getTransactions;
  final GetIncomes _getIncomes;

  HomePageCubit({
    required SaveTransaction saveTransaction,
    required GetTransactions getTransactions,
    required GetIncomes getIncomes,
    required SaveIncome saveIncome,
  }) : _getTransactions = getTransactions,
       _saveTransaction = saveTransaction,
       _saveIncome = saveIncome,
       _getIncomes = getIncomes,
       super(HomePageState());

  Future<void> addTransaction(Transaction transaction) async {
    await _saveTransaction(transaction);
    getAllTransactions();
  }

  Future<void> getAllTransactions() async {
    final transaction = await _getTransactions();
    final incomes = await _getIncomes();
    List<FinancialOperation> operations = [];

    if (state.selectedFilteringTab?.contains(FilteringOption.all) ?? false) {
      operations.addAll(transaction);
      operations.addAll(incomes);
    } else if (state.selectedFilteringTab?.contains(
          FilteringOption.spendings,
        ) ??
        false) {
      operations.addAll(transaction);
    } else if (state.selectedFilteringTab?.contains(FilteringOption.earnings) ??
        false) {
      operations.addAll(incomes);
    } else {
      // no op ?
      // TODO: decide what to do when no filtering options is selected
      operations.addAll(transaction);
      operations.addAll(incomes);
    }

    emit(state.copyWith(transactions: operations));
  }

  void addIncome(Income income) {
    _saveIncome(income);
    getAllTransactions();
  }

  void changeTab(Set<FilteringOption> value) {
    emit(state.copyWith(selectedFilteringTab: value));
    getAllTransactions();
  }
}
