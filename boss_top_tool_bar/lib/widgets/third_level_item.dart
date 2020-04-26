import 'package:boss_top_tool_bar/models/third_level_model.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:flutter/material.dart';
import 'package:boss_top_tool_bar/extensions/int_extension.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class JRThirdLevelItem extends StatelessWidget {
  final JRThirdLevelModel _thirdLevelModel;
  final int _index;

  JRThirdLevelItem(this._thirdLevelModel, this._index);

  @override
  Widget build(BuildContext context) {
    return Consumer<JRFirstLevelViewModel>(
        builder: (context, firstLevelVM, child) {
      return GestureDetector(
        child: Container(
            width: 100.px,
            height: 45.px,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(15.px, 0, 15.px, 0),
            child: firstLevelVM
                    .isSelectThirdLevelModelListContain(_thirdLevelModel)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${_thirdLevelModel.tird_level_name}',
                        style: firstLevelVM.isSelectThirdLevelModelListContain(
                                _thirdLevelModel)
                            ? TextStyle(
                                color: Color.fromRGBO(100, 190, 184, 1),
                                fontSize: 15.px)
                            : TextStyle(
                                color: Color.fromRGBO(54, 54, 54, 1),
                                fontSize: 15.px),
                      ),
                      Icon(Icons.done, color: Color.fromRGBO(100, 190, 184, 1))
                    ],
                  )
                : Text(
                    '${_thirdLevelModel.tird_level_name}',
                    style: firstLevelVM.isSelectThirdLevelModelListContain(
                            _thirdLevelModel)
                        ? TextStyle(
                            color: Color.fromRGBO(100, 190, 184, 1),
                            fontSize: 15.px)
                        : TextStyle(
                            color: Color.fromRGBO(54, 54, 54, 1),
                            fontSize: 15.px),
                  )),
        onTap: () {
          firstLevelVM.setSelectThirdLevelName =
              _thirdLevelModel.tird_level_name;
          if (_index == 0) {
            firstLevelVM.removeAllExceptDefaultSelect();
          } else {
            if (firstLevelVM
                    .isSelectThirdLevelModelListContain(_thirdLevelModel) ==
                false) {
              if (firstLevelVM.selectFirstLevelName == '商圈') {
                if (firstLevelVM.selectThirdLevelModellist.length > 4) {
                  Toast.show('最多只能选择5个', context, gravity:  Toast.CENTER);
                  return;
                }
              } else {
                if (firstLevelVM.selectThirdLevelModellist.length > 6) {
                  Toast.show('最多只能选择7个', context, gravity:  Toast.CENTER);
                  return;
                }
              }
              firstLevelVM.addToSelectThirdLevelModellist(_thirdLevelModel);
            } else {
              if (firstLevelVM.isSelectThirdLevelModelListContain(
                          _thirdLevelModel) ==
                      true &&
                  firstLevelVM.selectThirdLevelModellist.length == 1) return;
              firstLevelVM.removeFromSelectThirdLeveModelList(_thirdLevelModel);
            }
          }
        },
      );
    });
  }
}
