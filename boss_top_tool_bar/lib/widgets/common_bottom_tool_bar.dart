import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:flutter/material.dart';

class JRCommonBottomToolBar extends StatelessWidget {
  final Function clearAction;
  final Function confirmAction;

  JRCommonBottomToolBar({this.clearAction, this.confirmAction});

  @override
  Widget build(BuildContext context) {
    return buildBottomToolBarContainer();
  }

  Widget buildBottomToolBarContainer() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.statusBarHeight == 44
          ? (JRScreenFitTool.setPx(34) + JRScreenFitTool.setPx(64) + JRScreenFitTool.setPx(1))
          : (JRScreenFitTool.setPx(64) + JRScreenFitTool.setPx(1)),
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
            height: JRScreenFitTool.setPx(1),
            color: Color.fromRGBO(230, 230, 230, .5),
          ),
          Container(
            width: JRScreenFitTool.screenWidth,
            height: JRScreenFitTool.setPx(64),
            alignment: Alignment.center,
            color: Colors.white,
            child: buildToolBarActionButtons(),
          ),
          Container(
            width: JRScreenFitTool.screenWidth,
            height: JRScreenFitTool.setPx(34),
            color: Colors.white,
          )
        ],
      );
    }
    return Column(
      children: <Widget>[
        Container(
          width: JRScreenFitTool.screenWidth,
          height: JRScreenFitTool.setPx(1),
          color: Color.fromRGBO(230, 230, 230, 1),
        ),
        Container(
          width: JRScreenFitTool.screenWidth,
          height: JRScreenFitTool.setPx(64),
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
        SizedBox(width: JRScreenFitTool.setPx(15)),
        Container(
          width: JRScreenFitTool.setPx(120),
          height: JRScreenFitTool.setPx(40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color.fromRGBO(247, 247, 247, 1),
              borderRadius: BorderRadius.circular(JRScreenFitTool.setPx(3))),
          child: GestureDetector(
            child: Text('清除',
                style: TextStyle(
                    fontSize: JRScreenFitTool.setPx(16),
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(103, 103, 103, 1))),
            onTap: this.clearAction,
          )
        ),
        SizedBox(width: JRScreenFitTool.setPx(10)),
        Expanded(child: GestureDetector(
            child: Container(
              height: JRScreenFitTool.setPx(40),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(100, 190, 184, 1),
                  borderRadius: BorderRadius.circular(JRScreenFitTool.setPx(3))),
              child: Text('确定',
                  style: TextStyle(
                      fontSize: JRScreenFitTool.setPx(16),
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            onTap: confirmAction,
          )),
        SizedBox(width: JRScreenFitTool.setPx(15)),
      ],
    );
  }
}
