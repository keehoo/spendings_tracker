part of 'home_page_cubit.dart';

class HomePageState {
  final List<FinancialOperation>? transactions;
  final Set<FilteringOption>? selectedFilteringTab;

  HomePageState({this.transactions, this.selectedFilteringTab});

  HomePageState copyWith({
    List<FinancialOperation>? transactions,
    Set<FilteringOption>? selectedFilteringTab,
  }) {
    return HomePageState(
      transactions: transactions ?? this.transactions,
      selectedFilteringTab: selectedFilteringTab ?? this.selectedFilteringTab,
    );
  }
}


enum FilteringOption {
  spendings, earnings, all
}