import 'package:hack_mobile/models/program.dart';

class University {
  String title;
  String phone;
  String url;
  dynamic triggers;
  static List<Program> programs;

  University.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json["title"];
    phone = json["phone"];
    url = json["url"];
    triggers = json["triggers"];
  }
  University.programsFromJson(Map<String, dynamic> json) {
    programs = Program.listFromJson(json['response']);
  }
  static List<University> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<University>()
        : json.map((value) => new University.fromJson(value)).toList();
  }
}
