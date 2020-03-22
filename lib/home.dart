import 'package:farm_expense_management/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/common/ui/pal_title_view.dart';

//import 'package:farm_expense_management/category.dart';
//import 'package:farm_expense_management/expenses_pal_app.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var categories = [
    {
      'title': 'Agri',
      'img': 'assets/agri.jpeg',
    },
    {
      'title': 'Dairy',
      'img': 'assets/dairy.jpg',
    },
    {
      'title': 'Fish Farm',
      'img': 'assets/fishfarm.jpg',
    },
    {
      'title': 'Poultry',
      'img': 'assets/poultry.jpg',
    },
  ];

  Widget titleWidget = PalTitleView(
    title: "Categories",
  );
  final primaryColor = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleWidget,
        backgroundColor: primaryColor,
      
      ),
      
      drawer: buildDrawer(),
      body: buildBody(),
    );
    
  }

  Widget buildBody() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        itemCount: 4, //THIS THING WAS 6
        itemBuilder: (context, i) {
          return InkWell(
            child: Container(
              margin: EdgeInsets.all(5),
              child: Card(
                elevation: 2,
                child: Container(
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    child: buildTitle(categories[i]['title']),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(categories[i]['img']),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            onTap: () => {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Category(
                  //               title: categories[i]['title'],
                  //             )))
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()))
                },
          );
        });
  }

  Widget buildTitle(String title) {
    return Center(
      child: Container(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: Colors.white, style: BorderStyle.solid)),
      ),
    );
  }

  // Future<bool> _onWillPop() {
  //   return showDialog(
  //         context: context,
  //         builder: (context) => new AlertDialog(
  //               title: new Text('Are you sure?'),
  //               content: new Text('Do you want to exit an App'),
  //               actions: <Widget>[
  //                 new FlatButton(
  //                   onPressed: () => Navigator.of(context).pop(false),
  //                   child: new Text('No'),
  //                 ),
  //                 new FlatButton(
  //                   onPressed: () => Navigator.of(context).pop(true),
  //                   child: new Text('Yes'),
  //                 ),
  //               ],
  //             ),
  //       ) ??
  //       false;
  // }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: UserAccountsDrawerHeader(
//              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/mazzad.png"))),
              accountName: Text("Just A Farmer"),
              accountEmail: Text("justAnotherFarmer@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("img/logo.png"),
                radius: 50,
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  buildSeparators("Registeration"),
                  buildTile(
                    "Login",
                    "/login",
                    'img/login.png',
                  ),
                  buildTile(
                    "SignUp",
                    "/signUp",
                    'img/registeration_ico.png',
                  ),
                  Divider(),
                  buildSeparators("Help Center"),
                  buildTile(
                    "Feedback",
                    "/feedback",
                    'img/feedback.png',
                  ),
                  buildTile(
                    "How to order",
                    "/feedback",
                    'img/info.png',
                  ),
                  buildTile(
                    "Shipping",
                    "/feedback",
                    'img/shipping.png',
                  ),
                  buildTile(
                    "Questions and Assistance",
                    "/feedback",
                    'img/assistance.png',
                  ),
                  buildTile(
                    "About payment",
                    "/feedback",
                    'img/visa.png',
                  ),
                  Divider(),
                  buildSeparators("Public Policy"),
                  buildTile(
                    "Privacy Policy",
                    "/feedback",
                    'img/policy.png',
                  ),
                  buildTile(
                    "Terms and Conditions",
                    "/feedback",
                    'img/terms.png',
                  ),
                  buildTile(
                    "Return Policy",
                    "/feedback",
                    'img/refund.png',
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget buildSeparators(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 10)),
        Text(
          name,
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
      ],
    );
  }

  Widget buildTile(String name, String path, String imgPath) {
    return ListTile(
      leading: Image.asset(
        imgPath,
        scale: 1.2,
      ),
      title: Text(name),
      onTap: () {
        if ( path != '/login' && path != '/signUp' )
          Navigator.pop(context);
        else
          Navigator.pushNamed(context, path);
      },
    );
  }
}