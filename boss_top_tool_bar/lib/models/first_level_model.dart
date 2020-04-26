import 'package:boss_top_tool_bar/models/second_level_model.dart';

class JRFirstLevelModel {
  String first_level_name;
  List<JRSecondLevelModel> second_level_list;

  JRFirstLevelModel({this.first_level_name, this.second_level_list});

  JRFirstLevelModel.fromJson(Map<String, dynamic> json) {
    this.first_level_name = json['first_level_name'];

    List<JRSecondLevelModel> secondLevelList = [];
    for (var x in json['second_level_list']) {
      secondLevelList.add(JRSecondLevelModel.fromJson(x));
    }
    second_level_list = secondLevelList;
  }
}
