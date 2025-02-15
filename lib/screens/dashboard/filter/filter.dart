import 'dart:collection';

import 'package:farm_expense_management/common/helpers.dart';
import 'package:farm_expense_management/common/models/expenses.dart';
import 'package:farm_expense_management/common/models/tag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:farm_expense_management/locale/locale.dart';

abstract class ExpenseFilter {
  bool filter(Expense expense);
}

enum DateFilterType { today, yesterday, week, month, year, custom }

String DateFilterTypeName(BuildContext context,DateFilterType typeObj){
  if(typeObj==DateFilterType.today)
     return  Text(AppLocalizations.of(context).today).data;
  else  if(typeObj==DateFilterType.yesterday)
     return  Text(AppLocalizations.of(context).yesterday).data;
  else  if(typeObj==DateFilterType.week)
     return  Text(AppLocalizations.of(context).lastWeek).data;
  else  if(typeObj==DateFilterType.month)
     return  Text(AppLocalizations.of(context).lastMonth).data;
  else  if(typeObj==DateFilterType.year)
    return  Text(AppLocalizations.of(context).lastYear).data;
  else
    return "Custom";
}

class DateFilter extends ExpenseFilter {
  final DateTime dateTime;
  final DateFilterType type;

  DateFilter({@required this.type, this.dateTime});

  @override
  bool filter(Expense expense) {
    var today = DateTime.now();
    switch (type) {
      case DateFilterType.today:
        return DateHelper.isSameDay(expense.date, today);
        break;
      case DateFilterType.yesterday:
        return DateHelper.isSameDay(
            expense.date, today.add(Duration(days: -1)));
        break;
      case DateFilterType.week:
        return DateHelper.isSameDay(expense.date, today) ||
            (expense.date.isBefore(today) &&
                expense.date.isAfter(today.add(Duration(days: -7))));
        break;
      case DateFilterType.month:
        return DateHelper.isSameDay(expense.date, today) ||
            (expense.date.isBefore(today) &&
                expense.date.isAfter(today.add(Duration(days: -31))));
        break;
      case DateFilterType.year:
        return DateHelper.isSameDay(expense.date, today) ||
            (expense.date.isBefore(today) &&
                expense.date.isAfter(today.add(Duration(days: -351))));
        break;
      case DateFilterType.custom:
        return expense.date.isBefore(dateTime);
        break;
    }

    return true;
  }
}

class KeywordFilter extends ExpenseFilter {
  String keyword;

  KeywordFilter({@required this.keyword});

  @override
  bool filter(Expense expense) {
    keyword=keyword.toLowerCase();
    bool contains = false;
    if (expense.title != null) {
      contains = contains || expense.title.toLowerCase().contains(keyword);
    }

    if (expense.description != null) {
      contains = contains || expense.description.toLowerCase().contains(keyword);
    }

    if (expense.currency != null) {
      contains = contains || expense.currency.toLowerCase().contains(keyword);
    }

    if (expense.amount != null) {
      contains = contains || expense.amount.toString().toLowerCase().contains(keyword);
    }
    return contains;
  }
}


class TagFilter extends ExpenseFilter {
  final List<Tag> tags;

  TagFilter({@required this.tags});

  @override
  bool filter(Expense expense) {
    bool contains = false;
    if (expense.tags.isNotEmpty) {
      for(Tag filterTag in tags){
        contains = contains || expense.tags.contains(filterTag);
      }
    }
    return contains;
  }
}


class FilteredList<E> extends ListBase<E> {
  List innerList = List();

  int get length => innerList.length;

  set length(int length) {
    innerList.length = length;
  }

  void operator []=(int index, E value) {
    innerList[index] = value;
  }

  E operator [](int index) => innerList[index];

  void add(E value) => innerList.add(value);

  void addAll(Iterable<E> all) => innerList.addAll(all);

  FilteredList<Expense> applyFilters(List<ExpenseFilter> f) {
    var newList = innerList.where((item) {
      return f.length > 0
          ? f.fold(true, (value, element) => value && element.filter(item))
          : true;
    }).toList();

    FilteredList<Expense> filteredExpenses = FilteredList();
    newList.forEach((item) => filteredExpenses.add(item));
    return filteredExpenses;
  }
}

class FilterBloc {
  final _filtersFetcher = BehaviorSubject<List<ExpenseFilter>>();
  Observable<List<ExpenseFilter>> get filters => _filtersFetcher.stream;

  fetchInitialFilters() async {
    setFilters([]);
  }

  dispose() {
    _filtersFetcher.close();
  }

  void setFilters(List<ExpenseFilter> filters) async {
    _filtersFetcher.sink.add(filters);
  }
}

final filtersBloc = FilterBloc();
