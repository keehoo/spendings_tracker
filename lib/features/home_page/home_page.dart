import 'package:domain/model/financial_operation.dart';
import 'package:domain/model/income.dart';
import 'package:domain/model/income_category.dart';
import 'package:domain/model/transaction.dart';
import 'package:domain/model/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendings_tracker/features/home_page/home_page_cubit.dart';
import 'package:spendings_tracker/theme_cubit.dart';
import 'package:spendings_tracker/widgets/category_selector.dart';
import 'package:spendings_tracker/widgets/income_category_selector.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageState>(
      listenWhen: (p, c) => false, // disable listener for now
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              _getSpendingsSummary(context, state.transactions),
              _getEarningsSummary(context, state.transactions),
              _getBalanceSummary(context, state.transactions),
            ],
            title: Text('Home Page'),
          ),

          body: Column(
            children: [
              SegmentedButton(
                onSelectionChanged: (Set<FilteringOption> value) {
                  context.read<HomePageCubit>().changeTab(value);
                },
                segments: [
                  ButtonSegment(
                    value: FilteringOption.earnings,
                    label: Text("earnings"),
                  ),
                  ButtonSegment(
                    value: FilteringOption.spendings,
                    label: Text("spendings"),
                  ),
                  ButtonSegment(value: FilteringOption.all, label: Text("all")),
                ],
                selected: state.selectedFilteringTab ?? {FilteringOption.all},
              ),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, themeState) {
                  return SegmentedButton(
                    onSelectionChanged: (Set<ThemeMode> value) {
                      context.read<ThemeCubit>().changeMode(value);
                    },
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text("system"),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text("light"),
                      ),
                      ButtonSegment(value: ThemeMode.dark, label: Text("dark")),
                    ],
                    selected: {themeState.themeMode ?? ThemeMode.system},
                  );
                },
              ),
              Expanded(
                // TODO: @kubicki - should use ListView.builder
                child: ListView(
                  shrinkWrap: true,
                  children: (state.transactions ?? []).map((transaction) {
                    return ListTile(
                      title: Text(
                        "${transaction.amount} ${transaction is Spending ? "spent" : "earned"}  ",
                      ),
                    );
                  }).toList(),
                ),
              ),
              Wrap(
                children: [
                  ListTile(
                    onTap: () => _addTransaction(context),
                    title: Text("add spending"),
                  ),
                  ListTile(
                    onTap: () => _addIncome(context),
                    title: Text("add income"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addTransaction(BuildContext context) async {
    final transaction = await showModalBottomSheet<Transaction>(
      context: context,
      isScrollControlled: true,
      builder: (c) {
        final controller = TextEditingController();
        TransactionCategory? transactionCategory;
        DateTime dateTime = DateTime.now();

        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(c).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Add transaction"),

                const SizedBox(height: 16),

                TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Amount spent",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1990),
                      lastDate: dateTime,
                      initialDate: dateTime,
                    );
                    dateTime = date ?? DateTime.now();
                  },
                  child: Text("set date"),
                ),
                CategorySelector(
                  onCategorySelected: (TransactionCategory? cat) {
                    transactionCategory = cat;
                  },
                ),

                const SizedBox(height: 16),

                FilledButton(
                  onPressed: () {
                    if (double.tryParse(controller.text) == null) {
                      return;
                    }

                    final transaction = Transaction(
                      amount: controller.text,
                      category:
                          transactionCategory ??
                          TransactionCategory.none, // pick default
                      date: dateTime,
                      description: "null",
                    );

                    Navigator.of(c).pop(transaction);
                  },
                  child: const Text("Add transaction"),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (context.mounted && transaction != null) {
      // Navigator.of(context).pop();
      context.read<HomePageCubit>().addTransaction(transaction);
    }
  }

  Future<void> _addIncome(BuildContext context) async {
    final income = await showModalBottomSheet<Income>(
      context: context,
      isScrollControlled: true,
      builder: (c) {
        final controller = TextEditingController();
        IncomeCategory? incomeCategory;
        DateTime dateTime = DateTime.now();

        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(c).viewInsets.bottom + 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Add Earning"),

                const SizedBox(height: 16),

                TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Amount earned",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1990),
                      lastDate: dateTime,
                      initialDate: dateTime,
                    );
                    dateTime = date ?? DateTime.now();
                  },
                  child: Text("set date"),
                ),
                IncomeCategorySelector(
                  onCategorySelected: (IncomeCategory? cat) {
                    incomeCategory = cat;
                  },
                ),

                const SizedBox(height: 16),

                FilledButton(
                  onPressed: () {
                    if (double.tryParse(controller.text) == null) {
                      return;
                    }

                    final income = Income(
                      amount: controller.text,
                      category:
                          incomeCategory ??
                          IncomeCategory.other, // pick default
                      date: dateTime,
                      description: "null",
                    );

                    Navigator.of(c).pop(income);
                  },
                  child: const Text("Add earning"),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (context.mounted && income != null) {
      context.read<HomePageCubit>().addIncome(income);
    }
  }

  // TODO: @kubicki - move to cubit
  Widget _getSpendingsSummary(
    BuildContext context,
    List<FinancialOperation>? transactions,
  ) {
    final sum = (transactions ?? []).whereType<Spending>().fold<double>(
      0.0,
      (total, e) => total + (double.tryParse(e.amount) ?? 0.0),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Spent: \n${sum.toStringAsFixed(2)}"),
    );
  }

  // TODO: @kubicki - move to cubit
  Widget _getEarningsSummary(
    BuildContext context,
    List<FinancialOperation>? transactions,
  ) {
    final sum = (transactions ?? []).whereType<Income>().fold<double>(
      0.0,
      (total, e) => total + (double.tryParse(e.amount) ?? 0.0),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Earned: \n${sum.toStringAsFixed(2)}"),
    );
  }

  Widget _getBalanceSummary(
    BuildContext context,
    List<FinancialOperation>? transactions,
  ) {
    final double earnings = (transactions ?? [])
        .whereType<Income>()
        .fold<double>(
          0.0,
          (total, e) => total + (double.tryParse(e.amount) ?? 0.0),
        );
    final double spendings = (transactions ?? [])
        .whereType<Spending>()
        .fold<double>(
          0.0,
          (total, e) => total + (double.tryParse(e.amount) ?? 0.0),
        );

    final result = earnings - spendings;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Balance: \n${result.toStringAsFixed(2)}"),
    );
  }
}
