import 'package:boss_top_tool_bar/models/s_first_level_model.dart';
import 'package:boss_top_tool_bar/tools/json_parse.dart';
import 'package:flutter/material.dart';

class JRScreenFirstLevelViewModel extends ChangeNotifier {
  List<JRScreenFirstLevelModel> _screenFirstLevelModelList = [];
  List<JRScreenFirstLevelModel> get screenFirstLevelModelList {
    return _screenFirstLevelModelList;
  }

  List<String> _selectShowAllFirstLevelStringList = [];
  List<String> get selectShowAllFirstLevelStringList {
    return _selectShowAllFirstLevelStringList;
  }

  void addTSelectShowAllFirstLevelStringList(String firstLevelName) {
    _selectShowAllFirstLevelStringList.add(firstLevelName);
    notifyListeners();
  }

  void removeFromSelectShowAllFirstLevelStringList(String firstLevelName) {
    _selectShowAllFirstLevelStringList.remove(firstLevelName);
    notifyListeners();
  }

  bool isSelectShowAllFirstLevelStringListContains(String firstLevelName) {
    return this.selectShowAllFirstLevelStringList.contains(firstLevelName);
  }

  Map<String, dynamic> _selectScreenSecondLevelModelTypeMap;
  Map<String, dynamic> initSelectScreenSecondLevelModelTypeMap() {
    Map<String, dynamic> tempMap = {};
    for (int i = 0; i < _screenFirstLevelModelList.length; i++) {
      JRScreenFirstLevelModel screenFirstLevelModel =
          _screenFirstLevelModelList[i];
      List<String> screenSecondLevelModelTypeList = [
        screenFirstLevelModel.s_second_level_list.first.s_second_level_name
      ];

      tempMap.putIfAbsent(screenFirstLevelModel.s_first_level_name,
          () => screenSecondLevelModelTypeList);
    }
    _selectScreenSecondLevelModelTypeMap = tempMap;

    return _selectScreenSecondLevelModelTypeMap;
  }

  bool isSelectStatus(JRScreenFirstLevelModel screenFirstLevelModel,
      String screenSecondLevelModelName) {
    List<String> selectSecondLevelModeNameList =
        _selectScreenSecondLevelModelTypeMap[
            screenFirstLevelModel.s_first_level_name];
    return selectSecondLevelModeNameList.contains(screenSecondLevelModelName);
  }

  void addToScreenSecondLevelModelNameList(
      JRScreenFirstLevelModel screenFirstLevelModel,
      String screenFirstLevelModelName,
      String screenSecondLevelModelName) {
    if (screenSecondLevelModelName != '不限') {
      List<String> list =
          _selectScreenSecondLevelModelTypeMap[screenFirstLevelModelName];

      if (screenFirstLevelModel.s_check_single) {
        list.removeRange(0, list.length);
      } else {
        list.remove('不限');
      }

      list.add(screenSecondLevelModelName);
      _selectScreenSecondLevelModelTypeMap[screenFirstLevelModelName] = list;
    } else {
      List<String> list =
          _selectScreenSecondLevelModelTypeMap[screenFirstLevelModelName];
      list.removeRange(0, list.length);
      list.add('不限');
      _selectScreenSecondLevelModelTypeMap[screenFirstLevelModelName] = list;
    }
    notifyListeners();
  }

  bool isSelectSecondLevelModelNameListContain(
      String screenFirstLevelModelName, String screenSecondLevelModelName) {
    List<String> list =
        _selectScreenSecondLevelModelTypeMap[screenFirstLevelModelName];
    return list.contains(screenSecondLevelModelName);
  }

  void removeFromScreenSecondLevelModelNameList(
      String screenFirstLevelModelName, String screenSecondLevelModelName) {
    List<String> list =
        _selectScreenSecondLevelModelTypeMap[screenFirstLevelModelName];
    if (screenSecondLevelModelName != '不限') {
      list.remove(screenSecondLevelModelName);
      if (list.length == 0) {
        list.add('不限');
      }
    }
    _selectScreenSecondLevelModelTypeMap[screenFirstLevelModelName] = list;
    notifyListeners();
  }

  void clearAllSelectStatus() {
    initSelectScreenSecondLevelModelTypeMap();
    notifyListeners();
  }

  int calculateConfirmCount() {
    print(
        '计算结果 = ${_selectScreenSecondLevelModelTypeMap.values}, ${_selectScreenSecondLevelModelTypeMap.values.toList().runtimeType}');
    int selectCount = 0;
    for (List<dynamic> list
        in _selectScreenSecondLevelModelTypeMap.values.toList()) {
      if (list.contains('不限') == false) {
        selectCount += list.length;
      }
    }
    print('selectCount = $selectCount');
    return selectCount;
  }

  bool shouldNavBarShowRichText() {
    return calculateConfirmCount() > 0 ? true : false;
  }

  String selectScreenString() {
    String tempString =
        shouldNavBarShowRichText() ? '筛选 · ${calculateConfirmCount()}' : '筛选';
    return tempString;
  }

  JRScreenFirstLevelViewModel() {
    JRJsonParse.getScreenLevelsData().then((res) {
      _screenFirstLevelModelList = res;
      initSelectScreenSecondLevelModelTypeMap();
      notifyListeners();
    });
  }
}
