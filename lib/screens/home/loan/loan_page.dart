import 'package:farm_expense_management/blocs/loans_bloc.dart';
import 'package:farm_expense_management/common/assets.dart';
import 'package:farm_expense_management/common/helpers.dart';
import 'package:farm_expense_management/common/models/expenses.dart';
import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/models/loan_item.dart';
import 'package:farm_expense_management/common/ui/expense_tags.dart';
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:farm_expense_management/common/ui/swipeable_tabbar.dart';
import 'package:farm_expense_management/screens/home/dashboard/add_expense_page.dart';
import 'package:farm_expense_management/screens/home/dashboard/expense_details_page.dart';
import 'package:farm_expense_management/screens/home/dashboard/filter/filter.dart';
import 'package:farm_expense_management/screens/home/loan/add_loan.dart';
import 'package:farm_expense_management/screens/home/loan/view_loan.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoanPage extends StatefulWidget {
  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  @override
  void initState() {
    super.initState();
    loansBloc.fetchAllLoans();
  }
  Observable<List<Object>> getData() {
    var stream = Observable.combineLatestList([loansBloc.allLoans]);
    print('stream:');
    print(stream);
    return stream;
  }

  final primaryColor = const Color(0xFFFFFFFF);
    @override
  Widget build(BuildContext context){
    print('hello1234');
    return Scaffold(
      appBar: AppBar(
        title: PalTitleView(
          title: "Loans",
        ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.green),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.green[600],
            ),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return AddLoanPage();
                  },
                ),
              );
            },
          )
        ],
        
      ),
      body: SafeArea(
      child: StreamBuilder<List<Object>>(
        stream: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget mainWidget;
          List<LoanItem> loans = List();
          if (snapshot.hasData) {
            List<Object> data = snapshot.data;
            loans.addAll(data.first);

            mainWidget = _buildList(loans, loansBloc);
          } else if(snapshot.hasError) {
            mainWidget = Text(snapshot.error.toString());
          } else
          {
            mainWidget = Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green[600]
                  ),
              )
            );
          }
          // Widget titleWidget;
          // titleWidget = PalTitleView(
          //   title: "Your Fields",
          // );
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Center(
                          //child: titleWidget,
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.add),
                        //   onPressed: (){
                        //     Navigator.of(context).push(
                        //       CupertinoPageRoute(
                        //         fullscreenDialog: true,
                        //         builder: (BuildContext context) {
                        //           return AddLoanPage();
                        //         },
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    )
                  ],
                )
              ),
              Expanded(
                child: mainWidget,
              ),
            ],
          );
        },
      )
    ),
    );
  }

  Widget _buildList(
    List<LoanItem> loans, LoansBloc bloc) {
      if (loans.length <= 0) {
        return _LoanPageEmptyState();
      }
    print('hello456');
    List<dynamic> items = [];
    loans.forEach((loan){
      items.add(loan);
    });

    void _onTapItem(BuildContext context, LoanItem loan)
    {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context){
            return ViewLoanPage(loan: loan);
          },
        )
      );
    }
    return NestedScrollView(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return (items[index] is LoanItem)
          ? GestureDetector(
            child: _LoanCard(
              loan: items[index],
            ),
            onTap: ()=>_onTapItem(context, items[index]),
          )
          : _DateHeaderCard(
            date: items[index],
          );
        },
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: screenAwareSize(192.0, context),
                    child: Image.asset('assets/images/loan.jpeg'),
                  )
                ],
              ),
            ),
            expandedHeight: screenAwareSize(192.0, context),
          ),
        ];
      },
    );
  }

}
class _DateHeaderCard extends StatelessWidget {
  final DateTime date;

  _DateHeaderCard({@required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
      child: Text(
        DateHelper.formatDate(date),
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class _LoanCard extends StatelessWidget {
  final LoanItem loan;
  _LoanCard({@required this.loan});
  List<Widget> buildDetails() {
    print('789');
    Widget title = Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Text(
        loan.loanTitle,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    Widget loanamount_w = Text(
      loan.loanAmount.toString(),
      style: TextStyle(
        color: Colors.black.withOpacity(0.75),
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
      ),
    );
    
    List<Widget> widgets = [title];
    widgets.add(loanamount_w);
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print('101112');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          8.0
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildDetails(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  loan.loanTitle,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _LoanPageEmptyState extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Image.asset('assets/images/loan.jpeg'),          
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'No loans added yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
              ),
            ),
          ),
        ),
        PalButton(
          title: "Add Loan",
          width: MediaQuery.of(context).size.width * (2.0/3.0),
          colors: [Colors.green[900], Colors.green[900]],
          onPressed: (){
            Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) {
                  return AddLoanPage();
                },
              ),
            );
          },
        )
      ],
    );
  }
}
