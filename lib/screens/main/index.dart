import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack_mobile/screens/main/pages/video.dart';

class MainScreen extends StatefulWidget {
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
