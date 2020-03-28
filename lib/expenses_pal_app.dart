import 'dart:async';

import 'package:farm_expense_management/common/constants.dart';
import 'package:farm_expense_management/MyApp.dart';
import 'package:farm_expense_management/screens/onboarding/onboarding_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/assets.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:farm_expense_management/locale/locale.dart';

class ExpansesPalApp extends StatelessWidget {
  final loginPage = MyApp();
  final onboarding = OnboardingPage();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

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
              print('case1');
              if (snapshot.data) {
                print('case1a');
                return loginPage;  //login page from MyApp.dart
              } else {
                print('case1b');
                showOnboarding();
                return onboarding;
              }
            } else {
              print('case2');
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
