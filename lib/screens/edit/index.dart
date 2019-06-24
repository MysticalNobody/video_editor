import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_mobile/blocs/video_bloc.dart';
import 'package:hack_mobile/styles.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:share_extend/share_extend.dart';

class EditVideoScreen extends StatefulWidget {
  final video;

  const EditVideoScreen({Key key, this.video}) : super(key: key);
  @override
  _EditVideoScreenState createState() => _EditVideoScreenState();
}

class _EditVideoScreenState extends State<EditVideoScreen> {
  VideoBloc videoBloc;
  VideoPlayerController _controller;
  @override
  void initState() {
    videoBloc = VideoBloc(widget.video);
    videoBloc.to = widget.video['duration'].toDouble();
    videoBloc.from = 0;
    videoBloc.dispatch(VideoEvent.main);
    _controller = VideoPlayerController.file(File(widget.video['path']))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 48,
              child: Icon(
                Icons.arrow_back_ios,
                color: blackColor,
                size: 24,
              ),
            )),
        trailing: GestureDetector(
            onTap: () {
              ShareExtend.share(videoBloc.video['path'], 'file');
            },
            child: Container(
              width: 48,
              child: Icon(
                Icons.share,
                color: blackColor,
                size: 24,
              ),
            )),
        middle: Text('Редактирование видео'),
      ),
      child: SafeArea(
          child: BlocProvider(
              bloc: videoBloc,
              child: BlocBuilder(
                  bloc: videoBloc,
                  builder: (context, state) {
                    if (state is VideoCutState)
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: blackColor,
                      ));
                    if (state is VideoState)
                      return Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Positioned(
                              top: 0,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Container(
                                    margin: EdgeInsets.only(top: 16),
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                .9,
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                .6),
                                    child: Center(
                                        child: AspectRatio(
                                            aspectRatio:
                                                _controller.value.aspectRatio,
                                            child: VideoPlayer(_controller))),
                                  )))),
                          Positioned(
                              bottom: MediaQuery.of(context).size.height * .15,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          child: RangeSlider(
                                              lowerValue: videoBloc.from,
                                              upperValue: videoBloc.to ??
                                                  videoBloc.video['duration']
                                                      .toDouble(),
                                              max: videoBloc.video['duration']
                                                  .toDouble(),
                                              min: 0,
                                              divisions:
                                                  videoBloc.video['duration'],
                                              showValueIndicator: true,
                                              valueIndicatorFormatter:
                                                  (index, value) {
                                                return '${(value / 1000).toStringAsFixed(2)} сек';
                                              },
                                              onChanged: (double newLowerValue,
                                                  double newUpperValue) {
                                                if (newLowerValue !=
                                                    videoBloc.from) {
                                                  _controller.seekTo(Duration(
                                                      milliseconds:
                                                          newLowerValue
                                                              .toInt()));
                                                  videoBloc.from =
                                                      newLowerValue;
                                                  setState(() {});
                                                }
                                                if (newUpperValue !=
                                                    videoBloc.to) {
                                                  _controller.seekTo(Duration(
                                                      milliseconds:
                                                          newUpperValue
                                                              .toInt()));
                                                  videoBloc.to = newUpperValue;
                                                  setState(() {});
                                                }
                                              }))))),
                          Positioned(
                              bottom: 12,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                          'С ${(videoBloc.from / 1000).toStringAsFixed(2)} сек'),
                                      RaisedButton(
                                        color: whiteColor,
                                        onPressed: () {
                                          videoBloc.dispatch(VideoEvent.cut);
                                        },
                                        child: Text(
                                          'Обрезать',
                                        ),
                                      ),
                                      Text(
                                          'По ${(videoBloc.to / 1000).toStringAsFixed(2)} сек'),
                                    ],
                                  )))
                        ],
                      );
                  }))),
    );
  }
}
