import 'package:farm_expense_management/common/models/fields.dart';
import 'package:farm_expense_management/common/ui/shadow_icon.dart';
import 'package:farm_expense_management/screens/dashboard/dashboard_page.dart';
import 'package:farm_expense_management/screens/more/more_page.dart';
import 'package:farm_expense_management/screens/stats/stats_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:farm_expense_management/locale/locale.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
class HomePage extends StatefulWidget {
  final Field field;
  HomePage({@required this.field});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final more = MorePage();

  Widget _tabs;

  Widget _getBody(index) {
    switch (index) {
      case 0:
        return DashboardPage(field: widget.field);
        break;
      case 1:
        return StatsPage(field: widget.field);
        break;
      case 2:
        return more;
        break;
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  Widget _createTabs(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ShadowIcon(
              Icons.dashboard,
              offsetX: 0.0,
              offsetY: 0.0,
              blur: 3.0,
              shadowColor: Colors.black.withOpacity(0.25),
            ),
            title: Text(
              AppLocalizations.of(context).dashboard,
              style: TextStyle(
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
          BottomNavigationBarItem(
            icon: ShadowIcon(
              Icons.more_horiz,
              offsetX: 0.0,
              offsetY: 0.0,
              blur: 3.0,
              shadowColor: Colors.black.withOpacity(0.25),
            ),
            title: Text(
              AppLocalizations.of(context).stats,
              style: TextStyle(
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
        ],
        backgroundColor: Colors.white,
        border: null,
        iconSize: 28.0,
        activeColor: Colors.green[700],
        inactiveColor: const Color(0xFFa3a3a3),
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color(0xFFffffff),
              child: MaterialApp(
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('en',""),
                  Locale('hi',""),
                  Locale('pa',""),
                ],
                onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context).title,
                home: Material(
                  type: MaterialType.transparency,
                  child: _getBody(index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_tabs == null) {
      _tabs = _createTabs(context);
    }
    return _tabs;
  }
}
