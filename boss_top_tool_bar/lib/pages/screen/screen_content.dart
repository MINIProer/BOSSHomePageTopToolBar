import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/widgets/common_nav_bar.dart';
import 'package:flutter/material.dart';

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
            JRCommonNavBar(type: JRCommonNavBarType.screen),
          ],
        )
    );
  }
}
