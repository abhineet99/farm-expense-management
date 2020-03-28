import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:farm_expense_management/l10n/messages_all.dart';

import 'dart:async';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message(
      'Farm expense management',
      name: 'title',
      desc: 'Title for the Weather Application',
    );
  }

  String get greeting {
    return Intl.message(
      'Welcome',
      name: 'greeting',
      desc: 'Greeting in drawer',
    );
  }
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Home in drawer',
    );
  }
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: 'about in drawer',
    );
  }
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: 'title in categories page',
    );
  }
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: 'title and button in add expense/category page',
    );
  }
  String get expenseTitle {
    return Intl.message(
      'Title',
      name: 'expenseTitle',
      desc: 'expense_title',
    );
  }
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: 'expense amount',
    );
  }
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: 'expense description',
    );
  }
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: 'dashboard button',
    );
  }
  String get stats {
    return Intl.message(
      'Stats',
      name: 'stats',
      desc: 'stats button and stats page title',
    );
  }
  String get noStatsMsg {
    return Intl.message(
      'You have to add some expenses before you can see statistics',
      name: 'noStatsMsg',
      desc: 'noStatsMsg',
    );
  }
  String get compare {
    return Intl.message(
      'Compare To',
      name: 'compare',
      desc: 'compare in stats',
    );
  }
  String get prevMonth {
    return Intl.message(
      'Previous Month',
      name: 'prevMonth',
      desc: 'prevMonth in stats',
    );
  }
  String get allTimeAvg {
    return Intl.message(
      'All Time Average',
      name: 'allTimeAvg',
      desc: 'allTimeAvg in stats',
    );
  }
  String get thisMonth {
    return Intl.message(
      'This Month',
      name: 'thisMonth',
      desc: 'this month in stats',
    );
  }
  String get avgPerDay {
    return Intl.message(
      'Avg. per day',
      name: 'avgPerDay',
      desc: 'average per day in stats',
    );
  }
  String get name_1 {
    return Intl.message(
      'Name',
      name: 'name_1',
      desc: 'translucent Name in add category',
    );
  }
  String get tag_1{
    return Intl.message(
      'Tag',
      name: 'tag_1',
      desc: 'translucent tag in add category / expense',
    );
  }
  String get noTagMsg{
    return Intl.message(
      'No tags yet. Add tags by typing in the field above. To confirm it just press Return or type a comma.',
      name: 'noTagMsg',
      desc: 'no tag message in add category/expense page',
    );
  }
  String get noTagsYet{
    return Intl.message(
      'No tags yet',
      name: 'noTagsYet',
      desc: 'no tag yet message in add category/expense page',
    );
  }
  String get date_1{
    return Intl.message(
      'Date',
      name: 'date_1',
      desc: 'Date in add category/expense page',
    );
  }
  String get filter_1{
    return Intl.message(
      'Filter',
      name: 'filter_1',
      desc: 'Filter title in filter',
    );
  }
  String get apply_1{
    return Intl.message(
      'Apply',
      name: 'apply_1',
      desc: 'apply button text in filter',
    );
  }
  String get keyWord_1{
    return Intl.message(
      'Keyword',
      name: 'keyWord_1',
      desc: 'hint text in filter',
    );
  }
  String get today{
    return Intl.message(
      'Today',
      name: 'today',
      desc: 'drop down menu in filter',
    );
  }
  String get yesterday{
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: 'drop down menu in filter',
    );
  }
  String get lastWeek{
    return Intl.message(
      'Last Week',
      name: 'lastWeek',
      desc: 'drop down menu in filter',
    );
  }
  String get lastMonth{
    return Intl.message(
      'Last Month',
      name: 'lastMonth',
      desc: 'drop down menu in filter',
    );
  }
  String get lastYear{
    return Intl.message(
      'Last Year',
      name: 'lastYear',
      desc: 'drop down menu in filter',
    );
  }

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'pa'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}