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
  String get noExpensesFilter{
    return Intl.message(
      'There are no expenses with given criteria',
      name: 'noExpensesFilter',
      desc: 'no expenses and filter applied',
    );
  }
  String get noExpenses{
    return Intl.message(
      'Nothing to see here yet. Add an expense after you spend some money.',
      name: 'noExpenses',
      desc: 'no expenses',
    );
  }
  String get manageLoans{
    return Intl.message(
      'Manage Loans',
      name: 'manageLoans',
      desc: 'manageLoans drawer',
    );
  }
  String get loans{
    return Intl.message(
      'Loans',
      name: 'loans',
      desc: 'title loan page',
    );
  }
  String get addLoan{
    return Intl.message(
      'Add Loan',
      name: 'addLoan',
      desc: 'Add loan btn',
    );
  }
  String get loanTitle{
    return Intl.message(
      'Loan Title',
      name: 'loanTitle',
      desc: 'Loan Title',
    );
  }
  String get loanAmount{
    return Intl.message(
      'Loan Amount',
      name: 'loanAmount',
      desc: 'Loan Amount',
    );
  }
  String get installAmount{
    return Intl.message(
      'Installment Amount',
      name: 'installAmount',
      desc: 'installment amount',
    );
  }
  String get choosePredefined{
    return Intl.message(
      'Choose from predefined categories',
      name: 'choosePredefined',
      desc: 'add_field_page',
    );
  }
  String get installIntervalDays{
    return Intl.message(
      'Installment Interval (days)',
      name: 'installIntervalDays',
      desc: 'installment interval',
    );
  }
  String get roi{
    return Intl.message(
      'Annual Rate of Interest',
      name: 'roi',
      desc: 'annual roi',
    );
  }
  String get principalAmount{
    return Intl.message(
      'Principal Amount',
      name: 'principalAmount',
      desc: 'cia page',
    );
  }
  String get valPrincipalAmount{
    return Intl.message(
      'Please Enter Principal Amount',
      name: 'valPrincipalAmount',
      desc: 'cia page',
    );
  }
  String get installmentStartDate{
    return Intl.message(
      'Installment Start Date (DD/MM/YYYY)',
      name: 'installmentStartDate',
      desc: 'start date',
    );
  }
  String get calInterestAmount{
    return Intl.message(
      'Calculate Interest Amount',
      name: 'calInterestAmount',
      desc: 'cal interest amount drawer',
    );
  }
  String get loanDuration{
    return Intl.message(
      'Loan Duration (in Months)',
      name: 'loanDuration',
      desc: 'loan duration in cia',
    );
  }
  String get valLoanDuration{
    return Intl.message(
      'Please Enter Loan Duration (in Months)',
      name: 'valLoanDuration',
      desc: 'loan duration in cia',
    );
  }
  String get totalAmountPayable{
    return Intl.message(
      'Total Amount Payable',
      name: 'totalAmountPayable',
      desc: 'Total Amount Payable',
    );
  }
  String get interestAmount{
    return Intl.message(
      'Interest Amount',
      name: 'interestAmount',
      desc: 'interest amount',
    );
  }
  String get simpleInterest{
    return Intl.message(
      'Simple Interest',
      name: 'simpleInterest',
      desc: 'simple interest',
    );
  }
  String get compoundInterest{
    return Intl.message(
      'Compound Interest',
      name: 'compoundInterest',
      desc: 'Compound interest',
    );
  }
  String get calculate{
    return Intl.message(
      'Calculate',
      name: 'calculate',
      desc: 'calculate',
    );
  }
  String get dateOfIns{
    return Intl.message(
      'Date of Installments with amount to be paid',
      name: 'dateOfIns',
      desc: 'Loan description page',
    );
  }
  String get days_1{
    return Intl.message(
      'days',
      name: 'days_1',
      desc: 'days',
    );
  }
  String get expenses{
    return Intl.message(
      'Expenses',
      name: 'expenses',
      desc: 'onBoarding',
    );
  }
  String get expensesText{
    return Intl.message(
      'Add your expenses and check where you have spend your money',
      name: 'expensesText',
      desc: 'onBoarding',
    );
  }
  String get next_1{
    return Intl.message(
      'NEXT',
      name: 'next_1',
      desc: 'onBoarding',
    );
  }
  String get skip_1{
    return Intl.message(
      'SKIP',
      name: 'skip_1',
      desc: 'onBoarding',
    );
  }
  String get tags_1{
    return Intl.message(
      'tags',
      name: 'tags_1',
      desc: 'onBoarding',
    );
  }
  String get tagsText{
    return Intl.message(
      'Tag your expenses to easily search through them and check where you spend your money the most',
      name: 'tagsText',
      desc: 'onBoarding',
    );
  }
  String get done_1{
    return Intl.message(
      'DONE',
      name: 'done_1',
      desc: 'onBoarding',
    );
  }
  String get statsText{
    return Intl.message(
      'Check stats of your expenses and compare your current month expenses to last month or all-time average',
      name: 'statsText',
      desc: 'onBoarding',
    );
  }
  String get valLoanTitle{
    return Intl.message(
      'Please Enter Loan Title',
      name: 'valLoanTitle',
      desc: 'add loan page',
    );
  }
  String get valLoanAmount{
    return Intl.message(
      'Please Enter Loan Amount',
      name: 'valLoanAmount',
      desc: 'add loan page',
    );
  }
  String get valInsAmount{
    return Intl.message(
      'Please Enter Installment Amount',
      name: 'valInsAmount',
      desc: 'add loan page',
    );
  }
  String get valInsInterval{
    return Intl.message(
      'Please Enter Installment Interval(in days)',
      name: 'valInsInterval',
      desc: 'add loan page',
    );
  }
  String get valRoi{
    return Intl.message(
      'Please Enter Annual Rate of Interest',
      name: 'valRoi',
      desc: 'add loan page',
    );
  }
  String get valInsStartDate{
    return Intl.message(
      'Please Enter Installment Start Date (DD/MM/YYYY)',
      name: 'valInsStartDate',
      desc: 'add loan page',
    );
  }
  String get valEnterName{
    return Intl.message(
      'Please Enter Name',
      name: 'valEnterName',
      desc: 'add category page',
    );
  }
  String get valEnterTitle{
    return Intl.message(
      'Please Enter Title',
      name: 'valEnterTitle',
      desc: 'add expense page',
    );
  }
  String get valEnterAmount{
    return Intl.message(
      'Please Enter Amount',
      name: 'valEnterAmount',
      desc: 'add expense page',
    );
  }
  String get remove_1{
    return Intl.message(
      'REMOVE',
      name: 'remove_1',
      desc: 'remove expense page',
    );
  }
  String get noTags{
    return Intl.message(
      'No tags',
      name: 'noTags',
      desc: 'remove expense page',
    );
  }
  String get noLoans{
    return Intl.message(
      'No loans added yet',
      name: 'noLoans',
      desc: 'loan page',
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