import 'dart:async';
import 'package:farm_expense_management/common/database_manager/database_manager.dart';
import 'package:farm_expense_management/common/models/loan_item.dart';
import 'package:rxdart/rxdart.dart';

class LoansBloc{
  final _loansFetcher = BehaviorSubject<List<LoanItem>>();
  final manager = DatabaseManager.defaultManager;
  Observable<List<LoanItem>> get allLoans => _loansFetcher.stream;

  fetchAllLoans() async {
    LoanTable table = LoanTable();
    List<Map> maps = await manager.fetchAllEntriesOf(LoanItem);
    List<LoanItem> loans = List();
    maps.forEach((map){
      LoanItem loan = table.entryFromMap(map);
      loans.add(loan);
    }); 

    _loansFetcher.sink.add(loans);
  }
  Future<bool> addLoan(LoanItem loan) async {
    return manager.insert([loan]).then((value){
      fetchAllLoans();
    });

  }
  dispose() {
    _loansFetcher.close();
  }
}

final loansBloc = LoansBloc();