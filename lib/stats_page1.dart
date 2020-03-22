import 'package:flutter/material.dart'; 
import 'package:farm_expense_management/screens/home/stats/stats_page.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class StatsPage1 extends StatefulWidget {
  StatsPage1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StatsPage1State createState() => _StatsPage1State();
}

class _StatsPage1State extends State<StatsPage1> {
  Widget build(BuildContext context) {
      return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFffffff),
        child: MaterialApp(
          home: Material(
            type: MaterialType.transparency,
            child: StatsPage(),
          ),
        ),
      );
    }
}