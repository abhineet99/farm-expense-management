import 'package:farm_expense_management/blocs/loans_bloc.dart';
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/common/models/loan_item.dart';
import 'package:flutter/cupertino.dart';

import 'package:farm_expense_management/locale/locale.dart';
class AddLoanPage extends StatefulWidget {
  @override
  _AddLoanPageState createState() => _AddLoanPageState();
}

class _AddLoanPageState extends State<AddLoanPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController =
      TextEditingController();
  final TextEditingController laController =
      TextEditingController();
  final TextEditingController eaController =
      TextEditingController();
  final TextEditingController ndController =
      TextEditingController();
  final TextEditingController roiController =
      TextEditingController();
  final TextEditingController sdController =
      TextEditingController();
  List<LoanItem> items = [];
  final primaryColor = const Color(0xFFFFFFFF);
  @override
  void dispose(){
    titleController.dispose();
    eaController.dispose();
    laController.dispose();
    ndController.dispose();
    roiController.dispose();
    sdController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: PalTitleView(
          title: Text(AppLocalizations.of(context).addLoan).data,
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
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).loanTitle).data,
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return Text(AppLocalizations.of(context).valLoanTitle).data;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: laController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).loanAmount).data,
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return Text(AppLocalizations.of(context).valLoanAmount).data;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: eaController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).installAmount).data,
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return Text(AppLocalizations.of(context).valInsAmount).data;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: ndController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).installIntervalDays).data,
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return Text(AppLocalizations.of(context).valInsInterval).data;
                          }
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
                          {
                            return Text(AppLocalizations.of(context).valRoi).data;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: sdController,
                        decoration: InputDecoration(
                          hintText: Text(AppLocalizations.of(context).installmentStartDate).data,
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return Text(AppLocalizations.of(context).valInsStartDate).data;
                          }
                        },
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: PalButton(
                        title: Text(AppLocalizations.of(context).add).data,
                        width: MediaQuery.of(context).size.width *(2.0/3.0),
                        colors: [Colors.green[900],Colors.green[900]],
                        onPressed: ()async {
                          if(!_formKey.currentState.validate())
                          return;
                          String _str = sdController.text;
                          List<String> _list = _str.split('/');
                          _str = _list[2]+"-"+_list[1]+"-"+_list[0];
                          print('_str: '+_str);
                          LoanItem loan = LoanItem(
                            loanTitle: titleController.text,
                            loanAmount: int.parse(laController.text),
                            emiAmount: double.parse(eaController.text),
                            numberOfDays: int.parse(ndController.text),
                            annualRoI: double.parse(roiController.text),
                            startDate: DateTime.parse(_str)
                          );
                          loansBloc.addLoan(loan);
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  
}