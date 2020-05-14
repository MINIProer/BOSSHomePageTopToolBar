import 'package:boss_top_tool_bar/models/k_first_level_model.dart';
import 'package:boss_top_tool_bar/models/k_second_level_model.dart';
import 'package:boss_top_tool_bar/tools/json_parse.dart';
import 'package:flutter/material.dart';

class JRKeywordFirstLevelViewModel extends ChangeNotifier {
  // 搜索关键字一级类别模型数组
  List<JRKeywordFirstLevelModel> _keywordFirstLevelModelList = [];
  List<JRKeywordFirstLevelModel> get keywordFirstLevelModelList {
    return _keywordFirstLevelModelList;
  }

  // 一级类别是否处于展开状态数组
  List<String> _selectShowAllFirstLevelStringList = [];
  List<String> get selectShowAllFirstLevelStringList {
    return _selectShowAllFirstLevelStringList;
  }

  // 添加到展开状态数组
  void addTSelectShowAllFirstLevelStringList(String firstLevelName) {
    _selectShowAllFirstLevelStringList.add(firstLevelName);
    notifyListeners();
  }

  // 从展开状态数组中移除
  void removeFromSelectShowAllFirstLevelStringList(String firstLevelName) {
    _selectShowAllFirstLevelStringList.remove(firstLevelName);
    notifyListeners();
  }

  // 判断一级类别名称是否包含于展开状态数组中
  bool isSelectShowAllFirstLevelStringListContains(String firstLevelName) {
    return _selectShowAllFirstLevelStringList.contains(firstLevelName);
  }

  // 二级类别选中字典
  Map<String, dynamic> _selectKeywordSecondLevelModelTypeMap;

  // 初始化二级类别选中字典
  Map<String, dynamic> initSelectKeywordSecondLevelModelTypeMap() {
    Map<String, dynamic> tempMap = {};
    for (int i = 0; i < _keywordFirstLevelModelList.length; i++) {
      JRKeywordFirstLevelModel keywordFirstLevelModel =
          _keywordFirstLevelModelList[i];
      List<String> keywordSecondLevelModelTypeList = [];

      tempMap.putIfAbsent(keywordFirstLevelModel.k_first_level_name,
          () => keywordSecondLevelModelTypeList);
    }
    _selectKeywordSecondLevelModelTypeMap = tempMap;

    return _selectKeywordSecondLevelModelTypeMap;
  }

  // 判断二级类别是否为选中状态
  bool isSelectStatus(JRKeywordFirstLevelModel keywordFirstLevelModel,
      String keywordSecondLevelModelName) {
    List<String> selectSecondLevelModeNameList =
        _selectKeywordSecondLevelModelTypeMap[
            keywordFirstLevelModel.k_first_level_name];
    return selectSecondLevelModeNameList.contains(keywordSecondLevelModelName);
  }

  // 添加到一级类别Key对应的二级类别选中数组
  void addToKeywordSecondLevelModelNameList(
      JRKeywordFirstLevelModel keywordFirstLevelModel,
      String keywordFirstLevelModelName,
      String keywordSecondLevelModelName) {
    List<String> list =
        _selectKeywordSecondLevelModelTypeMap[keywordFirstLevelModelName];
    list.add(keywordSecondLevelModelName);
    _selectKeywordSecondLevelModelTypeMap[keywordFirstLevelModelName] = list;
    print(
        '_selectKeywordSecondLevelModelTypeMap = $_selectKeywordSecondLevelModelTypeMap');
    _mapList.add({keywordFirstLevelModelName: keywordSecondLevelModelName});
    print('mapList = $_mapList');
    notifyListeners();
  }

  // 判断二级类别选中数组中是否包含
  bool isSelectSecondLevelModelNameListContain(
      String keywordFirstLevelModelName, String keywordSecondLevelModelName) {
    List<String> list =
        _selectKeywordSecondLevelModelTypeMap[keywordFirstLevelModelName];
    return list.contains(keywordSecondLevelModelName);
  }

  // 从一级类别Key对应的二级类别选中数组中移除
  void removeFromKeywordSecondLevelModelNameList(
      int index,
      bool isTapBottomItem,
      String keywordFirstLevelModelName,
      String keywordSecondLevelModelName) {
    List<String> list =
        _selectKeywordSecondLevelModelTypeMap[keywordFirstLevelModelName];
    list.remove(keywordSecondLevelModelName);
    _selectKeywordSecondLevelModelTypeMap[keywordFirstLevelModelName] = list;
    print(
        '_selectKeywordSecondLevelModelTypeMap = $_selectKeywordSecondLevelModelTypeMap');
    print(_mapList
        .contains({keywordFirstLevelModelName: keywordSecondLevelModelName}));
    for (int i = 0; i < _mapList.length; i++) {
      Map<String, String> secondMap = _mapList[i];
      if (secondMap.keys.first == keywordFirstLevelModelName &&
          secondMap.values.first == keywordSecondLevelModelName) {
        int index = i;
        _mapList.removeAt(index);
      }
    }

    notifyListeners();
  }

  // 根据一级类别查询二级类别数组
  List<String> fetchSecondLevelModelNameList(
      JRKeywordFirstLevelModel firstLevelModel) {
    List<String> list = _selectKeywordSecondLevelModelTypeMap[
        firstLevelModel.k_first_level_name];
    return list;
  }

  // 计算确认后的选中数量
  int calculateConfirmCount() {
    print(
        '计算结果 = ${_selectKeywordSecondLevelModelTypeMap.values}, ${_selectKeywordSecondLevelModelTypeMap.values.toList().runtimeType}');
    int selectCount = 0;
    for (List<dynamic> list
        in _selectKeywordSecondLevelModelTypeMap.values.toList()) {
      selectCount += list.length;
    }
    print('selectCount = $selectCount');
    return selectCount;
  }

  // 判断导航栏是否需要展示富文本
  bool shouldNavBarShowRichText() {
    return _mapList.length > 0 ? true : false;
  }

  // 拼接选中的关键字字符串
  String selectKeywordString() {
    String tempString =
        shouldNavBarShowRichText() ? '关键词 · ${calculateConfirmCount()}' : '关键词';
    return tempString;
  }

  // 二级列表选中名称数组
  List<String> _selectKeywordSecondLevelModelNameList;
  List<String> get selectKeywordSecondLevelModelNameList {
    List<String> tempList = [];
    Map<String, dynamic> tempMap = {};
    if (_selectKeywordSecondLevelModelTypeMap == null) return tempList;
    for (String key in _selectKeywordSecondLevelModelTypeMap.keys) {
      tempMap.putIfAbsent(
          key, () => _selectKeywordSecondLevelModelTypeMap[key].toList());
      tempList.addAll(_selectKeywordSecondLevelModelTypeMap[key].toList());
    }
    print('tempMap = $tempMap');
    print('tempList = $tempList');
    _selectKeywordSecondLevelModelNameList = tempList;
    return _selectKeywordSecondLevelModelNameList;
  }

  // 关键字底部滚动条选中字典
  Map<int, dynamic> _bottomSelectMap = {};
  Map<int, dynamic> get bottomSelectMap {
    return _bottomSelectMap;
  }

  List _mapList = [];
  List get mapList {
    return _mapList;
  }

  void addToSelectKeywordSecondLevelModelNameList(int index,
      String keywordFirstLevelModelName, String keywordSecondLevelModelName) {
    Map<String, String> tempMap = {
      keywordFirstLevelModelName: keywordSecondLevelModelName
    };
    _bottomSelectMap.putIfAbsent(index, () => tempMap);
    print('_bottomSelectMap = $_bottomSelectMap');
    notifyListeners();
  }

  void removeFromSelectKeywordSecondLevelModelNameList(int index,
      String keywordFirstLevelModelName, String keywordSecondLevelModelName) {
    _bottomSelectMap.remove(index);
    print('_mapList_mapList_mapList = $_mapList');
    print('_bottomSelectMap = $_bottomSelectMap');
    notifyListeners();
  }

  void clearAllSelectStatus() {
    initSelectKeywordSecondLevelModelTypeMap();
    _mapList = [];
    notifyListeners();
  }

  // 搜索数据源
  List<JRKeywordSecondLevelModel> fetchSearchResult(String keyword) {
    if (keyword == '') {
      return [];
    }
    List<JRKeywordSecondLevelModel> resultList = [];
    for (JRKeywordSecondLevelModel keywordSecondLevelModel
        in _allSecondLevelModelList) {
      if (keywordSecondLevelModel.k_second_level_name.contains(keyword)) {
        resultList.add(keywordSecondLevelModel);
      }
    }
    return resultList;
  }

  List<JRKeywordSecondLevelModel> _allSecondLevelModelList = [];
  List<JRKeywordSecondLevelModel> get allSecondLevelModelList {
    return _allSecondLevelModelList;
  }

  void initAllSecondLevelModelList() {
    _allSecondLevelModelList = [];
    for (JRKeywordFirstLevelModel keywordFirstLevelModel
        in _keywordFirstLevelModelList) {
      _allSecondLevelModelList
          .addAll(keywordFirstLevelModel.k_second_level_list);
    }
  }

  JRKeywordFirstLevelViewModel() {
    JRJsonParse.getKeywordLevelsData().then((res) {
      _keywordFirstLevelModelList = res;
      initSelectKeywordSecondLevelModelTypeMap();
      notifyListeners();
    });
  }
}
