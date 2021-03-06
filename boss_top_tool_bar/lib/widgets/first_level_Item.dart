import 'package:boss_top_tool_bar/models/first_level_model.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JRFirstLevelItem extends StatelessWidget {
  final JRFirstLevelModel _firstLevelModel;

  JRFirstLevelItem(this._firstLevelModel);

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
              '${_firstLevelModel.first_level_name}',
              style: _firstLevelModel.first_level_name ==
                      firstLevelVM.selectFirstLevelName
                  ? TextStyle(
                      color: Color.fromRGBO(100, 190, 184, 1),
                      fontSize: JRScreenFitTool.setPx(15),
                      fontWeight: FontWeight.w500)
                  : TextStyle(
                      color: Color.fromRGBO(54, 54, 54, 1), fontSize: JRScreenFitTool.setPx(15)),
            )),
        onTap: _firstLevelModel.first_level_name ==
                firstLevelVM.selectFirstLevelName
            ? null
            : () {
                firstLevelVM.setSelectFirstLevelName =
                    _firstLevelModel.first_level_name;
                firstLevelVM.setSelectSecondLevelName =
                    firstLevelVM.defaultSelectSecondLevelName;
                firstLevelVM.setSelectThirdLevelName = _firstLevelModel
                    .second_level_list[0].tird_level_list[0].tird_level_name;
                firstLevelVM.removeAllExceptDefaultSelect();
              },
      );
    });
  }
}
