
import 'dart:math';

import 'package:boss_top_tool_bar/pages/location/location.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:flutter/material.dart';

import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/extensions/int_extension.dart';
import 'package:provider/provider.dart';

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
      height: 51.px,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          buildLeftActionButtonsArea(),
          SizedBox(width: 10.px),
          buildRightActionButtonsArea()
        ],
      ),
    );
  }

  Widget buildLeftActionButtonsArea() {
    return Padding(
      padding: EdgeInsets.only(left: 20.px),
      child: Container(
        width: (JRScreenFitTool.screenWidth - 40.px) / 2 - 60.px,
        height: 50.px,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildLeftActionButton('推荐', true),
            buildLeftActionButton('附近', false),
            buildLeftActionButton('最新', false),
          ],
        ),
      ),
    );
  }

  Widget buildLeftActionButton(String title, bool isBold) {
    return Text(title,
        style: TextStyle(
            fontSize: 14.px,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
            color: isBold
                ? Color.fromRGBO(53, 53, 53, 1)
                : Color.fromRGBO(100, 100, 100, 1)));
  }

  Widget buildRightActionButtonsArea() {
    return Padding(
      padding: EdgeInsets.only(right: 20.px),
      child: Container(
        width: (JRScreenFitTool.screenWidth - 40.px) / 2 + 50.px,
        height: 25.px,
        color: Colors.white,
        child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              if (index == 0) {
                return buildRightActionButton1('关键词', null);
              }
              if (index == 2) {
                return buildRightActionButton2('筛选', null);
              }
              if (index == 4) {
                return Consumer<JRFirstLevelViewModel>(
                    builder: (context, firstLevelVM, child) {
                  return buildRightActionButton3(firstLevelVM, () {
                    Navigator.of(context).pushNamed(JRLocationPage.routeName);
                  });
                });
              }
              return SizedBox(
                width: 10.px,
              );
            }),
      ),
    );
  }

  Widget buildRightActionButton1(String title, Function onTap) {
    return GestureDetector(
      child: Container(
        height: 30.px,
        decoration: BoxDecoration(
            color: Color.fromRGBO(247, 247, 247, 1),
            borderRadius: BorderRadius.circular(1.px)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8.px, 0, 0, 0),
              child: Text(title,
                  style: TextStyle(
                      fontSize: 12.px,
                      color: Color.fromRGBO(121, 121, 121, 1))),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 5.px, 0, 0.px),
                child: buildArrowUI(null)),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget buildRightActionButton2(String title, Function onTap) {
    return GestureDetector(
      child: Container(
        height: 30.px,
        decoration: BoxDecoration(
            color: Color.fromRGBO(247, 247, 247, 1),
            borderRadius: BorderRadius.circular(1.px)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8.px, 0, 0, 0),
              child: Text(title,
                  style: TextStyle(
                      fontSize: 12.px,
                      color: Color.fromRGBO(121, 121, 121, 1))),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 5.px, 0, 0.px),
                child: buildArrowUI(null)),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget buildRightActionButton3(JRFirstLevelViewModel firstLevelViewModel, Function onTap) {
    return GestureDetector(
      child: Container(
        height: 30.px,
        decoration: BoxDecoration(
            color: firstLevelViewModel.shouldAreaActionButtonColorBecomActive() ? Color.fromRGBO(233, 248, 245, 1) : Color.fromRGBO(247, 247, 247, 1),
            borderRadius: BorderRadius.circular(1.px)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8.px, 0, 0, 0),
              child: Text(firstLevelViewModel.selectAreaString,
                  style: TextStyle(
                      fontSize: 12.px,
                      color: firstLevelViewModel.shouldAreaActionButtonColorBecomActive() ? Color.fromRGBO(100, 190, 184, 1) : Color.fromRGBO(121, 121, 121, 1))),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 5.px, 0, 0.px),
                child: buildArrowUI(firstLevelViewModel)),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  Widget buildArrowUI(JRFirstLevelViewModel firstLevelViewModel) {
    return Transform.rotate(
      angle: pi / 4,
      child: Icon(Icons.arrow_right, color: firstLevelViewModel == null ? Color.fromRGBO(197, 197, 197, 1) : firstLevelViewModel.shouldAreaActionButtonColorBecomActive() ? Color.fromRGBO(100, 190, 184, 1) : Color.fromRGBO(197, 197, 197, 1)),
    );
  }

  // 设置底部分割线
  Widget buildBottomSeperatorUI() {
    return Container(
      width: JRScreenFitTool.screenWidth - 40.px,
      height: 1.px,
      color: Color.fromRGBO(234, 234, 234, 1),
    );
  }
}
