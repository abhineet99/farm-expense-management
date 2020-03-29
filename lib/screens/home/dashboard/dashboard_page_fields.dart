import 'package:farm_expense_management/screens/home/loan/loan_page.dart';
import 'package:farm_expense_management/blocs/field_bloc.dart';
import 'package:farm_expense_management/common/assets.dart';
import 'package:farm_expense_management/common/helpers.dart';
import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/ui/expense_tags.dart';
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';
import 'package:farm_expense_management/screens/home/dashboard/add_field_page.dart';
import 'package:farm_expense_management/screens/home/loan/loan_info.dart';
import 'package:farm_expense_management/screens/home/home_page.dart';
import 'package:farm_expense_management/about.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:rxdart/rxdart.dart';
//<<<<<<< loan-branch
import 'package:farm_expense_management/screens/home/loan/interest_page.dart';
// =======
//import 'package:flutter_localizations/flutter_localizations.dart';
//>>>>>>> master

import 'package:farm_expense_management/locale/locale.dart';
class DashboardPageFields extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPageFields> {
  final addPage = AddFieldPage();

  @override
  void initState() {
    super.initState();

    fieldsBloc.fetchAllFields();
  }

  Observable<List<Object>> getData() {
    var stream = Observable.combineLatestList(
        [fieldsBloc.allFields]);
    return stream;
  }
  final primaryColor = const Color(0xFFFFFFFF);
  Widget _createBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PalTitleView(
           title: Text(AppLocalizations.of(context).category).data,
          ),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.green),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
//<<<<<<< loan-branch
                  // fullscreenDialog: false,
//=======
                  fullscreenDialog: false,
//>>>>>>> master
                  builder: (BuildContext context) {
                    return addPage;
                  },
                ),
              );
            },
          ),
        ],
      ),
    
    drawer: Drawer(
      child: ListView(
          padding: EdgeInsets.only(top: 0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(AppLocalizations.of(context).greeting),
              //accountName: Text('Welcome!'),
              accountEmail: Text(''),
              decoration: BoxDecoration(
                color: Colors.green[900]                
              )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(AppLocalizations.of(context).home),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPageFields()));
              }
            ),
            Divider(),
            
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Manage Loans'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoanPage()));
              }
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.label_important),
              title: Text('Calculate Interest Amount'),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InterestPage()));
              }
            ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.info),
// //<<<<<<< loan-branch
// //              title: Text('Banks for Loans Info'),
// //=======
// //              title: Text(AppLocalizations.of(context).about),
// //>>>>>>> master
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoanInfo()));
//               }
//             ),
            Divider(),
//<<<<<<< loan-branch
            ListTile(
              leading: Icon(Icons.info),
              title: Text(AppLocalizations.of(context).about),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
              }
            ),
            Divider(),
//=======
            // ListTile(
            //   leading: Icon(Icons.lock),
            //   title: Text('Sign Out'),
            //   onTap: (){
            //     Navigator.pop(context);
            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPageFields()));
            //   }
            // ),
            // Divider()
//>>>>>>> master
          ],),
    ),
    body: SafeArea(
      child: StreamBuilder<List<Object>>(
        stream: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget mainWidget;
          List<Field> fields=List();
          if (snapshot.hasData) {
            List<Object> data = snapshot.data;
            fields.addAll(data.first);

            mainWidget = _buildList(fields, fieldsBloc);
          } else if (snapshot.hasError) {
            mainWidget = Text(snapshot.error.toString());
          } else
            mainWidget = Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green[600],
                ),
              ),
            );

          // Widget titleWidget;
          // titleWidget = PalTitleView(
          //   title: "Your Fields",
          // );

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
//<<<<<<< loan-branch
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
                        //   onPressed: () {
                        //     Navigator.of(context).push(
                        //       CupertinoPageRoute(
                        //         fullscreenDialog: true,
                        //         builder: (BuildContext context) {
                        //           return addPage;
                        //         },
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    )
                  ],
                ),
              ),
//=======
//>>>>>>> master
              Expanded(
                child: mainWidget,
              ),
            ],
          );
        },
      ), 
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _createBody(context);
  }

  Widget _buildList(
      List<Field> fields, FieldsBloc bloc) {
    if (fields.length <= 0) {
      return _DashboardEmptyState();
    }

    List<dynamic> items = [];

    fields.forEach((field) {
      items.add(field);
    });

    void _onTapItem(BuildContext context, Field field ) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomePage(field: field); 
          },
        ),
      );
    }

    return NestedScrollView(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return (items[index] is Field)
              ? GestureDetector(
                  child: _FieldCard(
                    field: items[index],
                  ),
                  onTap: () => _onTapItem(context, items[index]),
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
                    child: FlareActor(
                      Assets.walletFlare,
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "idle",
                    ),
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

class _FieldCard extends StatelessWidget {
  final Field field;

  _FieldCard({@required this.field});

  List<Widget> buildDetails() {
    Widget title = Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Text(
        field.name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    List<Widget> widgets = [title];

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    // String currency = expense.currency != null ? " ${expense.currency}" : "";
    Widget tags = Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: ExpenseTags(
        tags: field.tags,
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(
          8.0,
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
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: field.tags.isNotEmpty ? tags : Container(),
          ),
        ],
      ),
    );
  }
}

class _DashboardEmptyState extends StatelessWidget {
  // final bool filtersActive;

  _DashboardEmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: FlareActor(
            Assets.walletFlare,
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "idle",
          ),
        ),
        PalButton(
          title: Text(AppLocalizations.of(context).add).data,
          width: MediaQuery.of(context).size.width * (2.0 / 3.0),
          colors: [Colors.green[600], Colors.green[900]],
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                // fullscreenDialog: true, 
                builder: (BuildContext context) {
                  return AddFieldPage();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
