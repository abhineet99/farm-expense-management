import 'dart:developer';

import 'package:farm_expense_management/blocs/initialise_fields.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/screens/dashboard/dashboard_page_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/assets.dart';
import 'common/constants.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
          future: dbInitialised(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (!snapshot.data) {
                log('initialising DB');
                initialiseDb();
                InitialiseFields initialiseFields=InitialiseFields();
                initialiseFields.addFieldsData('agriculture');
              } 
              return new DashboardPageFields();
            } else {
              log('No Snapshot Data');
              return Container(
                color: Colors.white,
                child: Image.asset(Assets.logo),
              );
            }
          },
        );

  }

  Future<bool> dbInitialised() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool wasInitialised = prefs.getBool(Constants.PreDefineFields) ?? false;

    return wasInitialised;
  }

  initialiseDb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.PreDefineFields, true);
  }
}

