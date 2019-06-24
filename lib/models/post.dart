import 'post_file.dart';
import 'profile.dart';

enum PostType { feed, story }

class Post {
  String id;
  String objectId;
  String publishAt;
  String publishDate;
  String type;
  String mediaType;
  String status;
  int attempts;
  String text;
  List<PostFile> prepareFiles;
  String deleteAt;
  String deleteAtOffset;
  String location;
  String externalId;
  String externalLink;
  String createdAt;
  String updatedAt;
  String errorCategory;
  String errorMessage;
  Profile profile;

  Post({
    this.id,
    this.objectId,
    this.publishAt,
    this.publishDate,
    this.type,
    this.mediaType,
    this.status,
    this.attempts,
    this.text,
    this.prepareFiles,
    this.deleteAt,
    this.deleteAtOffset,
    this.location,
    this.externalId,
    this.externalLink,
    this.createdAt,
    this.updatedAt,
    this.errorCategory,
    this.errorMessage,
    this.profile,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectId = json['object_id'];
    publishAt = json['publish_at'];
    publishDate = json['publishDate'];
    type = json['type'];
    mediaType = json['media_type'];
    status = json['status'];
    attempts = int.parse(json['attempts'].toString());
    text = json['text'];
    if (json['prepareFiles'] != null) {
      prepareFiles = new List<PostFile>();
      json['prepareFiles'].forEach((v) {
        prepareFiles.add(new PostFile.fromJson(v));
      });
    }
    deleteAt = json['delete_at'];
    deleteAtOffset = json['delete_at_offset'];
    location = json['location'];
    externalId = json['external_id'];
    externalLink = json['external_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    errorCategory = json['error_category'];
    errorMessage = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object_id'] = this.objectId;
    data['publish_at'] = this.publishAt;
    data['publishDate'] = this.publishDate;
    data['type'] = this.type;
    data['media_type'] = this.mediaType;
    data['status'] = this.status;
    data['attempts'] = this.attempts;
    data['text'] = this.text;
    if (this.prepareFiles != null) {
      data['prepareFiles'] = this.prepareFiles.map((v) => v.toJson()).toList();
    }
    data['delete_at'] = this.deleteAt;
    data['delete_at_offset'] = this.deleteAtOffset;
    data['location'] = this.location;
    data['external_id'] = this.externalId;
    data['external_link'] = this.externalLink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['error_category'] = this.errorCategory;
    data['error_message'] = this.errorMessage;
    return data;
  }
}
