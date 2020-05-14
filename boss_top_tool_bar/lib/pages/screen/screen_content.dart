import 'dart:math';

import 'package:boss_top_tool_bar/models/s_first_level_model.dart';
import 'package:boss_top_tool_bar/models/s_second_level_model.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/s_first_level_view_model.dart';
import 'package:boss_top_tool_bar/widgets/common_bottom_tool_bar.dart';
import 'package:boss_top_tool_bar/widgets/common_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JRScreenContent extends StatefulWidget {
  @override
  _JRScreenContentState createState() => _JRScreenContentState();
}

class _JRScreenContentState extends State<JRScreenContent> {
  @override
  Widget build(BuildContext context) {
    return buildScreenContentContainer();
  }

  Widget buildScreenContentContainer() {
    return Container(
        width: JRScreenFitTool.screenWidth,
        height: JRScreenFitTool.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Consumer<JRScreenFirstLevelViewModel>(
                builder: (context, screenFirstLevelVM, child) {
              return JRCommonNavBar(screenFirstLevelViewModel: screenFirstLevelVM, type: JRCommonNavBarType.screen);
            }),
            Container(
                width: JRScreenFitTool.screenWidth,
                height: JRScreenFitTool.screenHeight -
                    JRScreenFitTool.statusBarHeight -
                    JRScreenFitTool.navBarHeight -
                    (JRScreenFitTool.statusBarHeight == 44
                        ? (JRScreenFitTool.setPx(34) +
                            JRScreenFitTool.setPx(64) +
                            JRScreenFitTool.setPx(1))
                        : (JRScreenFitTool.setPx(64) +
                            JRScreenFitTool.setPx(1))),
                child: Consumer<JRScreenFirstLevelViewModel>(
                    builder: (context, screenFirstLevelVM, child) {
                  List<JRScreenFirstLevelModel> sFirstLevelModelList =
                      screenFirstLevelVM.screenFirstLevelModelList;
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      itemCount: sFirstLevelModelList.length,
                      itemBuilder: (context, index) {
                        return buildDemoItem(
                            sFirstLevelModelList[index], screenFirstLevelVM);
                      });
                })),
            Consumer<JRScreenFirstLevelViewModel>(
                builder: (context, screenFirstLevelVM, child) {
              return JRCommonBottomToolBar(
                clearAction: () {
                  screenFirstLevelVM.clearAllSelectStatus();
                },
                confirmAction: () {
                  Navigator.of(context).pop();
                },
              );
            })
          ],
        ));
  }

  Widget buildDemoItem(JRScreenFirstLevelModel firstLevelModel,
      JRScreenFirstLevelViewModel screenFirstLevelViewModel) {
    return Container(
      width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(20),
      height: screenFirstLevelViewModel
              .isSelectShowAllFirstLevelStringListContains(
                  firstLevelModel.s_first_level_name)
          ? firstLevelModel.secondLevelAreaRealHeight +
              JRScreenFitTool.setPx(88)
          : firstLevelModel.secondLevelAreaHeight + JRScreenFitTool.setPx(88),
      padding: EdgeInsets.fromLTRB(
          JRScreenFitTool.setPx(15),
          JRScreenFitTool.setPx(15),
          JRScreenFitTool.setPx(15),
          JRScreenFitTool.setPx(15)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(30),
            height: JRScreenFitTool.setPx(35),
            // color: Colors.red,
            alignment: Alignment.centerLeft,
            child: buildTitleArea(screenFirstLevelViewModel, firstLevelModel),
          ),
          SizedBox(height: JRScreenFitTool.setPx(15)),
          Container(
            width: JRScreenFitTool.screenWidth,
            height: screenFirstLevelViewModel
                    .isSelectShowAllFirstLevelStringListContains(
                        firstLevelModel.s_first_level_name)
                ? firstLevelModel.secondLevelAreaRealHeight
                : firstLevelModel.secondLevelAreaHeight,
            child: GridView.builder(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: JRScreenFitTool.setPx(10),
                    mainAxisSpacing: JRScreenFitTool.setPx(10),
                    childAspectRatio: 3 / 1),
                itemCount:
                    getLength(screenFirstLevelViewModel, firstLevelModel),
                itemBuilder: (context, index) {
                  JRScreenSecondLevelModel screenSecondLevelModel =
                      firstLevelModel.s_second_level_list[index];

                  if (screenFirstLevelViewModel.isSelectStatus(firstLevelModel,
                      screenSecondLevelModel.s_second_level_name)) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: index == 0
                                ? Colors.white
                                : Color.fromRGBO(235, 245, 244, 1),
                            border: Border.all(
                                color: Color.fromRGBO(100, 190, 184, 1),
                                width: JRScreenFitTool.setPx(1)),
                            borderRadius: BorderRadius.circular(
                                JRScreenFitTool.setPx(2))),
                        alignment: Alignment.center,
                        child: Text(
                            '${screenSecondLevelModel.s_second_level_name}',
                            style: TextStyle(
                                fontSize: JRScreenFitTool.setPx(13),
                                color: Color.fromRGBO(100, 190, 184, 1))),
                      ),
                      onTap: () {
                        screenSecondLevelItemClickAction(
                            screenFirstLevelViewModel,
                            firstLevelModel,
                            screenSecondLevelModel);
                      },
                    );
                  } else {
                    return GestureDetector(
                      child: Container(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        alignment: Alignment.center,
                        child: Text(
                            '${screenSecondLevelModel.s_second_level_name}',
                            style: TextStyle(
                                fontSize: JRScreenFitTool.setPx(13),
                                color: Color.fromRGBO(47, 47, 47, 1))),
                      ),
                      onTap: () {
                        screenSecondLevelItemClickAction(
                            screenFirstLevelViewModel,
                            firstLevelModel,
                            screenSecondLevelModel);
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  int getLength(JRScreenFirstLevelViewModel firstLevelViewModel,
      JRScreenFirstLevelModel firstLevelModel) {
    if (firstLevelModel.s_second_level_list.length <= 9) {
      return firstLevelModel.s_second_level_list.length;
    } else {
      if (firstLevelViewModel.isSelectShowAllFirstLevelStringListContains(
          firstLevelModel.s_first_level_name)) {
        return firstLevelModel.s_second_level_list.length;
      } else {
        return 9;
      }
    }
  }

  Widget buildTitleArea(JRScreenFirstLevelViewModel screenFirstLevelViewModel,
      JRScreenFirstLevelModel firstLevelModel) {
    if (firstLevelModel.s_second_level_list.length > 9) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildFirstLevelTextArea(firstLevelModel),
          GestureDetector(
            child: screenFirstLevelViewModel
                    .isSelectShowAllFirstLevelStringListContains(
                        firstLevelModel.s_first_level_name)
                ? Transform.rotate(
                    angle: pi,
                    child: Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey[350]),
                  )
                : Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[350],
                  ),
            onTap: () {
              print('展开');
              if (firstLevelModel.s_second_level_list.length <= 9) return;
              if (screenFirstLevelViewModel
                      .isSelectShowAllFirstLevelStringListContains(
                          firstLevelModel.s_first_level_name) ==
                  true) {
                screenFirstLevelViewModel
                    .removeFromSelectShowAllFirstLevelStringList(
                        firstLevelModel.s_first_level_name);
              } else {
                screenFirstLevelViewModel.addTSelectShowAllFirstLevelStringList(
                    firstLevelModel.s_first_level_name);
              }
            },
          )
        ],
      );
    }

    return buildFirstLevelTextArea(firstLevelModel);
  }

  Widget buildFirstLevelTextArea(
      JRScreenFirstLevelModel screenFirstLevelModel) {
    if (screenFirstLevelModel.s_check_single == true) {
      return Row(
        children: <Widget>[
          Text(
            '${screenFirstLevelModel.s_first_level_name}',
            style: TextStyle(
                fontSize: JRScreenFitTool.setPx(20),
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(50, 50, 50, 1)),
          ),
          Text(
            ' (单选)',
            style: TextStyle(
                fontSize: JRScreenFitTool.setPx(13),
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(50, 50, 50, 1)),
          )
        ],
      );
    }

    return Text('${screenFirstLevelModel.s_first_level_name}',
        style: TextStyle(
            fontSize: JRScreenFitTool.setPx(20), fontWeight: FontWeight.bold));
  }

  void screenSecondLevelItemClickAction(
      JRScreenFirstLevelViewModel screenFirstLevelViewModel,
      JRScreenFirstLevelModel screenFirstLevelModel,
      JRScreenSecondLevelModel screenSecondLevelModel) {
    if (screenFirstLevelViewModel.isSelectSecondLevelModelNameListContain(
        screenFirstLevelModel.s_first_level_name,
        screenSecondLevelModel.s_second_level_name)) {
      screenFirstLevelViewModel.removeFromScreenSecondLevelModelNameList(
          screenFirstLevelModel.s_first_level_name,
          screenSecondLevelModel.s_second_level_name);
    } else {
      screenFirstLevelViewModel.addToScreenSecondLevelModelNameList(
          screenFirstLevelModel,
          screenFirstLevelModel.s_first_level_name,
          screenSecondLevelModel.s_second_level_name);
    }

    screenFirstLevelViewModel.calculateConfirmCount();
  }
}
