import 'dart:io';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_mobile/blocs/videos_bloc.dart';
import 'package:hack_mobile/screens/edit/index.dart';
import 'package:hack_mobile/styles.dart';
import 'package:hack_mobile/widgets/dual_anim_controller.dart';
import 'package:page_transition/page_transition.dart';

class VideosPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<VideosPage>
    with AutomaticKeepAliveClientMixin {
  final DualAnimationLoopController _animController =
      DualAnimationLoopController('check-success', 'loop');
  VideosBloc videosBloc;
  @override
  void initState() {
    videosBloc = VideosBloc();
    videosBloc.dispatch(VideosEvent.loading);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Container(
          child: BlocProvider(
              bloc: videosBloc,
              child: BlocBuilder(
                  bloc: videosBloc,
                  builder: (context, state) {
                    if (state is VideosLoadingState)
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: blackColor,
                      ));
                    if (state is VideoListState) {
                      if (state.videos.length > 0)
                        return Scaffold(
                          floatingActionButton: FloatingActionButton(
                            onPressed: () =>
                                videosBloc.dispatch(VideosEvent.add),
                            backgroundColor: whiteColor,
                            child: Icon(Icons.add),
                          ),
                          body: Container(
                              child: ListView(
                            children: <Widget>[
                              for (var video in state.videos) videoCard(video)
                            ],
                          )),
                        );
                      else {
                        return Scaffold(
                            floatingActionButton: FloatingActionButton(
                              onPressed: () =>
                                  videosBloc.dispatch(VideosEvent.add),
                              backgroundColor: whiteColor,
                              child: Icon(Icons.add),
                            ),
                            body: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .05),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .7,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .4,
                                        child: FlareActor(
                                          "assets/animations/success.flr",
                                          controller: _animController,
                                        )),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .1),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    'Для начала работы, добавьте видео',
                                                style: genTextStyle(blackColor,
                                                    bigSize, boldWeight)),
                                          ]),
                                        )),
                                  ],
                                ),
                              ],
                            ));
                      }
                    }
                  }))),
    );
  }

  Widget videoCard(video) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(PageTransition(
            type: PageTransitionType.fade,
            child: EditVideoScreen(
              video: video,
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: whiteColor,
            boxShadow: [
              new BoxShadow(
                  color: Colors.grey.withOpacity(.1),
                  offset: new Offset(0, 9),
                  blurRadius: 12)
            ],
          ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * .35,
                      maxHeight: 120,
                    ),
                    child: Center(
                        child: ClipRRect(
                            borderRadius: new BorderRadius.circular(8.0),
                            child: Image.file(File(video['path'] + '.png'))))),
                Container(
                    margin: EdgeInsets.only(left: 12, bottom: 8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Длительность',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                              child: Text(
                                  (video['duration'] / 1000).toString() +
                                      ' сек')),
                          SizedBox(
                            height: 4,
                          ),
                          if (video['metadata']['creation_time'] != null)
                            Text(
                              'Дата съемки',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          if (video['metadata']['creation_time'] != null)
                            Text(DateTime.parse(
                                    video['metadata']['creation_time'])
                                .toString()),
                          if (video['metadata']['creation_time'] != null)
                            SizedBox(
                              height: 4,
                            ),
                          if (video['metadata']['changed_time'] != null)
                            Text(
                              'Дата изменения',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          if (video['metadata']['changed_time'] != null)
                            Text(DateTime.parse(
                                    video['metadata']['changed_time'])
                                .toString())
                        ]))
              ]),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
