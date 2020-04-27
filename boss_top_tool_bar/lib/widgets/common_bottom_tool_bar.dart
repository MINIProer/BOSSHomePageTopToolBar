import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/extensions/int_extension.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JRCommonBottomToolBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildBottomToolBarContainer();
  }

  Widget buildBottomToolBarContainer() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.statusBarHeight == 44
          ? (34.px + 64.px + 1.px)
          : (64.px + 1.px),
      color: Colors.white,
      child: buildChild(),
    );
  }

  Widget buildChild() {
    if (JRScreenFitTool.statusBarHeight == 44) {
      return Column(
        children: <Widget>[
          Container(
            width: JRScreenFitTool.screenWidth,
            height: 1.px,
            color: Color.fromRGBO(230, 230, 230, .5),
          ),
          Container(
            width: JRScreenFitTool.screenWidth,
            height: 64.px,
            alignment: Alignment.center,
            color: Colors.white,
            child: buildToolBarActionButtons(),
          ),
          Container(
            width: JRScreenFitTool.screenWidth,
            height: 34.px,
            color: Colors.white,
          )
        ],
      );
    }
    return Column(
      children: <Widget>[
        Container(
          width: JRScreenFitTool.screenWidth,
          height: 1.px,
          color: Color.fromRGBO(230, 230, 230, 1),
        ),
        Container(
          width: JRScreenFitTool.screenWidth,
          height: 64.px,
          alignment: Alignment.center,
          color: Colors.white,
          child: buildToolBarActionButtons(),
        )
      ],
    );
  }

  Widget buildToolBarActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 15.px),
        Container(
          width: 120.px,
          height: 40.px,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color.fromRGBO(247, 247, 247, 1),
              borderRadius: BorderRadius.circular(3.px)),
          child: Consumer<JRFirstLevelViewModel>(
              builder: (context, firstLevelVM, child) {
            return GestureDetector(
              child: Text('清除',
                  style: TextStyle(
                      fontSize: 16.px,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(103, 103, 103, 1))),
              onTap: () {
                firstLevelVM.clearCurrentFirstLevelStatus();
              },
            );
          }),
        ),
        SizedBox(width: 10.px),
        Expanded(child: Consumer<JRFirstLevelViewModel>(
            builder: (context, firstLevelVM, child) {
          return GestureDetector(
            child: Container(
              height: 40.px,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(100, 190, 184, 1),
                  borderRadius: BorderRadius.circular(3.px)),
              child: Text('确定',
                  style: TextStyle(
                      fontSize: 16.px,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            onTap: () {
              print(
                  'selct = ${firstLevelVM.selectSecondLevelName} + ${firstLevelVM.selectThirdLevelModellist}');
              Navigator.of(context).pop();
            },
          );
        })),
        SizedBox(width: 15.px),
      ],
    );
  }
}
