part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  final List<FinancialOperation>? transactions;
  final Set<FilteringOption>? selectedFilteringTab;

  const HomePageState({this.transactions, this.selectedFilteringTab});

  HomePageState copyWith({
    List<FinancialOperation>? transactions,
    Set<FilteringOption>? selectedFilteringTab,
  }) {
    return HomePageState(
      transactions: transactions ?? this.transactions,
      selectedFilteringTab: selectedFilteringTab ?? this.selectedFilteringTab,
    );
  }

  @override
  List<Object?> get props =>  [transactions, selectedFilteringTab];
}

enum FilteringOption { spendings, earnings, all }
