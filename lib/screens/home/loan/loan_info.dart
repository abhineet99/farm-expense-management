import 'package:flutter/material.dart'; 
import 'package:farm_expense_management/common/ui/pal_title_view.dart';

class LoanInfo extends StatefulWidget {
  LoanInfo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoanInfoState createState() => _LoanInfoState();
}

class _LoanInfoState extends State<LoanInfo> {
  Widget titleWidget = PalTitleView(
    title: "Loan Info",
  );
  final primaryColor = const Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleWidget,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text('---- Farm Expense Management v1.0.0 ----'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 8.0, 15, 30),
            child: Text("\nRelevant Information and Links regarding Loan from Banks and Government policies"),
          ),

        ]
        
      ),
      );
  }
}