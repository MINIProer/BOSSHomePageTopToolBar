import 'dart:convert';

import 'package:boss_top_tool_bar/models/first_level_model.dart';
import 'package:boss_top_tool_bar/models/k_first_level_model.dart';
import 'package:boss_top_tool_bar/models/s_first_level_model.dart';
import 'package:flutter/services.dart';

class JRJsonParse {
  // 获取地点数据
  static Future<List<JRFirstLevelModel>> getLevelsData() async {
    // 1.加载json文件(loadString是异步的)
    final jsonString = await rootBundle.loadString('assets/json/location.json');

    // 2.将jsonString转成Map/List
    final result = json.decode(jsonString);

    // 3.将Map中的内容转成一个个对象
    final resultList = result['first_level_list'];

    List<JRFirstLevelModel> levels = [];
    for (var json in resultList) {
      levels.add(JRFirstLevelModel.fromJson(json));
    }

    return levels;
  }

  // 获取筛选数据
  static Future<List<JRScreenFirstLevelModel>> getScreenLevelsData() async {
    // 1.加载json文件(loadString是异步的)
    final jsonString = await rootBundle.loadString('assets/json/screen.json');

    // 2.将jsonString转成Map/List
    final result = json.decode(jsonString);

    // 3.将Map中的内容转成一个个对象
    final resultList = result['s_first_level_list'];

    List<JRScreenFirstLevelModel> levels = [];
    for (var json in resultList) {
      levels.add(JRScreenFirstLevelModel.fromJson(json));
    }

    print('S_levels = $levels');
    return levels;
  }

  // 获取关键字数据
  static Future<List<JRKeywordFirstLevelModel>> getKeywordLevelsData() async {
    // 1.加载json文件(loadString是异步的)
    final jsonString = await rootBundle.loadString('assets/json/keyword.json');

    // 2.将jsonString转成Map/List
    final result = json.decode(jsonString);

    // 3.将Map中的内容转成一个个对象
    final resultList = result['k_first_level_list'];

    List<JRKeywordFirstLevelModel> levels = [];
    for (var json in resultList) {
      print('json = $json');
      levels.add(JRKeywordFirstLevelModel.fromJson(json));
    }

    print('k_levels = $levels');
    return levels;
  }
}
