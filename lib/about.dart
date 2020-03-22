import 'package:flutter/material.dart'; 
import 'package:farm_expense_management/common/ui/pal_title_view.dart';

class About extends StatefulWidget {
  About({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Widget titleWidget = PalTitleView(
    title: "About",
  );
  final primaryColor = const Color(0xFFFFFFFF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleWidget,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.green),
      )
      );
  }
}