import 'package:farm_expense_management/common/database_manager/database_model.dart';
// import 'package:farm_expense_management/common/models/fields.dart';
// import 'package:farm_expense_management/common/models/tag.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';

// import 'package:flutter/rendering.dart';
// // class Date{
// //   int day_n;
// //   int month_n;
// //   int year_n;
// //   Date(this.day_n, this.month_n, this.year_n);
// // }
class LoanItem extends DatabaseModel {
  final int id;
  final String loanTitle;
  final int loanAmount;
  final double emiAmount;
  final int numberOfDays;
  final double annualRoI;
  final DateTime startDate;
  LoanItem({this.id, this.loanTitle, this.loanAmount, this.emiAmount, this.numberOfDays, this.annualRoI, this.startDate});

  @override
  List<String> removeArgs()
  {
    return [id.toString()];
  }
  @override
  String removeQuery() {
    return '_id = ?';
  }
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': loanTitle,
      'loanamount': loanAmount,
      'emiamount': emiAmount,
      'numberofdays': numberOfDays,
      'roi': annualRoI,
      'date': startDate.toIso8601String(),
    };

    if (id != null) {
      map['_id'] = id;
    }
    return map;
  }
}

class LoanTable extends DatabaseTable{
  LoanTable()
      : super(
            'Loans',
            [
              '_id',
              'title',
              'loanamount',
              'emiamount',
              'numberofdays',
              'roi',
              'date'
            ],
            '_id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, loanamount TEXT, emiamount TEXT, numberofdays TEXT, roi TEXT, date TEXT'
      );
  @override
  DatabaseModel entryFromMap(Map map)
  {
    var entry = LoanItem(
      id: map['_id'],
      loanTitle: map['title'],
      loanAmount: int.parse(map['loanamount']),
      emiAmount: double.parse(map['emiamount']),
      numberOfDays: int.parse(map['numberofdays']),
      annualRoI: double.parse(map['roi']),
      startDate: DateTime.parse(map['date'])
    );
    return entry;
  }
}