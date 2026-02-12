import 'package:data/data.dart';
import 'package:data/data_sources/local_storage_data_source_impl.dart';
import 'package:data/hive_adapters/transaction_adapter.dart';
import 'package:data/hive_adapters/transaction_category_adapter.dart';
import 'package:data/transactions_repository_impl.dart';
import 'package:domain/data_sources/local_storage_data_source.dart';
import 'package:domain/repositories/transactions_repository.dart';
import 'package:domain/usecases/save_transaction.dart';
import 'package:get_it/get_it.dart';

import 'package:data/models/transaction_entity.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TransactionCategoryEntityAdapter());
  Hive.registerAdapter(TransactionEntityAdapter());

  final transactionBox = await Hive.openBox<TransactionEntity>('transactions');

  sl.registerSingleton<Box<TransactionEntity>>(transactionBox);

  sl.registerLazySingleton<LocalStorageDataSource>(
    () => LocalStorageDataSourceImpl(box: sl<Box<TransactionEntity>>()),
  );

  sl.registerLazySingleton<TransactionsRepository>(
    () => TransactionsRepositoryImpl(dataSource: sl<LocalStorageDataSource>()),
  );

  sl.registerFactory(() => SaveTransaction(sl<TransactionsRepository>()));
}
