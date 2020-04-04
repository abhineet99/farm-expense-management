import 'package:farm_expense_management/common/assets.dart';
import 'package:farm_expense_management/common/helpers.dart';
import 'package:farm_expense_management/common/ui/pal_button.dart';
import 'package:farm_expense_management/root_page.dart';
import 'package:farm_expense_management/screens/onboarding/circled_image.dart';
import 'package:farm_expense_management/screens/onboarding/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:farm_expense_management/locale/locale.dart';

class OnboardingPage extends StatelessWidget {
  final home = RootPage();
  
  final _controller = PageController();
  List<Widget> retOnBoarding(BuildContext context){
    List<Widget> _pages = [
      OnboardingSinglePage(
        image: Assets.onboarding1,
        title: Text(AppLocalizations.of(context).expenses).data,
        subtitle:
            Text(AppLocalizations.of(context).expensesText).data,
        colors: [

          Colors.deepOrange[50],
          Colors.deepOrange[600],
          Colors.deepOrange[900],
        ],
      ),
      OnboardingSinglePage(
        image: Assets.onboarding2,
        title: Text(AppLocalizations.of(context).tags_1).data,
        subtitle: Text(AppLocalizations.of(context).tagsText).data,
        colors: [
          Colors.lime[50],
          Colors.lime[600],
          Colors.lime[900],
        ],
      ),
      OnboardingSinglePage(
        image: Assets.onboarding3,
        title: Text(AppLocalizations.of(context).stats).data,
        subtitle: Text(AppLocalizations.of(context).statsText).data,
        colors: [
          Colors.lightBlue[50],
          Colors.lightBlue[600],
          Colors.lightBlue[900],
        ],
      ),
    ];
    return _pages;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages=retOnBoarding(context);
    int page;
    OnboardingSinglePage currentPage;
    List<Color> nextColors;

    _configurePage(int index) {
      page = index;
      currentPage = _pages[page];
      nextColors = [currentPage.colors[2], currentPage.colors[1]];
    }

    _configurePage(0);

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        List<Widget> bottomButtons = [];
        if (page < _pages.length - 1) {
          bottomButtons.add(
            PalButton(
              title: Text(AppLocalizations.of(context).next_1).data,
              onPressed: () {
                int nextPage = page + 1;
                setState(() {
                  _configurePage(nextPage);
                });
                _controller.animateToPage(
                  nextPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              colors: nextColors,
            ),
          );
        }

        bottomButtons.add(
          PalButton(
            title: page == _pages.length - 1 ? Text(AppLocalizations.of(context).done_1).data : Text(AppLocalizations.of(context).skip_1).data,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => home));
            },
          ),
        );

        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: PageView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: _pages.length,
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index % _pages.length];
                },
                onPageChanged: (int index) {
                  setState(() {
                    _configurePage(index);
                  });
                },
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 8.0,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DotsIndicator(
                        controller: _controller,
                        itemCount: _pages.length,
                        onPageSelected: (int index) {
                          setState(() {
                            _configurePage(index);
                          });
                          _controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: bottomButtons,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OnboardingSinglePage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final List<Color> colors;

  OnboardingSinglePage(
      {@required this.image,
      @required this.title,
      @required this.subtitle,
      @required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment(0.5, -1.0),
          end: Alignment(0.5, 1.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CircledImage(
              image: image,
              imageSize: screenAwareSize(256.0, context),
            ),
          ),
          Positioned(
            top: screenAwareSize(464.0, context),
            left: 0.0,
            right: 0.0,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenAwareFontSize(32.0, context),
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenAwareFontSize(16.0, context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
