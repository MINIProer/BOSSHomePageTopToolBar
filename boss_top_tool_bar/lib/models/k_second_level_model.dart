class JRKeywordSecondLevelModel {
  String k_second_level_name;
  String type;

  JRKeywordSecondLevelModel({this.k_second_level_name, this.type});

  JRKeywordSecondLevelModel.fromJson(Map<String, dynamic> json) {
    this.k_second_level_name = json['k_second_level_name'];
    this.type = json['type'];
  }
}
