import 'package:flutter/material.dart';
import 'package:farm_expense_management/pages/root_page.dart';

bool debug=false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Farm Expense Management',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage());
  }
}
