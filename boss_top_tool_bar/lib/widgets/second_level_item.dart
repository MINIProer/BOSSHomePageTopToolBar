import 'package:boss_top_tool_bar/models/second_level_model.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JRSecondLevelItem extends StatelessWidget {
  final JRSecondLevelModel _secondLevelModel;

  JRSecondLevelItem(this._secondLevelModel);

  @override
  Widget build(BuildContext context) {
    return Consumer<JRFirstLevelViewModel>(
        builder: (context, firstLevelVM, child) {
      return GestureDetector(
        child: Container(
            width: JRScreenFitTool.setPx(100),
            height: JRScreenFitTool.setPx(45),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: JRScreenFitTool.setPx(15)),
            child: Text(
              '${_secondLevelModel.second_level_name}',
              style: _secondLevelModel.second_level_name ==
                      firstLevelVM.selectSecondLevelName
                  ? TextStyle(
                      color: Color.fromRGBO(100, 190, 184, 1), fontSize: JRScreenFitTool.setPx(15))
                  : TextStyle(
                      color: Color.fromRGBO(54, 54, 54, 1), fontSize: JRScreenFitTool.setPx(15)),
            )),
        onTap: () {
          firstLevelVM.setSelectSecondLevelName =
              _secondLevelModel.second_level_name;
          firstLevelVM.setSelectThirdLevelName =
              _secondLevelModel.tird_level_list[0].tird_level_name;
          firstLevelVM.removeAllExceptDefaultSelect();
        },
      );
    });
  }
}
