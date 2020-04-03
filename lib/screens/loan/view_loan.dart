import 'package:farm_expense_management/common/models/loan_item.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:farm_expense_management/locale/locale.dart';

class Installment{
  String date;
  int e_amount;
  Installment(this.date, this.e_amount);
}
class ViewLoanPage extends StatefulWidget{
  final LoanItem loan;
  ViewLoanPage({@required this.loan});
  @override 
  _ViewLoanPageState createState() => _ViewLoanPageState(loan: loan);
}
class _ViewLoanPageState extends State<ViewLoanPage>{
  final LoanItem loan;
  _ViewLoanPageState({@required this.loan});
  final primaryColor = const Color(0xFFFFFFFF);
  List<Installment> compute(LoanItem loan)
  {
    print('check compute');
    double p = 1.0*loan.loanAmount;
    int r = loan.annualRoI;
    int e_amount = loan.emiAmount;
    int nd = loan.numberOfDays;
    double r1 = (r*nd)/365;
    DateTime d = loan.startDate;
    List<Installment> to_ret=[];
    //double amount_paid = 0;
    while(p>=e_amount)
    {
      double interest = (1.0*r1*p)/100.0;
      p = p + (interest-e_amount);
      if(p>=e_amount)
      {
        Installment inst = Installment(d.day.toString()+"/"+d.month.toString()+"/"+d.year.toString(), e_amount);
        print('inst:-');
        print(inst);
        //amount_paid += e_amount;
        to_ret.add(inst);
        d = d.add(Duration(days: nd));
      }
    }
    if(p>0)
    {
      //amount_paid += p;
      Installment inst = Installment(d.day.toString()+"/"+d.month.toString()+"/"+d.year.toString(), e_amount);
      to_ret.add(inst);
    }
    return to_ret;
  }
  @override
  Widget build(BuildContext context){
    print('check build');
    
    List<Installment> _list = compute(loan);
    print('check build 1');
    return Scaffold(
      appBar: AppBar(
        title: PalTitleView(
          title: loan.loanTitle,
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                height: 40.0,
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Text(
                          Text(AppLocalizations.of(context).loanAmount).data+": INR "+loan.loanAmount.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            //fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
                        child: Text(
                          Text(AppLocalizations.of(context).roi).data+loan.annualRoI.toString()+"%",
                          style: TextStyle(
                            fontSize: 18.0,
                            //fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
                        child: Text(
                          Text(AppLocalizations.of(context).installAmount).data+": INR "+loan.emiAmount.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            //fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
                        child: Text(
                          Text(AppLocalizations.of(context).installIntervalDays).data+": "+loan.numberOfDays.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            //fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
                        child: Text(
                          AppLocalizations.of(context).dateOfIns,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    //Divider(),
                  
                  ],
                ),
              ),
            ),
            Expanded(
              child:  ListTileTheme(
                selectedColor: Colors.white,
                child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index){
                return Center(
                  child: Card(
                    child:
                      Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text('On '+_list[index].date),
                          subtitle: Text(_list[index].e_amount.toString()+" INR"),
                          selected: true,
                        )
                      ],
                    ),
                    color: Colors.green[600],
                  ),
                );
                } 
              ),
            )
            )
          ],
        ),
      )
    );
  }
}