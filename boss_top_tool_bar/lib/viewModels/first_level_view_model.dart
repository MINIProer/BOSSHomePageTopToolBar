import 'package:boss_top_tool_bar/models/first_level_model.dart';
import 'package:boss_top_tool_bar/models/second_level_model.dart';
import 'package:boss_top_tool_bar/models/third_level_model.dart';
import 'package:boss_top_tool_bar/tools/json_parse.dart';
import 'package:flutter/material.dart';

class JRFirstLevelViewModel extends ChangeNotifier {
  String _defaultSelectFirstLevelName;
  String get defaultSelectFirstLevelName {
    return _defaultSelectFirstLevelName;
  }

  String _defaultSelectSecondLevelName;
  String get defaultSelectSecondLevelName {
    return _defaultSelectSecondLevelName;
  }

  String _defaultSelectThirdLevelName;
  String get defaultSelectThirdLevelName {
    return _defaultSelectThirdLevelName;
  }

  set setDefaultSelectThirdLevelName(String thirdLevelName) {
    _defaultSelectThirdLevelName = thirdLevelName;
    notifyListeners();
  }

  String _selectAreaString;
  String get selectAreaString {
    return (_selectThirdLevelModellist.length > 0 && _selectThirdLevelModellist.contains(defaultSelectThirdLevelName) == false) ? '${this.selectSecondLevelName}·${_selectThirdLevelModellist.length}' : '北京';
  }

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

  String _selectSecondLevelName;
  String get selectSecondLevelName {
    return _selectSecondLevelName ?? _defaultSelectSecondLevelName;
  }

  set setSelectSecondLevelName(String secondLevelName) {
    _selectSecondLevelName = secondLevelName;
    fetchthirdLeveelModelList(_selectSecondLevelName);
    notifyListeners();
  }

  String _selectThirdLevelName;
  String get selectThirdLevelName {
    return _selectThirdLevelName ?? _defaultSelectThirdLevelName;
  }

  set setSelectThirdLevelName(String thirdLevelName) {
    _selectThirdLevelName = thirdLevelName;
    notifyListeners();
  }

  List<String> _selectThirdLevelModellist = [];
  List<String> get selectThirdLevelModellist {
    return _selectThirdLevelModellist;
  }

  void addToSelectThirdLevelModellist(JRThirdLevelModel thirdLevelModel) {
    _selectThirdLevelModellist.remove(_defaultSelectThirdLevelName);
    _selectThirdLevelModellist.add(thirdLevelModel.tird_level_name);
    notifyListeners();
  }

  void removeFromSelectThirdLeveModelList(JRThirdLevelModel thirdLevelModel) {
    _selectThirdLevelModellist.remove(thirdLevelModel.tird_level_name);
    notifyListeners();
  }

  bool isSelectThirdLevelModelListContain(JRThirdLevelModel thirdLevelModel) {
    return _selectThirdLevelModellist.contains(thirdLevelModel.tird_level_name);
  }

  bool shouldNavBarShowRichText() {
    if (_selectThirdLevelModellist.length > 0 &&
        _selectThirdLevelModellist.contains(_defaultSelectThirdLevelName) ==
            false) {
      return true;
    }
    return false;
  }

  void removeAllExceptDefaultSelect() {
    _selectThirdLevelModellist.removeRange(
        0, _selectThirdLevelModellist.length);
    _selectThirdLevelModellist.add(_defaultSelectThirdLevelName);
    notifyListeners();
  }

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

  List<JRSecondLevelModel> fetchsecondLevelModelList(String firstLevelName) {
    _selectFirstLevelName = firstLevelName;
    for (var firstlevelModel in _firstLevelModelList) {
      if (firstlevelModel.first_level_name == firstLevelName) {
        return firstlevelModel.second_level_list;
      }
    }
    return [];
  }

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
