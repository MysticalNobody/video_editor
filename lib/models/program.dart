class Program {
  String faculty;
  String code;
  String title;
  String description;
  String places;
  String lastScore;
  dynamic financing;
  dynamic minScore;

  Program.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    faculty = json["faculty"]["title"];
    code = json["code"];
    title = json["title"];
    description = json["description"];
    places = json["places"];
    lastScore = json["lastScore"];
    financing = json["financing"];
    minScore = json["minScore"];
  }
  static List<Program> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<Program>()
        : json.map((value) => new Program.fromJson(value)).toList();
  }
}
