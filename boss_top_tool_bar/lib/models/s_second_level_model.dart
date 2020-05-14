class JRScreenSecondLevelModel {
  String s_second_level_name;

  JRScreenSecondLevelModel({
    this.s_second_level_name
  });

  JRScreenSecondLevelModel.fromJson(Map<String, dynamic> json) {
    this.s_second_level_name = json['s_second_level_name'];
  }
}
