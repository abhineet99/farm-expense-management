import 'package:flutter/material.dart';
import 'package:farm_expense_management/pages/root_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:farm_expense_management/locale/locale.dart';

bool debug=false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en',""),
        Locale('hi',""),
        Locale('pa',""),
      ],
      onGenerateTitle: (BuildContext context) =>
      AppLocalizations.of(context).title,
      //title: Text(AppLocalizations.of(context).title),//'Farm Expense Management',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RootPage());
  }
}
