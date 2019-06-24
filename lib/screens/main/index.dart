import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack_mobile/screens/main/pages/video.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  int page = 0;

  var backScrollController = ScrollController(initialScrollOffset: 426);
  Size size;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      animate();
    });
  }

  animate() {
    var value = pageController.offset;
    if (value < 0) value = 0;
    if (value > size.width * 2) value = size.width * 2;
    backScrollController.jumpTo(mapValue(
        value, 0, size.width * 2, 0, (5060 * size.height / 1956) * 1 / 3));
  }

  double mapValue(
      double x, double inMin, double inMax, double outMin, double outMax) {
    return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Видео редактор'),
          ),
          child: Scaffold(
            body: SafeArea(child: VideosPage()),
          ),
        ));
  }
}
