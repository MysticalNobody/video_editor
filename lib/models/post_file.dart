import 'dart:io';

class PostFile {
  String id;
  String preview;
  bool isVideo;
  String src;
  String processedId;
  String type;
  String cover;
  File file;
  File thumbnail;
  bool uploaded = false;

  PostFile({this.id, this.preview, this.isVideo, this.src, this.processedId, this.type, this.cover});

  PostFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    preview = json['preview'];
    isVideo = json['isVideo'];
    src = json['src'];
    processedId = json['processedId'];
    type = json['type'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['preview'] = this.preview;
    data['isVideo'] = this.isVideo;
    data['src'] = this.src;
    data['processedId'] = this.processedId;
    data['type'] = this.type;
    data['cover'] = this.cover;
    return data;
  }
}
