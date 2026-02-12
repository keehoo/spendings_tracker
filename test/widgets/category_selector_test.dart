import 'package:domain/model/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spendings_tracker/widgets/category_selector.dart';

// Import your widget
// import 'package:your_app/widgets/category_selector.dart';

void main() {
  group('CategorySelector Widget Tests', () {
    testWidgets('renders all transaction categories', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CategorySelector(onCategorySelected: (_) {})),
        ),
      );

      // Assert - verify all categories are rendered
      expect(find.text('Grocery'), findsOneWidget);
      expect(find.text('Bill'), findsOneWidget);
      expect(find.text('Treats'), findsOneWidget);
      expect(find.text('Electronics'), findsOneWidget);
      expect(find.text('none'), findsOneWidget);
    });

    testWidgets('renders correct number of RadioListTile widgets', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CategorySelector(onCategorySelected: (_) {})),
        ),
      );

      // Assert
      expect(
        find.byType(RadioListTile<TransactionCategory>),
        findsNWidgets(TransactionCategory.values.length),
      );
    });

    testWidgets('initially no category is selected', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CategorySelector(onCategorySelected: (_) {})),
        ),
      );

      // Assert - find all radio buttons and verify none are selected
      final radioButtons = tester
          .widgetList<RadioListTile<TransactionCategory>>(
            find.byType(RadioListTile<TransactionCategory>),
          );

      for (final radio in radioButtons) {
        expect(radio.groupValue, isNull);
      }
    });

    testWidgets('selecting a category updates the UI', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CategorySelector(onCategorySelected: (_) {})),
        ),
      );

      // Act - tap on Grocery category
      await tester.tap(find.text('Grocery'));
      await tester.pumpAndSettle();

      // Assert - verify Grocery is selected
      final groceryRadio = tester.widget<RadioListTile<TransactionCategory>>(
        find.ancestor(
          of: find.text('Grocery'),
          matching: find.byType(RadioListTile<TransactionCategory>),
        ),
      );
      expect(groceryRadio.groupValue, TransactionCategory.grocery);
    });

    testWidgets('selecting a category triggers callback with correct value', (
      WidgetTester tester,
    ) async {
      // Arrange
      TransactionCategory? selectedCategory;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorySelector(
              onCategorySelected: (cat) {
                selectedCategory = cat;
              },
            ),
          ),
        ),
      );

      // Act - tap on Bill category
      await tester.tap(find.text('Bill'));
      await tester.pumpAndSettle();

      // Assert
      expect(selectedCategory, TransactionCategory.bill);
    });

    testWidgets('selecting multiple categories in sequence updates selection', (
      WidgetTester tester,
    ) async {
      // Arrange
      TransactionCategory? selectedCategory;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorySelector(
              onCategorySelected: (cat) {
                selectedCategory = cat;
              },
            ),
          ),
        ),
      );

      // Act & Assert - select Grocery
      await tester.tap(find.text('Grocery'));
      await tester.pumpAndSettle();
      expect(selectedCategory, TransactionCategory.grocery);

      // Act & Assert - select Treats
      await tester.tap(find.text('Treats'));
      await tester.pumpAndSettle();
      expect(selectedCategory, TransactionCategory.treats);

      // Act & Assert - select Electronics
      await tester.tap(find.text('Electronics'));
      await tester.pumpAndSettle();
      expect(selectedCategory, TransactionCategory.electronics);
    });

    testWidgets('only one category can be selected at a time', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CategorySelector(onCategorySelected: (_) {})),
        ),
      );

      // Act - select Grocery
      await tester.tap(find.text('Grocery'));
      await tester.pumpAndSettle();

      // Act - select Bill
      await tester.tap(find.text('Bill'));
      await tester.pumpAndSettle();

      // Assert - verify only Bill is selected
      final radioButtons = tester
          .widgetList<RadioListTile<TransactionCategory>>(
            find.byType(RadioListTile<TransactionCategory>),
          );

      int selectedCount = 0;
      TransactionCategory? selected;

      for (final radio in radioButtons) {
        if (radio.value == radio.groupValue) {
          selectedCount++;
          selected = radio.value;
        }
      }

      expect(selectedCount, 1);
      expect(selected, TransactionCategory.bill);
    });

    testWidgets('callback is called every time a category is selected', (
      WidgetTester tester,
    ) async {
      // Arrange
      int callbackCount = 0;
      final List<TransactionCategory?> selectedCategories = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorySelector(
              onCategorySelected: (cat) {
                callbackCount++;
                selectedCategories.add(cat);
              },
            ),
          ),
        ),
      );

      // Act - select multiple categories
      await tester.tap(find.text('Grocery'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Bill'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Treats'));
      await tester.pumpAndSettle();

      // Assert
      expect(callbackCount, 3);
      expect(selectedCategories, [
        TransactionCategory.grocery,
        TransactionCategory.bill,
        TransactionCategory.treats,
      ]);
    });

    testWidgets('all radio buttons are tappable', (WidgetTester tester) async {
      // Arrange
      final selectedCategories = <TransactionCategory>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorySelector(
              onCategorySelected: (cat) {
                if (cat != null) selectedCategories.add(cat);
              },
            ),
          ),
        ),
      );

      // Act - tap each category
      for (final category in TransactionCategory.values) {
        final label = _getLabelForCategory(category);
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
      }

      // Assert
      expect(selectedCategories.length, TransactionCategory.values.length);
      expect(selectedCategories.toSet(), TransactionCategory.values.toSet());
    });

    testWidgets('widget rebuilds correctly when parent rebuilds', (
      WidgetTester tester,
    ) async {
      // Arrange
      TransactionCategory? selectedCategory;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorySelector(
              key: const Key('category_selector_1'),
              onCategorySelected: (cat) {
                selectedCategory = cat;
              },
            ),
          ),
        ),
      );

      // Act - select a category
      await tester.tap(find.text('Grocery'));
      await tester.pumpAndSettle();
      expect(selectedCategory, TransactionCategory.grocery);

      // Act - trigger rebuild with a NEW key (forces new state)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorySelector(
              key: const Key('category_selector_2'), // Different key
              onCategorySelected: (cat) {
                selectedCategory = cat;
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - selection should be reset with new widget instance
      final radioButtons = tester
          .widgetList<RadioListTile<TransactionCategory>>(
            find.byType(RadioListTile<TransactionCategory>),
          );

      for (final radio in radioButtons) {
        expect(radio.groupValue, isNull);
      }
    });
    testWidgets('categories are displayed in a Column', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CategorySelector(onCategorySelected: (_) {})),
        ),
      );

      // Assert
      expect(find.byType(Column), findsOneWidget);

      final column = tester.widget<Column>(find.byType(Column));
      expect(column.children.length, TransactionCategory.values.length);
    });
  });

  group('CategorySelector Edge Cases', () {
    testWidgets('handles rapid taps correctly', (WidgetTester tester) async {
      // Arrange
      final selectedCategories = <TransactionCategory?>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategorySelector(
              onCategorySelected: (cat) {
                selectedCategories.add(cat);
              },
            ),
          ),
        ),
      );

      // Act - rapid taps on same category
      await tester.tap(find.text('Grocery'));
      await tester.tap(find.text('Grocery'));
      await tester.tap(find.text('Grocery'));
      await tester.pumpAndSettle();

      // Assert - all taps should register the same category
      expect(selectedCategories.length, 3);
      expect(
        selectedCategories.every((cat) => cat == TransactionCategory.grocery),
        isTrue,
      );
    });

    testWidgets('selecting same category twice keeps it selected', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CategorySelector(onCategorySelected: (_) {})),
        ),
      );

      // Act
      await tester.tap(find.text('Bill'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bill'));
      await tester.pumpAndSettle();

      // Assert
      final billRadio = tester.widget<RadioListTile<TransactionCategory>>(
        find.ancestor(
          of: find.text('Bill'),
          matching: find.byType(RadioListTile<TransactionCategory>),
        ),
      );
      expect(billRadio.groupValue, TransactionCategory.bill);
    });
  });
}

// Helper function to match the widget's _label method
String _getLabelForCategory(TransactionCategory category) {
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
      return 'none';
  }
}
