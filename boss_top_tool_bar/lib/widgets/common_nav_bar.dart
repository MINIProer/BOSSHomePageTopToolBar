import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/k_first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/s_first_level_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum JRCommonNavBarType { area, screen, keyword }

class JRCommonNavBar extends StatelessWidget {
  final JRFirstLevelViewModel firstLevelViewModel;
  final JRScreenFirstLevelViewModel screenFirstLevelViewModel;
  final JRKeywordFirstLevelViewModel keywordFirstLevelViewModel;
  final JRCommonNavBarType type;

  JRCommonNavBar(
      {this.firstLevelViewModel,
      this.screenFirstLevelViewModel,
      this.keywordFirstLevelViewModel,
      JRCommonNavBarType type})
      : this.type = type ?? JRCommonNavBarType.keyword;

  @override
  Widget build(BuildContext context) {
    return buildTopBarContainer(context);
  }

  Widget buildTopBarContainer(BuildContext context) {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.statusBarHeight + JRScreenFitTool.navBarHeight,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildStatusBarArea(),
          buildNavBarArea(context, this.type)
        ],
      ),
    );
  }

  Widget buildStatusBarArea() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.statusBarHeight,
      color: Colors.white,
    );
  }

  Widget buildNavBarArea(BuildContext context, JRCommonNavBarType type) {
    switch (type) {
      case JRCommonNavBarType.area:
        {
          return Stack(
            children: <Widget>[
              buildNavBarContainer(),
              buildLeftActionButton(context),
              buildCenterTextContainer(type),
              buildRightActionButton()
            ],
          );
        }
        break;
      case JRCommonNavBarType.screen:
        {
          return Stack(
            children: <Widget>[
              buildNavBarContainer(),
              buildLeftActionButton(context),
              buildCenterTextContainer(type),
            ],
          );
        }
        break;
      case JRCommonNavBarType.keyword:
        {
          return Stack(
            children: <Widget>[
              buildNavBarContainer(),
              buildLeftActionButton(context),
              buildCenterTextContainer(type),
            ],
          );
        }
        break;
      default:
        {
          return Stack(
            children: <Widget>[
              buildNavBarContainer(),
              buildLeftActionButton(context),
              buildCenterTextContainer(JRCommonNavBarType.keyword),
            ],
          );
        }
    }
  }

  Widget buildNavBarContainer() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.navBarHeight,
      color: Colors.white,
    );
  }

  Widget buildLeftActionButton(BuildContext context) {
    return Positioned(
        top: JRScreenFitTool.setPx(6.5),
        left: JRScreenFitTool.setPx(15),
        child: Consumer<JRFirstLevelViewModel>(
            builder: (context, firstLevelVM, child) {
          return GestureDetector(
            child: Icon(
              Icons.clear,
              size: JRScreenFitTool.setPx(28),
              color: Color.fromRGBO(52, 52, 52, 1),
            ),
            onTap: () {
              switch (this.type) {
                case JRCommonNavBarType.area:
                  {
                    firstLevelVM.clearAllStatus();
                  }
                  break;
                case JRCommonNavBarType.screen:
                  {
                    screenFirstLevelViewModel.clearAllSelectStatus();
                  }
                  break;
                case JRCommonNavBarType.keyword:
                  {
                    keywordFirstLevelViewModel.clearAllSelectStatus();
                  }
                  break;
                default:
              }
              Navigator.of(context).pop();
            },
          );
        }));
  }

  Widget buildCenterTextContainer(JRCommonNavBarType type) {
    switch (type) {
      case JRCommonNavBarType.area:
        {
          return Positioned(
              left: JRScreenFitTool.screenWidth / 2 - JRScreenFitTool.setPx(75),
              child: Container(
                  width: JRScreenFitTool.setPx(150),
                  height: JRScreenFitTool.navBarHeight,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: firstLevelViewModel.shouldNavBarShowRichText()
                      ? RichText(
                          text: TextSpan(
                              text: '北京',
                              style: TextStyle(
                                  fontSize: JRScreenFitTool.setPx(20),
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(50, 50, 50, 1)),
                              children: [
                              TextSpan(
                                  text: '·',
                                  style: TextStyle(
                                      fontSize: JRScreenFitTool.setPx(20),
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(100, 190, 184, 1))),
                              TextSpan(
                                  text:
                                      '${this.firstLevelViewModel.selectThirdLevelModellist.length}',
                                  style: TextStyle(
                                      fontSize: JRScreenFitTool.setPx(20),
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(100, 190, 184, 1)))
                            ]))
                      : Text('北京',
                          style: TextStyle(
                              fontSize: JRScreenFitTool.setPx(20),
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(50, 50, 50, 1)))));
        }
        break;
      case JRCommonNavBarType.screen:
        {
          return Positioned(
              left: JRScreenFitTool.screenWidth / 2 - JRScreenFitTool.setPx(75),
              child: Container(
                  width: JRScreenFitTool.setPx(150),
                  height: JRScreenFitTool.navBarHeight,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: this
                          .screenFirstLevelViewModel
                          .shouldNavBarShowRichText()
                      ? RichText(
                          text: TextSpan(
                              text: '筛选',
                              style: TextStyle(
                                  fontSize: JRScreenFitTool.setPx(20),
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(50, 50, 50, 1)),
                              children: [
                              TextSpan(
                                  text: '·',
                                  style: TextStyle(
                                      fontSize: JRScreenFitTool.setPx(20),
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(100, 190, 184, 1))),
                              TextSpan(
                                  text:
                                      '${this.screenFirstLevelViewModel.calculateConfirmCount()}',
                                  style: TextStyle(
                                      fontSize: JRScreenFitTool.setPx(20),
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(100, 190, 184, 1)))
                            ]))
                      : Text('筛选',
                          style: TextStyle(
                              fontSize: JRScreenFitTool.setPx(20),
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(50, 50, 50, 1)))));
        }
        break;
      case JRCommonNavBarType.keyword:
        {
          return Positioned(
              left: JRScreenFitTool.screenWidth / 2 - JRScreenFitTool.setPx(75),
              child: Container(
                  width: JRScreenFitTool.setPx(150),
                  height: JRScreenFitTool.navBarHeight,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: this
                          .keywordFirstLevelViewModel
                          .shouldNavBarShowRichText()
                      ? RichText(
                          text: TextSpan(
                              text: '关键词',
                              style: TextStyle(
                                  fontSize: JRScreenFitTool.setPx(20),
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(50, 50, 50, 1)),
                              children: [
                              TextSpan(
                                  text: ' · ',
                                  style: TextStyle(
                                      fontSize: JRScreenFitTool.setPx(20),
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(100, 190, 184, 1))),
                              TextSpan(
                                  text:
                                      '${this.keywordFirstLevelViewModel.mapList.length}',
                                  style: TextStyle(
                                      fontSize: JRScreenFitTool.setPx(20),
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(100, 190, 184, 1)))
                            ]))
                      : Text('关键词',
                          style: TextStyle(
                              fontSize: JRScreenFitTool.setPx(20),
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(50, 50, 50, 1)))));
        }
        break;
      default:
        {
          return Positioned(
              left: JRScreenFitTool.screenWidth / 2 - JRScreenFitTool.setPx(75),
              child: Container(
                  width: JRScreenFitTool.setPx(150),
                  height: JRScreenFitTool.navBarHeight,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Text('其他',
                      style: TextStyle(
                          fontSize: JRScreenFitTool.setPx(20),
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(50, 50, 50, 1)))));
        }
    }
  }

  Widget buildRightActionButton() {
    return Positioned(
        right: JRScreenFitTool.setPx(15),
        top: JRScreenFitTool.setPx(8),
        child: Text('切换城市',
            style: TextStyle(
                color: Color.fromRGBO(100, 190, 184, 1),
                fontSize: JRScreenFitTool.setPx(16))));
  }
}
