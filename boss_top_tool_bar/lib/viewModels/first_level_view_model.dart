import 'package:boss_top_tool_bar/models/first_level_model.dart';
import 'package:boss_top_tool_bar/models/second_level_model.dart';
import 'package:boss_top_tool_bar/models/third_level_model.dart';
import 'package:boss_top_tool_bar/tools/json_parse.dart';
import 'package:flutter/material.dart';

class JRFirstLevelViewModel extends ChangeNotifier {

  // 一级筛选默认选择名称
  String _defaultSelectFirstLevelName;
  String get defaultSelectFirstLevelName {
    return _defaultSelectFirstLevelName;
  }

  // 二级筛选默认选择名称
  String _defaultSelectSecondLevelName;
  String get defaultSelectSecondLevelName {
    return _defaultSelectSecondLevelName;
  }

  // 三级筛选默认选择名称
  String _defaultSelectThirdLevelName;
  String get defaultSelectThirdLevelName {
    return _defaultSelectThirdLevelName;
  }

  set setDefaultSelectThirdLevelName(String thirdLevelName) {
    _defaultSelectThirdLevelName = thirdLevelName;
    notifyListeners();
  }

  // 确认选择后的区域拼接字符串
  String _selectAreaString;
  String get selectAreaString {
    if (_selectThirdLevelModellist.length > 0) {
      if (_selectThirdLevelModellist.contains(defaultSelectThirdLevelName) == true && defaultSelectThirdLevelName != '全北京') {
        return '${this.selectSecondLevelName}';
      } else if (_selectThirdLevelModellist.contains(defaultSelectThirdLevelName) == false) {
        return '${this.selectSecondLevelName}·${_selectThirdLevelModellist.length}';
      }
    }
    return '北京';
  }

  // 一级筛选选中名称
  String _selectFirstLevelName;
  String get selectFirstLevelName {
    return _selectFirstLevelName ?? _defaultSelectFirstLevelName;
  }

  set setSelectFirstLevelName(String firstLevelName) {
    _selectFirstLevelName = firstLevelName;
    print('_selectFirstLevelName = $_selectFirstLevelName');
    fetchsecondLevelModelList(_selectFirstLevelName);
    notifyListeners();
  }

  // 二级筛选选中名称
  String _selectSecondLevelName;
  String get selectSecondLevelName {
    return _selectSecondLevelName ?? _defaultSelectSecondLevelName;
  }

  set setSelectSecondLevelName(String secondLevelName) {
    _selectSecondLevelName = secondLevelName;
    fetchthirdLeveelModelList(_selectSecondLevelName);
    notifyListeners();
  }

  // 三级筛选选中名称
  String _selectThirdLevelName;
  String get selectThirdLevelName {
    return _selectThirdLevelName ?? _defaultSelectThirdLevelName;
  }

  set setSelectThirdLevelName(String thirdLevelName) {
    _selectThirdLevelName = thirdLevelName;
    notifyListeners();
  }

  // 选中三级筛选名称的字符串数组
  List<String> _selectThirdLevelModellist = [];
  List<String> get selectThirdLevelModellist {
    return _selectThirdLevelModellist;
  }

  // 添加到三级筛选名称数组
  void addToSelectThirdLevelModellist(JRThirdLevelModel thirdLevelModel) {
    _selectThirdLevelModellist.remove(_defaultSelectThirdLevelName);
    _selectThirdLevelModellist.add(thirdLevelModel.tird_level_name);
    notifyListeners();
  }

  // 从三级筛选名称数组移除
  void removeFromSelectThirdLeveModelList(JRThirdLevelModel thirdLevelModel) {
    _selectThirdLevelModellist.remove(thirdLevelModel.tird_level_name);
    notifyListeners();
  }

  // 选中三级筛选名称数组中是否包含某个三级筛选名称
  bool isSelectThirdLevelModelListContain(JRThirdLevelModel thirdLevelModel) {
    return _selectThirdLevelModellist.contains(thirdLevelModel.tird_level_name);
  }

  // 导航栏是否允许展示富文本
  bool shouldNavBarShowRichText() {
    if (_selectThirdLevelModellist.length > 0 &&
        _selectThirdLevelModellist.contains(_defaultSelectThirdLevelName) ==
            false) {
      return true;
    }
    return false;
  }

  // 区域选择按钮是否变为高亮状态
  bool shouldAreaActionButtonColorBecomActive() {
    return (this.selectThirdLevelModellist.contains('全北京') == false ||
        (this.selectFirstLevelName == '地铁' &&
            this.selectThirdLevelModellist.contains('全北京') == true));
  }

  // 移除除默认以外其他的选中
  void removeAllExceptDefaultSelect() {
    _selectThirdLevelModellist.removeRange(
        0, _selectThirdLevelModellist.length);
    _selectThirdLevelModellist.add(_defaultSelectThirdLevelName);
    notifyListeners();
  }

  // 移除所有状态
  void clearAllStatus() {
    this.setSelectFirstLevelName = _firstLevelModelList[0].first_level_name;

    this.setSelectSecondLevelName = _defaultSelectSecondLevelName;

    this.setSelectThirdLevelName = _firstLevelModelList[0]
        .second_level_list[0]
        .tird_level_list[0]
        .tird_level_name;
    removeAllExceptDefaultSelect();
    notifyListeners();
  }

  // 添加到一级筛选状态
  void clearCurrentFirstLevelStatus() {
    this.setSelectFirstLevelName = _selectFirstLevelName;

    this.setSelectSecondLevelName = _defaultSelectSecondLevelName;

    this.setSelectThirdLevelName = _firstLevelModelList[0]
        .second_level_list[0]
        .tird_level_list[0]
        .tird_level_name;
    removeAllExceptDefaultSelect();
    notifyListeners();
  }

  List<JRFirstLevelModel> _firstLevelModelList = [];

  List<JRFirstLevelModel> get firstLevelModelList {
    return _firstLevelModelList;
  }

  // 获取二级筛选列表数组
  List<JRSecondLevelModel> fetchsecondLevelModelList(String firstLevelName) {
    _selectFirstLevelName = firstLevelName;
    for (var firstlevelModel in _firstLevelModelList) {
      if (firstlevelModel.first_level_name == firstLevelName) {
        return firstlevelModel.second_level_list;
      }
    }
    return [];
  }

  // 获取三级筛选列表数组
  List<JRThirdLevelModel> fetchthirdLeveelModelList(String secondLevelName) {
    _selectSecondLevelName = secondLevelName;
    List<JRSecondLevelModel> secondLevelModelList =
        fetchsecondLevelModelList(_selectFirstLevelName);
    for (var secondlevelModel in secondLevelModelList) {
      if (secondlevelModel.second_level_name == secondLevelName) {
        _defaultSelectThirdLevelName =
            secondlevelModel.tird_level_list[0].tird_level_name;
        return secondlevelModel.tird_level_list;
      }
    }
    return [];
  }

  // 构造方法获取最初数据
  JRFirstLevelViewModel() {
    JRJsonParse.getLevelsData().then((res) {
      print('res = $res');
      _firstLevelModelList = res;
      _defaultSelectFirstLevelName = firstLevelModelList[0].first_level_name;
      _defaultSelectSecondLevelName =
          firstLevelModelList[0].second_level_list[0].second_level_name;
      _defaultSelectThirdLevelName = firstLevelModelList[0]
          .second_level_list[0]
          .tird_level_list[0]
          .tird_level_name;
      removeAllExceptDefaultSelect();
      notifyListeners();
    });
  }
}
