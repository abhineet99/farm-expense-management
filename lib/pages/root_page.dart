import 'package:flutter/material.dart';
import 'package:farm_expense_management/screens/home/dashboard/dashboard_page_fields.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  Widget build(BuildContext context) {

          return DashboardPageFields();

  }
}

