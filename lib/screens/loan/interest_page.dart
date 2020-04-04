
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'dart:math';
import 'package:farm_expense_management/locale/locale.dart';
class InterestPage extends StatefulWidget{
  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage>{
  double interest =0;
  double amount = 0;
  int selectedOption=0;// 0 = simple interest, 1 = compound interest
  double calculateSimpleInterest(int principal, int rate, int months)
  {
    print('check32');
    double rate1 = (rate*1.0)/12;
    double toRet = (rate1*principal*months*1.0)/100;
    return toRet;
  }
  double calculateCompoundInterest(int principal, int rate, int months)
  {
    //print('check32');
    double amount = principal*pow(1+(rate*1.0)/1200,months);
    double toRet = amount-principal;
    return toRet;
  }
  final primaryColor = const Color(0xFFFFFFFF);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController princController =
      TextEditingController();
  final TextEditingController roiController =
      TextEditingController();
  final TextEditingController monthsController =
      TextEditingController();
  @override
  void dispose() {
    princController.dispose();
    roiController.dispose();
    monthsController.dispose();
    super.dispose();
  }
  void _onPressed()
  {
    double _interest=0;
    if (selectedOption == 0)
      _interest = calculateSimpleInterest(int.parse(princController.text), int.parse(roiController.text), int.parse(monthsController.text));
    else
      _interest = calculateCompoundInterest(int.parse(princController.text), int.parse(roiController.text), int.parse(monthsController.text));
    setState(() {
      amount = int.parse(princController.text) + _interest;
      interest = _interest;
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: PalTitleView(
          title: Text(AppLocalizations.of(context).calInterestAmount).data,
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.green[600]),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: TextFormField(
                        controller: princController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).principalAmount).data,
                        ),
                        validator: (value){
                          if(value.isEmpty)
                            return Text(AppLocalizations.of(context).valPrincipalAmount).data;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: roiController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).roi).data,
                        ),
                        validator: (value){
                          if(value.isEmpty)
                            return Text(AppLocalizations.of(context).valRoi).data;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: monthsController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).loanDuration).data,
                        ),
                        validator: (value){
                          if(value.isEmpty)
                            return Text(AppLocalizations.of(context).valLoanDuration).data;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).totalAmountPayable,
                      style: TextStyle(
                        fontSize: 16.0
                      ),
                      ),
                      subtitle: Text('INR: '+amount.toString(), 
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 18.0
                      ),),
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).interestAmount,
                      style: TextStyle(
                        fontSize: 16.0
                      ),
                      ),
                      subtitle: Text('INR: '+interest.toString(), 
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 18.0
                      ),),
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).simpleInterest), //this variable was const before localization
                      leading: Radio(
                        value: 0,
                        groupValue: selectedOption,
                        onChanged: (int value) {
                          setState(() { selectedOption = value; });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).compoundInterest), //this variable was const before localization
                      leading: Radio(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (int value) {
                          setState(() { selectedOption = value; });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: PalButton(
                        title: Text(AppLocalizations.of(context).calculate).data,
                        width: MediaQuery.of(context).size.width * (2.0/3.0),
                        colors: [Colors.green[900], Colors.green[900]],
                        onPressed: _onPressed
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}