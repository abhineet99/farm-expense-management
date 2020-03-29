
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'dart:math';
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
    double to_ret = (rate1*principal*months*1.0)/100;
    return to_ret;
  }
  double calculateCompoundInterest(int principal, int rate, int months)
  {
    //print('check32');
    double amount = principal*pow(1+(rate*1.0)/1200,months);
    double to_ret = amount-principal;
    return to_ret;
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
          title: "Calculate Interest Amount",
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
                          hintText: "Principal Amount",
                        ),
                        validator: (value){
                          if(value.isEmpty)
                            return "Please Enter Principal Amount";
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
                            return "Please Enter Rate of Interest";
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: monthsController,
                        decoration: InputDecoration(
                          hintText: "Loan Duration in Months",
                        ),
                        validator: (value){
                          if(value.isEmpty)
                            return "Please Enter Loan Duration";
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    ListTile(
                      title: Text('Total Amount Payable',
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
                      title: Text('Interest Amount',
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
                      title: const Text('Simple Interest'),
                      leading: Radio(
                        value: 0,
                        groupValue: selectedOption,
                        onChanged: (int value) {
                          setState(() { selectedOption = value; });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Compound Interest'),
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
                        title: "Calculate",
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