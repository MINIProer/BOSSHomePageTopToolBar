import 'package:boss_top_tool_bar/models/third_level_model.dart';

class JRSecondLevelModel {
  String second_level_name;
  List<JRThirdLevelModel> tird_level_list;

  JRSecondLevelModel({this.second_level_name, this.tird_level_list});

  JRSecondLevelModel.fromJson(Map<String, dynamic> json) {
    this.second_level_name = json['second_level_name'];

    List<JRThirdLevelModel> thirdLevelList = [];
    for (var x in json['tird_level_list']) {
      JRThirdLevelModel mmm = JRThirdLevelModel.fromJson(x);
      thirdLevelList.add(mmm);
    }
    this.tird_level_list = thirdLevelList;
  }
}
