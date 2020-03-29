import 'package:farm_expense_management/blocs/loans_bloc.dart';
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/common/models/loan_item.dart';
import 'package:flutter/cupertino.dart';

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
          title: "Add Loan",
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
                          hintText: "Loan Title",
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return "Please Enter Loan Title";
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: laController,
                        decoration: InputDecoration(
                          hintText: "Loan Amount",
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return "Please Enter Loan Amount";
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: eaController,
                        decoration: InputDecoration(
                          hintText: "Installment Amount",
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return "Please Enter Installment Amount";
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: ndController,
                        decoration: InputDecoration(
                          hintText: "Installment Interval (days)",
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return "Please Enter Installment Interval in days";
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: roiController,
                        decoration: InputDecoration(
                          hintText: "Annual Rate of Interest",
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return "Please Enter Annual Rate of Interest";
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: sdController,
                        decoration: InputDecoration(
                          hintText: "Installment Start Date (DD/MM/YYYY)",
                        ),
                        validator: (value){
                          if(value.isEmpty)
                          {
                            return "Please Enter Installment Start Date (DD/MM/YYYY)";
                          }
                        },
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: PalButton(
                        title: "ADD",
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
                            emiAmount: int.parse(eaController.text),
                            numberOfDays: int.parse(ndController.text),
                            annualRoI: int.parse(roiController.text),
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