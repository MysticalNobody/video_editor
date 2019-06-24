import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:hack_mobile/blocs/videos_bloc.dart';
import 'package:hack_mobile/services/database.dart';
import 'package:sembast/sembast.dart';

class VideoCutState extends VideoState {
  VideoCutState() : super();
}

class VideoState {
  VideoState() : super();
}

enum VideoEvent { cut, main }

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  var video;
  VideoBloc(this.video);
  var videosBloc = VideosBloc();
  double to;
  double from;
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
  VideoState get initialState => VideoState();

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    switch (event) {
      case VideoEvent.cut:
        yield VideoCutState();
        var creationTime = video['metadata']['creation_time'];
        await cutVideo(video, from, to);
        video = await getInfo(video['path']);
        video['metadata']['creation_time'] = creationTime;
        video['metadata']['changed_time'] = DateTime.now().toString();
        await getPreview(video['path']);
        var store = StoreRef<String, String>.main();
        await store
            .record(video['path'])
            .update(DataBase.db, json.encode(video));
        from = 0;
        to = video['duration'].toDouble();
        videosBloc.dispatch(VideosEvent.loading);
        yield VideoState();
        break;
      case VideoEvent.main:
        yield VideoState();
        break;
    }
  }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  cutVideo(video, from, to) async {
    var _to = Duration(milliseconds: to.toInt());
    var _from = Duration(milliseconds: from.toInt());
    await _flutterFFmpeg.executeWithArguments([
      '-i',
      video['path'],
      '-ss',
      '${twoDigits(_from.inHours)}:${twoDigits(_from.inMinutes - 60 * _from.inHours)}:${twoDigits(_from.inSeconds - 60 * _from.inMinutes)}.${_from.inMilliseconds - 1000 * _from.inSeconds}',
      '-c',
      'copy',
      '-t',
      '${twoDigits(_to.inHours)}:${twoDigits(_to.inMinutes - 60 * _to.inHours)}:${twoDigits(_to.inSeconds - 60 * _to.inMinutes)}.${_to.inMilliseconds - 1000 * _to.inSeconds}',
      "${video['path']}copy.mp4"
    ]);
    var copy = File("${video['path']}copy.mp4");
    await File("${video['path']}").writeAsBytes(await copy.readAsBytes());
    copy.delete();
  }

  getInfo(path) async {
    var info = await _flutterFFmpeg.getMediaInformation(path);
    return info;
  }

  getPreview(path) async {
    await _flutterFFmpeg.executeWithArguments(
        ['-i', path, '-ss', '00:00:00.01', '-vframes', '1', '$path.png']);
  }

  getVideosFromDb() async {
    var store = StoreRef<String, String>.main();
    var videos = [];
    var videosFromStore = await store.find(DataBase.db);
    if (videosFromStore.length > 0)
      for (var video in videosFromStore) videos.add(json.decode(video.value));
    return videos;
  }
}
