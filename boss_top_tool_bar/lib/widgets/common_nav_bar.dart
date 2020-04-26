import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/extensions/int_extension.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JRCommonNavBar extends StatelessWidget {
  final JRFirstLevelViewModel _firstLevelViewModel;

  JRCommonNavBar(this._firstLevelViewModel);

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
        children: <Widget>[buildStatusBarArea(), buildNavBarArea(context)],
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

  Widget buildNavBarArea(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildNavBarContainer(),
        buildLeftActionButton(context),
        buildCenterTextContainer(),
        buildRightActionButton()
      ],
    );
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
        left: 15.px,
        child: Consumer<JRFirstLevelViewModel>(
            builder: (context, firstLevelVM, child) {
          return GestureDetector(
            child: Icon(
              Icons.clear,
              size: 28.px,
              color: Color.fromRGBO(52, 52, 52, 1),
            ),
            onTap: () {
              firstLevelVM.clearAllStatus();
              Navigator.of(context).pop();
            },
          );
        }));
  }

  Widget buildCenterTextContainer() {
    return Positioned(
        left: JRScreenFitTool.screenWidth / 2 - 75.px,
        child: Container(
          width: 150.px,
          height: JRScreenFitTool.navBarHeight,
          alignment: Alignment.center,
          color: Colors.white,
          child: _firstLevelViewModel.shouldNavBarShowRichText() ? RichText(
            text: TextSpan(
              text: '北京',
              style: TextStyle(
                  fontSize: 20.px,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(50, 50, 50, 1)),
              children: [
                TextSpan(
                  text: '·',
                  style: TextStyle(
                  fontSize: 20.px,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(100, 190, 184, 1))
                ),
                TextSpan(
                  text: '${this._firstLevelViewModel.selectThirdLevelModellist.length}',
                  style: TextStyle(
                  fontSize: 20.px,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(100, 190, 184, 1))
                )
              ]
            )
          ) : Text('北京',
              style: TextStyle(
                  fontSize: 20.px,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(50, 50, 50, 1)))
        ));
  }

  Widget buildRightActionButton() {
    return Positioned(
        right: 15.px,
        top: 8.px,
        child: Text('切换城市',
            style: TextStyle(
                color: Color.fromRGBO(100, 190, 184, 1), fontSize: 16.px)));
  }
}
