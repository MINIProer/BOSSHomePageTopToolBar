

import 'package:boss_top_tool_bar/pages/keyword/keyword.dart';
import 'package:boss_top_tool_bar/pages/location/location.dart';
import 'package:boss_top_tool_bar/pages/screen/screen.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/k_first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/s_first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/top_bar_left_button_view_model.dart';
import 'package:flutter/material.dart';

import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:provider/provider.dart';

import 'right_action_button.dart';

class JRBossTopToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        buildStackContainerUI(),
        buildBottomSeperatorUI(),
      ],
    );
  }

  // 设置子组件内容区域
  Widget buildStackContainerUI() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.setPx(51),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          buildLeftActionButtonsArea(),
          SizedBox(width: JRScreenFitTool.setPx(10)),
          buildRightActionButtonsArea()
        ],
      ),
    );
  }

  Widget buildLeftActionButtonsArea() {
    return Padding(
      padding: EdgeInsets.only(left: JRScreenFitTool.setPx(20)),
      child: Container(
        width: (JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(40)) / 2 -
            JRScreenFitTool.setPx(60),
        height: JRScreenFitTool.setPx(50),
        color: Colors.white,
        child: Consumer<JRTopBarLeftActionButtonViewModel>(
            builder: (context, leftActionButtonVM, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildLeftActionButton('推荐', true, leftActionButtonVM),
              buildLeftActionButton('附近', false, leftActionButtonVM),
              buildLeftActionButton('最新', false, leftActionButtonVM),
            ],
          );
        }),
      ),
    );
  }

  Widget buildLeftActionButton(String title, bool isBold,
      JRTopBarLeftActionButtonViewModel leftActionButtonViewModel) {
    return GestureDetector(
      child: Text(title,
          style: TextStyle(
              fontSize: JRScreenFitTool.setPx(14),
              fontWeight: leftActionButtonViewModel.selectLeftActionButtonName == title ? FontWeight.w700 : FontWeight.normal,
              color: leftActionButtonViewModel.selectLeftActionButtonName == title
                  ? Color.fromRGBO(53, 53, 53, 1)
                  : Color.fromRGBO(100, 100, 100, 1))),
      onTap: () {
        leftActionButtonViewModel.setSelectLeftActionButtonName = title;
      },
    );
  }

  Widget buildRightActionButtonsArea() {
    return Padding(
      padding: EdgeInsets.only(right: JRScreenFitTool.setPx(20)),
      child: Consumer<JRFirstLevelViewModel>(
          builder: (context, firstLevelVM, child) {
        return Container(
          width: (JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(40)) / 2 +
              JRScreenFitTool.setPx(50),
          height: JRScreenFitTool.setPx(25),
          color: Colors.white,
          child: ListView.builder(
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Consumer<JRKeywordFirstLevelViewModel>(
                      builder: (context, keywordFirstLevelVM, child) {
                    return JRRightActionButton(null, () {
                      Navigator.of(context).pushNamed(JRKeywordPage.routeName);
                    },
                        type: JRRightActionButtonType.keyword,
                        keywordFirstLevelViewModel: keywordFirstLevelVM);
                  });
                }
                if (index == 2) {
                  return Consumer<JRScreenFirstLevelViewModel>(
                      builder: (context, screenFirstLevelVM, child) {
                    return JRRightActionButton(
                      null,
                      () {
                        Navigator.of(context).pushNamed(JRScreenPage.routeName);
                      },
                      type: JRRightActionButtonType.screen,
                      screenFirstLevelViewModel: screenFirstLevelVM,
                    );
                  });
                }
                if (index == 4) {
                  return JRRightActionButton(firstLevelVM, () {
                    Navigator.of(context).pushNamed(JRLocationPage.routeName);
                  }, type: JRRightActionButtonType.area);
                }
                return SizedBox(
                  width: JRScreenFitTool.setPx(10),
                );
              }),
        );
      }),
    );
  }

  // 设置底部分割线
  Widget buildBottomSeperatorUI() {
    return Container(
      width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(40),
      height: JRScreenFitTool.setPx(1),
      color: Color.fromRGBO(234, 234, 234, 1),
    );
  }
}
