import 'dart:async';
import 'dart:developer';
import 'package:farm_expense_management/common/constants.dart';
import 'package:farm_expense_management/root_page.dart';
import 'package:farm_expense_management/screens/onboarding/onboarding_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/assets.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:farm_expense_management/locale/locale.dart';

class MyApp extends StatelessWidget {
  final homePage = new RootPage();
  final onboarding = OnboardingPage();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
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
      home: Material(
        
        type: MaterialType.transparency,
        child: FutureBuilder<bool>(
          future: onboardingShown(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              log('case1');
              if (snapshot.data) {
                log('case1a');
                return homePage;  //home page from MyApp.dart
              } else {
                print('case1b');
                showOnboarding();
                return onboarding;
              }
            } else {
              log('case2');
              return Container(
                color: Colors.white,
                child: Image.asset(Assets.logo),
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> onboardingShown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool wasShown = prefs.getBool(Constants.OnboardingShown) ?? false;

    return wasShown;
  }

  showOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.OnboardingShown, true);
  }
}
