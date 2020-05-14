import 'package:boss_top_tool_bar/models/k_second_level_model.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';

class JRKeywordFirstLevelModel {
  String k_first_level_name;
  bool k_check_single;
  List<JRKeywordSecondLevelModel> k_second_level_list;

  double _secondLevelAreaHeight;
  double get secondLevelAreaHeight {
    double commonMargin = JRScreenFitTool.setPx(10);
    double itemW = (JRScreenFitTool.screenWidth -
            JRScreenFitTool.setPx(30) -
            commonMargin * 2) /
        3;
    double itemH = itemW / 3;
    int rowCount;

    if (k_second_level_list.length > 0 && k_second_level_list.length > 9) {
      _secondLevelAreaHeight = 3 * itemH + 2 * commonMargin;
    } else if (k_second_level_list.length > 0 &&
        k_second_level_list.length <= 9) {
      rowCount = (k_second_level_list.length / 3).toInt() +
          (k_second_level_list.length % 3 == 0 ? 0 : 1);
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

    if (k_second_level_list.length > 0) {
      rowCount = (k_second_level_list.length / 3).toInt() +
          (k_second_level_list.length % 3 == 0 ? 0 : 1);
      _secondLevelAreaRealHeight =
          rowCount * itemH + (rowCount - 1) * commonMargin;
    }
    return _secondLevelAreaRealHeight;
  }

  JRKeywordFirstLevelModel(
      {this.k_first_level_name, this.k_check_single, this.k_second_level_list});

  JRKeywordFirstLevelModel.fromJson(Map<String, dynamic> json) {
    this.k_first_level_name = json['k_first_level_name'];
    this.k_check_single = json['k_check_single'];

    List<JRKeywordSecondLevelModel> screenSecondLevelList = [];
    for (var x in json['k_second_level_list']) {
      screenSecondLevelList.add(JRKeywordSecondLevelModel.fromJson(x));
    }
    k_second_level_list = screenSecondLevelList;
  }
}
