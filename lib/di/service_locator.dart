import 'package:data/data.dart';
import 'package:data/data_sources/local_storage_data_source_impl.dart';
import 'package:data/hive_adapters/income_adapter.dart';
import 'package:data/hive_adapters/income_category_adapter.dart';
import 'package:data/hive_adapters/transaction_adapter.dart';
import 'package:data/hive_adapters/transaction_category_adapter.dart';
import 'package:data/models/income_entity.dart';
import 'package:data/repositories/income_repository_impl.dart';
import 'package:domain/data_sources/local_storage_data_source.dart';
import 'package:domain/repositories/income_repository.dart';
import 'package:domain/repositories/transactions_repository.dart';
import 'package:domain/usecases/income_usecases.dart';
import 'package:domain/usecases/save_transaction.dart';
import 'package:get_it/get_it.dart';

import 'package:data/models/transaction_entity.dart';
import 'package:data/repositories/transactions_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TransactionCategoryEntityAdapter());
  Hive.registerAdapter(TransactionEntityAdapter());

  Hive.registerAdapter(IncomeCategoryEntityAdapter());
  Hive.registerAdapter(IncomeEntityAdapter());

  final transactionBox = await Hive.openBox<TransactionEntity>('transactions');
  final incomeBox = await Hive.openBox<IncomeEntity>('incomes');

  sl.registerSingleton<Box<TransactionEntity>>(transactionBox);
  sl.registerSingleton<Box<IncomeEntity>>(incomeBox);

  sl.registerLazySingleton<LocalStorageDataSource>(
    () => LocalStorageDataSourceImpl(
      transactionBox: sl<Box<TransactionEntity>>(),
      incomeBox: sl<Box<IncomeEntity>>(),
    ),
  );

  sl.registerLazySingleton<TransactionsRepository>(
    () => TransactionsRepositoryImpl(dataSource: sl<LocalStorageDataSource>()),
  );
  sl.registerLazySingleton<IncomeRepository>(
    () => IncomeRepositoryImpl(dataSource: sl<LocalStorageDataSource>()),
  );

  sl.registerFactory(() => SaveTransaction(sl<TransactionsRepository>()));
  sl.registerFactory(() => SaveIncome(sl<IncomeRepository>()));
  sl.registerFactory(() => GetTransactions(sl<TransactionsRepository>()));
  sl.registerFactory(() => GetIncomes(sl<IncomeRepository>()));
}
