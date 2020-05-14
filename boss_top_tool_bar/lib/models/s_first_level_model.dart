import 'package:boss_top_tool_bar/models/s_second_level_model.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';

class JRScreenFirstLevelModel {
  String s_first_level_name;
  bool s_check_single;
  List<JRScreenSecondLevelModel> s_second_level_list;

  double _secondLevelAreaHeight;
  double get secondLevelAreaHeight {
    double commonMargin = JRScreenFitTool.setPx(10);
    double itemW = (JRScreenFitTool.screenWidth -
            JRScreenFitTool.setPx(30) -
            commonMargin * 2) /
        3;
    double itemH = itemW / 3;
    int rowCount;

    if (s_second_level_list.length > 0 && s_second_level_list.length > 9) {
      _secondLevelAreaHeight = 3 * itemH + 2 * commonMargin;
    } else if (s_second_level_list.length > 0 &&
        s_second_level_list.length <= 9) {
      rowCount = (s_second_level_list.length / 3).toInt() +
          (s_second_level_list.length % 3 == 0 ? 0 : 1);
      _secondLevelAreaHeight = rowCount * itemH + (rowCount - 1) * commonMargin;
    }

    return _secondLevelAreaHeight;
  }

  double _secondLevelAreaRealHeight;
  double get secondLevelAreaRealHeight {
    double commonMargin = JRScreenFitTool.setPx(10);
    double itemW = (JRScreenFitTool.screenWidth -
            JRScreenFitTool.setPx(30) -
            commonMargin * 2) /
        3;
    double itemH = itemW / 3;
    int rowCount;

    if (s_second_level_list.length > 0) {
      rowCount = (s_second_level_list.length / 3).toInt() +
          (s_second_level_list.length % 3 == 0 ? 0 : 1);
      _secondLevelAreaRealHeight =
          rowCount * itemH + (rowCount - 1) * commonMargin;
    }
    return _secondLevelAreaRealHeight;
  }

  JRScreenFirstLevelModel(
      {this.s_first_level_name, this.s_check_single, this.s_second_level_list});

  JRScreenFirstLevelModel.fromJson(Map<String, dynamic> json) {
    this.s_first_level_name = json['s_first_level_name'];
    this.s_check_single = json['s_check_single'];

    List<JRScreenSecondLevelModel> screenSecondLevelList = [];
    for (var x in json['s_second_level_list']) {
      screenSecondLevelList.add(JRScreenSecondLevelModel.fromJson(x));
    }
    s_second_level_list = screenSecondLevelList;
  }
}
