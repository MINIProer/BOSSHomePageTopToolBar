import 'dart:math';

import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/k_first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/s_first_level_view_model.dart';
import 'package:flutter/material.dart';

enum JRRightActionButtonType {
  area, // 区域
  screen, // 筛选
  keyword // 关键词
}

class JRRightActionButton extends StatelessWidget {
  final JRFirstLevelViewModel _firstLevelViewModel;
  final JRScreenFirstLevelViewModel screenFirstLevelViewModel;
  final JRKeywordFirstLevelViewModel keywordFirstLevelViewModel;
  final JRRightActionButtonType type;
  final Function _ontap;

  JRRightActionButton(this._firstLevelViewModel, this._ontap,
      {JRRightActionButtonType type,
      this.screenFirstLevelViewModel,
      this.keywordFirstLevelViewModel})
      : this.type = type ?? JRRightActionButtonType.area;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: JRScreenFitTool.setPx(30),
        decoration: BoxDecoration(
            color: setContainerColor(this.type),
            borderRadius: BorderRadius.circular(JRScreenFitTool.setPx(1))),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(JRScreenFitTool.setPx(8), 0, 0, 0),
              child: Text(setButtonTitle(this.type),
                  style: TextStyle(
                      fontSize: JRScreenFitTool.setPx(12),
                      color: setButtonTitleColor(this.type))),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, JRScreenFitTool.setPx(5), 0, 0),
                child: buildArrowUI()),
          ],
        ),
      ),
      onTap: _ontap,
    );
  }

  Widget buildArrowUI() {
    return Transform.rotate(
      angle: pi / 4,
      child: Icon(Icons.arrow_right,
          color: setActionButtonBottomArrowColor(this.type)),
    );
  }

  Color setContainerColor(JRRightActionButtonType type) {
    switch (type) {
      case JRRightActionButtonType.area:
        {
          return _firstLevelViewModel.shouldAreaActionButtonColorBecomActive()
              ? Color.fromRGBO(233, 248, 245, 1)
              : Color.fromRGBO(247, 247, 247, 1);
        }
        break;
      case JRRightActionButtonType.screen:
        {
          return this.screenFirstLevelViewModel.shouldNavBarShowRichText()
              ? Color.fromRGBO(233, 248, 245, 1)
              : Color.fromRGBO(247, 247, 247, 1);
        }
        break;
      case JRRightActionButtonType.keyword:
        {
          return this.keywordFirstLevelViewModel.mapList.length > 0
              ? Color.fromRGBO(233, 248, 245, 1)
              : Color.fromRGBO(247, 247, 247, 1);
        }
        break;
      default:
        {
          return Color.fromRGBO(247, 247, 247, 1);
        }
    }
  }

  String setButtonTitle(JRRightActionButtonType type) {
    switch (type) {
      case JRRightActionButtonType.area:
        {
          return _firstLevelViewModel.selectAreaString;
        }
        break;
      case JRRightActionButtonType.screen:
        {
          return this.screenFirstLevelViewModel.selectScreenString();
        }
        break;
      case JRRightActionButtonType.keyword:
        {
          return this.keywordFirstLevelViewModel.selectKeywordString();
        }
        break;
      default:
        {
          return '其他';
        }
    }
  }

  Color setButtonTitleColor(JRRightActionButtonType type) {
    switch (type) {
      case JRRightActionButtonType.area:
        {
          return _firstLevelViewModel.shouldAreaActionButtonColorBecomActive()
              ? Color.fromRGBO(100, 190, 184, 1)
              : Color.fromRGBO(121, 121, 121, 1);
        }
        break;
      case JRRightActionButtonType.screen:
        {
          return this.screenFirstLevelViewModel.shouldNavBarShowRichText()
              ? Color.fromRGBO(100, 190, 184, 1)
              : Color.fromRGBO(121, 121, 121, 1);
        }
        break;
      case JRRightActionButtonType.keyword:
        {
          return this.keywordFirstLevelViewModel.mapList.length > 0
              ? Color.fromRGBO(100, 190, 184, 1)
              : Color.fromRGBO(121, 121, 121, 1);
        }
        break;
      default:
        {
          return Color.fromRGBO(121, 121, 121, 1);
        }
    }
  }

  Color setActionButtonBottomArrowColor(JRRightActionButtonType type) {
    switch (type) {
      case JRRightActionButtonType.area:
        {
          return _firstLevelViewModel == null
              ? Color.fromRGBO(197, 197, 197, 1)
              : _firstLevelViewModel.shouldAreaActionButtonColorBecomActive()
                  ? Color.fromRGBO(100, 190, 184, 1)
                  : Color.fromRGBO(197, 197, 197, 1);
        }
        break;
      case JRRightActionButtonType.screen:
        {
          return this.screenFirstLevelViewModel.shouldNavBarShowRichText()
              ? Color.fromRGBO(100, 190, 184, 1)
              : Color.fromRGBO(197, 197, 197, 1);
        }
        break;
      case JRRightActionButtonType.keyword:
        {
          return this.keywordFirstLevelViewModel.mapList.length > 0
              ? Color.fromRGBO(100, 190, 184, 1)
              : Color.fromRGBO(197, 197, 197, 1);
        }
        break;
      default:
        {
          return Color.fromRGBO(197, 197, 197, 1);
        }
    }
  }
}
