class Profile {
  int accountId;
  int profileId;
  String id;
  String name;
  String customName;
  String picture;
  String status;
  String type;
  String platformId;
  String platformName;
  String login;
  String ownerEmail;
  int ownerFinishPlan;
  String typeName;
  String createdAt;
  String updatedAt;
  String publishType;

  Profile();

  Profile.fromJson(Map<String, dynamic> json) {
    print(json);
    accountId = json['accountId'];
    profileId = json['profileId'];
    id = json['id'];
    name = json['name'];
    customName = json['customName'];
    picture = json['picture'];
    status = json['status'];
    type = json['type'];
    typeName = json['typeName'];
    platformId = json['platformId'];
    platformName = json['platformName'];
    login = json['login'];
    ownerEmail = json['ownerEmail'];
    ownerFinishPlan = json['ownerFinishPlan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishType = json['publishType'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profileId'] = this.profileId;
    data['accountId'] = this.accountId;
    data['platformName'] = this.platformName;
    data['platformId'] = this.platformId;
    data['name'] = this.name;
    data['customName'] = this.customName;
    data['login'] = this.login;
    data['picture'] = this.picture;
    data['ownerEmail'] = this.ownerEmail;
    data['ownerFinishPlan'] = this.ownerFinishPlan;
    data['status'] = this.status;
    data['type'] = this.type;
    data['typeName'] = this.typeName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['publishType'] = this.publishType;
    return data;
  }
}
