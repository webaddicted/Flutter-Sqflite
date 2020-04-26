import 'package:flutter/material.dart';
import 'package:fluttersqflite/global/customview/slide.dart';
import 'package:fluttersqflite/global/customview/slide_dots.dart';
import 'package:fluttersqflite/global/customview/slide_item.dart';
import 'package:fluttersqflite/global/utils/widget_helper.dart';
import 'package:fluttersqflite/view/login/login.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  BuildContext _ctx;

  @override
  void initState() {
    super.initState();
    //used for auto scroll
//    Timer.periodic(Duration(seconds: 5), (Timer timer) {
//      if (_currentPage < 2) {
//        _currentPage++;
//      } else {
//        _currentPage = 0;
//      }
//      _pageController.animateToPage(
//        _currentPage,
//        duration: Duration(milliseconds: 300),
//        curve: Curves.easeIn,
//      );
//    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => _crateUi(context),
    ));
  }

  Widget _crateUi(BuildContext context) {
    _ctx = context;
    return Stack(
      children: <Widget>[
        Container(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: slideList.length,
                itemBuilder: (ctx, i) => SlideItem(i),
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 55),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < slideList.length; i++)
                          if (i == _currentPage)
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'SKIP',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  navigationPush(context, Login());
                },
              ),
              FlatButton(
                child: Text(
                  _currentPage < 2 ? 'NEXT' : 'DONE',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  _nextClick();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _nextClick() {
    if (_currentPage < 2) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else
      navigationPush(context, Login());
  }
}
