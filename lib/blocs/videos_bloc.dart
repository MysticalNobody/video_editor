import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:hack_mobile/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sembast/sembast.dart';

class VideosLoadingState extends VideoState {
  VideosLoadingState() : super();
}

class VideoListState extends VideoState {
  final videos;
  VideoListState(this.videos) : super();
}

class VideoState {}

enum VideosEvent { loading, main, add }

class VideosBloc extends Bloc<VideosEvent, VideoState> {
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
  static final VideosBloc _videosBlocSingleton = new VideosBloc._internal();
  factory VideosBloc() {
    return _videosBlocSingleton;
  }
  VideosBloc._internal();

  VideoState get initialState => VideosLoadingState();

  @override
  Stream<VideoState> mapEventToState(
    VideosEvent event,
  ) async* {
    switch (event) {
      case VideosEvent.loading:
        var videos = await getVideosFromDb();
        yield VideoListState(videos);
        break;
      case VideosEvent.main:
        // TODO: Handle this case.
        break;
      case VideosEvent.add:
        var videoFromPicker =
            await ImagePicker.pickVideo(source: ImageSource.camera);
        if (videoFromPicker == null) break;
        yield VideosLoadingState();
        var info = await getInfo(videoFromPicker.path);
        await getPreview(videoFromPicker.path);
        var store = StoreRef<String, String>.main();
        await store.record(info['path']).put(DataBase.db, json.encode(info));
        var videos = await getVideosFromDb();
        yield VideoListState(videos);
        break;
    }
  }

  getVideosFromDb() async {
    var store = StoreRef<String, String>.main();
    var videos = [];
    var videosFromStore = await store.find(DataBase.db);
    if (videosFromStore.length > 0)
      for (var video in videosFromStore) videos.add(json.decode(video.value));
    return videos;
  }

  getInfo(path) async {
    var info = await _flutterFFmpeg.getMediaInformation(path);
    return info;
  }

  getPreview(path) async {
    await _flutterFFmpeg.executeWithArguments(
        ['-i', path, '-ss', '00:00:00.01', '-vframes', '1', '$path.png']);
  }
}
