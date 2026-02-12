import 'package:domain/model/income_category.dart';
import 'package:flutter/material.dart';

class IncomeCategorySelector extends StatefulWidget {
  const IncomeCategorySelector({super.key, required this.onCategorySelected});

  final void Function(IncomeCategory? cat) onCategorySelected;

  @override
  State<IncomeCategorySelector> createState() => _IncomeCategorySelectorState();
}

class _IncomeCategorySelectorState extends State<IncomeCategorySelector> {
  IncomeCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: IncomeCategory.values.map((category) {
        return RadioListTile<IncomeCategory>(
          title: Text(_label(category)),
          value: category,
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

  String _label(IncomeCategory category) {
    switch (category) {
      case IncomeCategory.salary:
        return 'Salary';
      case IncomeCategory.stocks:
        return 'Stocks';
      case IncomeCategory.dividends:
        return 'Dividends';
      case IncomeCategory.other:
        return 'Other';
    }
  }
}
