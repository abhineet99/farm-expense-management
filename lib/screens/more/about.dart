import 'package:flutter/material.dart'; 
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:farm_expense_management/locale/locale.dart';

class About extends StatefulWidget {
  About({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  final primaryColor = const Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PalTitleView(
                            title: Text(AppLocalizations.of(context).about).data,
                           ),
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
          Align(
            alignment: Alignment.center,
            child: Text("\nDeveloped by Abhineet, Bhawna and Mehakjot (cse '21)"),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('\nUnder the guidance of Dr. Puneet Goyal'),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('\nCourse Project - Development Engineering, IIT Ropar'),
          ),

        ]
        
      ),
      );
  }
}