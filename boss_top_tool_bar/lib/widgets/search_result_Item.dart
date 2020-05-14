import 'package:boss_top_tool_bar/models/k_second_level_model.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:flutter/material.dart';

class JRSearchResultItem extends StatelessWidget {
  int index;
  final JRKeywordSecondLevelModel _keywordSecondLevelModel;
  JRSearchResultItem(this._keywordSecondLevelModel, {this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.setPx(64),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Offstage(
            offstage: index == 0 ? false : true,
            child: Container(
              width: JRScreenFitTool.screenWidth,
              height: JRScreenFitTool.setPx(.5),
              color: Colors.grey,
            ),
          ),
          Container(
            width: JRScreenFitTool.screenWidth,
            height: JRScreenFitTool.setPx(63),
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(JRScreenFitTool.setPx(15), 0, JRScreenFitTool.setPx(15), 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(this._keywordSecondLevelModel.k_second_level_name),
                Text(this._keywordSecondLevelModel.type, style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                JRScreenFitTool.setPx(15), 0, JRScreenFitTool.setPx(15), 0),
            child: Container(
              width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(30),
              height: JRScreenFitTool.setPx(.5),
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
