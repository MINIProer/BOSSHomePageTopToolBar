import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/k_first_level_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JRKeywordBottomToolBar extends StatelessWidget {
  final JRKeywordFirstLevelViewModel _firstLevelViewModel;

  JRKeywordBottomToolBar(this._firstLevelViewModel);

  @override
  Widget build(BuildContext context) {
    return buildContentContainerArea();
  }

  Widget buildContentContainerArea() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.setPx(40.5),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          buildTopSeperatorLineView(),
          buildBottomToolBarContainerArea()
        ],
      ),
    );
  }

  Widget buildTopSeperatorLineView() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.setPx(.5),
      color: Colors.grey[350],
    );
  }

  Widget buildBottomToolBarContainerArea() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.setPx(40),
      padding: EdgeInsets.only(left: JRScreenFitTool.setPx(15)),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          buildHasCheckDefaultTitleArea(),
          SizedBox(width: JRScreenFitTool.setPx(15)),
          buildVerticalSeperatorLineView(),
          buildSelectGridViewContainerArea()
        ],
      ),
    );
  }

  Widget buildHasCheckDefaultTitleArea() {
    return Text('已选',
        style: TextStyle(
            fontSize: JRScreenFitTool.setPx(14), color: Colors.black));
  }

  Widget buildVerticalSeperatorLineView() {
    return Container(
      width: JRScreenFitTool.setPx(.5),
      height: JRScreenFitTool.setPx(20),
      color: Colors.grey[350],
    );
  }

  Widget buildSelectGridViewContainerArea() {
    return Expanded(
        child: Container(
            height: JRScreenFitTool.setPx(25),
            alignment: Alignment.center,
            color: Colors.white,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this._firstLevelViewModel.mapList.length,
                itemBuilder: (context, index) {
                  Map<String, String> secondMap =
                      this._firstLevelViewModel.mapList[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        index == 0
                            ? JRScreenFitTool.setPx(10)
                            : JRScreenFitTool.setPx(5),
                        0,
                        JRScreenFitTool.setPx(5),
                        0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(JRScreenFitTool.setPx(12.5),
                          0, JRScreenFitTool.setPx(12.5), 0),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(238, 248, 247, 1),
                          borderRadius: BorderRadius.circular(
                              JRScreenFitTool.setPx(12.5))),
                      child: Row(
                        children: <Widget>[
                          Text('${secondMap.values.first}',
                              style: TextStyle(
                                  color: Color.fromRGBO(80, 159, 153, 1))),
                          SizedBox(width: JRScreenFitTool.setPx(5)),
                          GestureDetector(
                            child: Icon(
                              Icons.clear,
                              color: Color.fromRGBO(80, 159, 153, 1),
                              size: JRScreenFitTool.setPx(15),
                            ),
                            onTap: () {
                              this
                                  ._firstLevelViewModel
                                  .removeFromSelectKeywordSecondLevelModelNameList(
                                      index, '', '');
                              this
                                  ._firstLevelViewModel
                                  .removeFromKeywordSecondLevelModelNameList(
                                      index,
                                      true,
                                      secondMap.keys.first,
                                      secondMap.values.first);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                })));
  }
}
