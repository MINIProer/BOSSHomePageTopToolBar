class JRThirdLevelModel {
  String tird_level_name;

  JRThirdLevelModel({this.tird_level_name});

  JRThirdLevelModel.fromJson(Map<String, dynamic> json) {
    this.tird_level_name = json['tird_level_name'];
  }
}
