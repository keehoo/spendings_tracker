import 'package:bloc/bloc.dart';
import 'package:domain/model/transaction.dart';
import 'package:domain/usecases/save_transaction.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {

  final SaveTransaction saveTransaction;
  HomePageCubit(this.saveTransaction) : super(HomePageInitial());

  void addTransaction(Transaction transaction) {
    saveTransaction(transaction);
  }
}
