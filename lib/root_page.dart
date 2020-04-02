import 'dart:developer';
import 'package:farm_expense_management/common/database_manager/initialise_fields.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/screens/dashboard/dashboard_page_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/constants.dart';

class RootPage extends StatefulWidget{
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  Future createDb()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool wasInitialised = prefs.getBool(Constants.PreDefinedFields) ?? false;
    if(!wasInitialised){
      log('initialising db');
      initialiseDb();
      InitialiseFields initialiseFields=InitialiseFields();
      initialiseFields.addFieldsData('agriculture'); 
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDb();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new DashboardPageFields();
  }

  initialiseDb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.PreDefinedFields, true);
  }
}

