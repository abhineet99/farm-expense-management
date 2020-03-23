import 'dart:async';
import 'package:farm_expense_management/common/database_manager/database_manager.dart';
import 'package:farm_expense_management/common/models/expenses.dart';
import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/screens/home/dashboard/filter/filter.dart';
import 'package:rxdart/rxdart.dart';

class ExpensesBloc {
  final _expensesFetcher = BehaviorSubject<FilteredList<Expense>>();
  final manager = DatabaseManager.defaultManager;

  Observable<FilteredList<Expense>> get allExpenses => _expensesFetcher.stream;

  fetchAllExpenses(Field field) async {
    ExpenseTable table = ExpenseTable();
    List<Map> maps = await manager.fetchAllEntriesOf(Expense);
    FilteredList<Expense> expenses = FilteredList();

    maps.forEach((map) {
      Expense expense = table.entryFromMap(map);
      if (field.name==expense.fieldName)
        expenses.add(expense);
    });

    expenses.sort((e1, e2) => e2.date.compareTo(e1.date));

    _expensesFetcher.sink.add(expenses);
  }

  Future<bool> addExpense(Expense expense,Field field) async {
    return manager.insert([expense]).then((value) {
      fetchAllExpenses(field);
    });
  }

  Future<bool> removeExpense(Expense expense,Field field) async {
    return manager.remove([expense]).then((value) {
      fetchAllExpenses(field);
    });
  }

  dispose() {
    _expensesFetcher.close();
  }
}

final expensesBloc = ExpensesBloc();
