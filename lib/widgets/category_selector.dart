import 'package:domain/model/transaction_category.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key, required this.onCategorySelected});

  final void Function(TransactionCategory? cat) onCategorySelected;

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  TransactionCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: TransactionCategory.values.map((category) {
        return RadioListTile<TransactionCategory>(
          title: Text(_label(category)),
          value: category,
          // TODO: @kubicki - deal with deprecations
          groupValue: selectedCategory,
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
            widget.onCategorySelected(selectedCategory);
          },
        );
      }).toList(),
    );
  }

  //TODO: @kubicki -  that's bad, need to handle it better
  String _label(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.grocery:
        return 'Grocery';
      case TransactionCategory.bill:
        return 'Bill';
      case TransactionCategory.treats:
        return 'Treats';
      case TransactionCategory.electronics:
        return 'Electronics';
      case TransactionCategory.none:
        return "none";
    }
  }
}
