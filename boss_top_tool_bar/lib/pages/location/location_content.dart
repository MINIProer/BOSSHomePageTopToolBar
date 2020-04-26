

import 'package:boss_top_tool_bar/models/first_level_model.dart';
import 'package:boss_top_tool_bar/models/second_level_model.dart';
import 'package:boss_top_tool_bar/models/third_level_model.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:boss_top_tool_bar/widgets/common_bottom_tool_bar.dart';
import 'package:boss_top_tool_bar/widgets/common_nav_bar.dart';
import 'package:boss_top_tool_bar/extensions/int_extension.dart';
import 'package:boss_top_tool_bar/widgets/first_level_Item.dart';
import 'package:boss_top_tool_bar/widgets/second_level_item.dart';
import 'package:boss_top_tool_bar/widgets/third_level_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JRLocationContent extends StatefulWidget {
  @override
  _JRLocationContentState createState() => _JRLocationContentState();
}

class _JRLocationContentState extends State<JRLocationContent> {
  @override
  Widget build(BuildContext context) {
    return buildContentContainer();
  }

  Widget buildContentContainer() {
    return Consumer<JRFirstLevelViewModel>(
        builder: (context, firstLevelVM, child) {
      return Container(
        width: JRScreenFitTool.screenWidth,
        height: JRScreenFitTool.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            JRCommonNavBar(firstLevelVM),
            buildContentDetailContainer(firstLevelVM),
            JRCommonBottomToolBar()
          ],
        ),
      );
    });
  }

  Widget buildContentDetailContainer(JRFirstLevelViewModel firstLevelViewModel) {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.screenHeight -
          JRScreenFitTool.statusBarHeight -
          JRScreenFitTool.navBarHeight -
          (JRScreenFitTool.statusBarHeight == 44
              ? (34.px + 64.px + 1.px)
              : (64.px + 1.px)),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          buildFirstLevelArea(),
          buildSecondLevelArea(firstLevelViewModel),
          buildMiddleSeperatorLine(),
          buildThirdLevelArea(firstLevelViewModel)
        ],
      ),
    );
  }

  Widget buildFirstLevelArea() {
    return Consumer<JRFirstLevelViewModel>(
        builder: (context, firstLevelVM, child) {
      return Container(
        width: 100.px,
        height: double.infinity,
        color: Color.fromRGBO(247, 247, 247, 1),
        child: ListView.builder(
            padding: EdgeInsets.only(top: 15.px),
            itemCount: firstLevelVM.firstLevelModelList.length,
            itemBuilder: (context, index) {
              JRFirstLevelModel m = firstLevelVM.firstLevelModelList[index];
              return JRFirstLevelItem(m);
            }),
      );
    });
  }

  Widget buildSecondLevelArea(JRFirstLevelViewModel firstLevelViewModel) {
    List<JRSecondLevelModel> secondLevelModelList = firstLevelViewModel
          .fetchsecondLevelModelList(firstLevelViewModel.selectFirstLevelName);
    return Container(
        width: (JRScreenFitTool.screenWidth - 101.px) / 2,
        height: double.infinity,
        color: Colors.white,
        child: ListView.builder(
            padding: EdgeInsets.only(top: 15.px),
            itemCount: secondLevelModelList.length,
            itemBuilder: (context, index) {
              JRSecondLevelModel secondLevelModel = secondLevelModelList[index];
              return JRSecondLevelItem(secondLevelModel);
            }),
      );
  }

  Widget buildMiddleSeperatorLine() {
    return Container(
      width: 1.px,
      height: double.infinity,
      color: Color.fromRGBO(230, 230, 230, .5),
    );
  }

  Widget buildThirdLevelArea(JRFirstLevelViewModel firstLevelViewModel) {
    List<JRThirdLevelModel> thirdLevelModelList = firstLevelViewModel
          .fetchthirdLeveelModelList(firstLevelViewModel.selectSecondLevelName);
    return Container(
        width: (JRScreenFitTool.screenWidth - 101.px) / 2,
        height: double.infinity,
        color: Colors.white,
        child: ListView.builder(
            padding: EdgeInsets.only(top: 15.px),
            itemCount: thirdLevelModelList.length,
            itemBuilder: (context, index) {
              JRThirdLevelModel thirdLevelModel = thirdLevelModelList[index];
              return JRThirdLevelItem(thirdLevelModel, index);
            }),
      );
  }
}
