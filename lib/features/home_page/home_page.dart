import 'package:domain/model/transaction.dart';
import 'package:domain/model/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendings_tracker/features/home_page/home_page_cubit.dart';
import 'package:spendings_tracker/features/home_page/home_page_cubit.dart';
import 'package:spendings_tracker/widgets/category_selector.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomePageCubit, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Home Page')),
        body: Column(
          children: [
            ListTile(
              onTap: () => _addTransaction(context),
              title: Text("add transaction"),
            ),
          ],
        ),
      ),
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
      Navigator.of(context).pop();
      context.read<HomePageCubit>().addTransaction(transaction);
    }
  }
}
