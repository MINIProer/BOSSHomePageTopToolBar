import 'dart:math';

import 'package:boss_top_tool_bar/models/k_first_level_model.dart';
import 'package:boss_top_tool_bar/models/k_second_level_model.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/k_first_level_view_model.dart';
import 'package:boss_top_tool_bar/widgets/common_bottom_tool_bar.dart';
import 'package:boss_top_tool_bar/widgets/common_nav_bar.dart';
import 'package:boss_top_tool_bar/widgets/keyword_bottom_tool_bar.dart';
import 'package:boss_top_tool_bar/widgets/search_result_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JRKeywordContent extends StatefulWidget {
  @override
  _JRKeywordContentState createState() => _JRKeywordContentState();
}

class _JRKeywordContentState extends State<JRKeywordContent> {
  String _keyword = '';
  bool _shouldMaskViewShow = false;
  bool _shouldDialogViewShow = true;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  FocusNode _commentFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return buildScreenContentStack();
  }

  Widget buildScreenContentStack() {
    return Stack(
      children: <Widget>[
        buildScreenContentContainer(),
        buildKeywordBottomToolBarArea(),
        buildSearchContainer(),
        buildDialogViewArea(),
      ],
    );
  }

  Widget buildScreenContentContainer() {
    return Container(
        width: JRScreenFitTool.screenWidth,
        height: JRScreenFitTool.screenHeight,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Consumer<JRKeywordFirstLevelViewModel>(
                builder: (context, keywordFirstLevelVM, child) {
              return JRCommonNavBar(
                  keywordFirstLevelViewModel: keywordFirstLevelVM,
                  type: JRCommonNavBarType.keyword);
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
                child: Consumer<JRKeywordFirstLevelViewModel>(
                    builder: (context, keywordFirstLevelVM, child) {
                  keywordFirstLevelVM.initAllSecondLevelModelList();
                  List<JRKeywordFirstLevelModel> kFirstLevelModelList =
                      keywordFirstLevelVM.keywordFirstLevelModelList;
                  return ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.only(
                          top: 0,
                          bottom: keywordFirstLevelVM.mapList.length > 0
                              ? JRScreenFitTool.setPx(40.5)
                              : 0),
                      itemCount: kFirstLevelModelList.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return buildDefaultTitleItem();
                        } else if (index == 1) {
                          return buildSearchItem();
                        }
                        return buildDemoItem(kFirstLevelModelList[index - 2],
                            keywordFirstLevelVM);
                      });
                })),
            Consumer<JRKeywordFirstLevelViewModel>(
                builder: (context, keywordFirstLevelVM, child) {
              return JRCommonBottomToolBar(
                clearAction: () {
                  keywordFirstLevelVM.clearAllSelectStatus();
                },
                confirmAction: () {
                  // keywordFirstLevelVM.setConfirm(true);
                  Navigator.of(context).pop();
                },
              );
            })
          ],
        ));
  }

  // 默认文案
  Widget buildDefaultTitleItem() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.setPx(40),
      padding: EdgeInsets.fromLTRB(
          JRScreenFitTool.setPx(20), 0, JRScreenFitTool.setPx(20), 0),
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Text(
        '选择你的求职喜好，我们将为您更精准地推荐工作',
        style:
            TextStyle(fontSize: JRScreenFitTool.setPx(11), color: Colors.black),
      ),
    );
  }

  // 搜索按钮
  Widget buildSearchItem() {
    return GestureDetector(
      child: Container(
        width: JRScreenFitTool.screenWidth,
        height: JRScreenFitTool.setPx(40),
        padding: EdgeInsets.fromLTRB(
            JRScreenFitTool.setPx(20), 0, JRScreenFitTool.setPx(20), 0),
        alignment: Alignment.centerLeft,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Icon(Icons.search,
                size: JRScreenFitTool.setPx(25),
                color: Color.fromRGBO(173, 173, 173, 1)),
            SizedBox(
              width: JRScreenFitTool.setPx(5),
            ),
            Text(
              '搜索关键词',
              style: TextStyle(
                  fontSize: JRScreenFitTool.setPx(14),
                  color: Color.fromRGBO(198, 198, 200, 1)),
            )
          ],
        ),
      ),
      onTap: () {
        _shouldMaskViewShow = !_shouldMaskViewShow;
        FocusScope.of(context).requestFocus(_commentFocus);
        scrollController.animateTo(JRScreenFitTool.setPx(80),
            duration: Duration(seconds: 1),
            curve: Interval(
              0.2,
              0.375,
              curve: Curves.fastOutSlowIn,
            ));
        setState(() {
          print('_shouldMaskViewShow = $_shouldMaskViewShow');
        });
      },
    );
  }

  Widget buildDemoItem(JRKeywordFirstLevelModel firstLevelModel,
      JRKeywordFirstLevelViewModel keywordFirstLevelViewModel) {
    return Container(
      width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(20),
      height: keywordFirstLevelViewModel
              .isSelectShowAllFirstLevelStringListContains(
                  firstLevelModel.k_first_level_name)
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
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Container(
                  width:
                      JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(30),
                  height: JRScreenFitTool.setPx(35),
                  color: Colors.white,
                ),
                buildTitleArea(keywordFirstLevelViewModel, firstLevelModel),
                buildSecondModelNameCountArea(
                    keywordFirstLevelViewModel, firstLevelModel)
              ],
            ),
          ),
          SizedBox(height: JRScreenFitTool.setPx(15)),
          Container(
            width: JRScreenFitTool.screenWidth,
            height: getHeight(keywordFirstLevelViewModel, firstLevelModel),
            child: GridView.builder(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: JRScreenFitTool.setPx(10),
                    mainAxisSpacing: JRScreenFitTool.setPx(10),
                    childAspectRatio: 3 / 1),
                itemCount:
                    getLength(keywordFirstLevelViewModel, firstLevelModel),
                itemBuilder: (context, index) {
                  JRKeywordSecondLevelModel keywordSecondLevelModel =
                      firstLevelModel.k_second_level_list[index];
                  if (keywordFirstLevelViewModel.isSelectStatus(firstLevelModel,
                      keywordSecondLevelModel.k_second_level_name)) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 245, 244, 1),
                            border: Border.all(
                                color: Color.fromRGBO(100, 190, 184, 1),
                                width: JRScreenFitTool.setPx(1)),
                            borderRadius: BorderRadius.circular(
                                JRScreenFitTool.setPx(2))),
                        alignment: Alignment.center,
                        child: Text(
                            getSecondLevelItemTitle(keywordSecondLevelModel),
                            style: TextStyle(
                                fontSize: JRScreenFitTool.setPx(13),
                                color: Color.fromRGBO(100, 190, 184, 1))),
                      ),
                      onTap: () {
                        keywordSecondLevelItemClickAction(
                            index,
                            keywordFirstLevelViewModel,
                            firstLevelModel,
                            keywordSecondLevelModel);
                      },
                    );
                  } else {
                    return GestureDetector(
                      child: Container(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        alignment: Alignment.center,
                        child: Text(
                            getSecondLevelItemTitle(keywordSecondLevelModel),
                            style: TextStyle(
                                fontSize: JRScreenFitTool.setPx(13),
                                color: Color.fromRGBO(47, 47, 47, 1))),
                      ),
                      onTap: () {
                        keywordSecondLevelItemClickAction(
                            index,
                            keywordFirstLevelViewModel,
                            firstLevelModel,
                            keywordSecondLevelModel);
                      },
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  String getSecondLevelItemTitle(
      JRKeywordSecondLevelModel keywordSecondLevelModel) {
    print('keywordSecondLevelModel = $keywordSecondLevelModel');
    return keywordSecondLevelModel.k_second_level_name.contains(' ')
        ? keywordSecondLevelModel.k_second_level_name.replaceAll(' ', '\n')
        : keywordSecondLevelModel.k_second_level_name;
  }

  int getLength(JRKeywordFirstLevelViewModel firstLevelViewModel,
      JRKeywordFirstLevelModel firstLevelModel) {
    if (firstLevelModel.k_second_level_list.length <= 9) {
      return firstLevelModel.k_second_level_list.length;
    } else {
      if (firstLevelViewModel.isSelectShowAllFirstLevelStringListContains(
          firstLevelModel.k_first_level_name)) {
        return firstLevelModel.k_second_level_list.length;
      } else {
        return 9;
      }
    }
  }

  double getHeight(JRKeywordFirstLevelViewModel firstLevelViewModel,
      JRKeywordFirstLevelModel firstLevelModel) {
    if (firstLevelViewModel.isSelectShowAllFirstLevelStringListContains(
        firstLevelModel.k_first_level_name)) {
      return firstLevelModel.secondLevelAreaRealHeight;
    } else {
      return firstLevelModel.secondLevelAreaHeight;
    }
  }

  Widget buildTitleArea(JRKeywordFirstLevelViewModel keywordFirstLevelViewModel,
      JRKeywordFirstLevelModel firstLevelModel) {
    if (firstLevelModel.k_second_level_list.length > 9) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildFirstLevelTextArea(firstLevelModel),
          GestureDetector(
            child: keywordFirstLevelViewModel
                    .isSelectShowAllFirstLevelStringListContains(
                        firstLevelModel.k_first_level_name)
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
              if (firstLevelModel.k_second_level_list.length <= 9) return;
              if (keywordFirstLevelViewModel
                      .isSelectShowAllFirstLevelStringListContains(
                          firstLevelModel.k_first_level_name) ==
                  true) {
                keywordFirstLevelViewModel
                    .removeFromSelectShowAllFirstLevelStringList(
                        firstLevelModel.k_first_level_name);
              } else {
                keywordFirstLevelViewModel
                    .addTSelectShowAllFirstLevelStringList(
                        firstLevelModel.k_first_level_name);
              }
            },
          )
        ],
      );
    }

    return buildFirstLevelTextArea(firstLevelModel);
  }

  Widget buildFirstLevelTextArea(
      JRKeywordFirstLevelModel screenFirstLevelModel) {
    if (screenFirstLevelModel.k_check_single == true) {
      return Row(
        children: <Widget>[
          Text(
            '${screenFirstLevelModel.k_first_level_name}',
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

    return Text('${screenFirstLevelModel.k_first_level_name}',
        style: TextStyle(
            fontSize: JRScreenFitTool.setPx(20), fontWeight: FontWeight.bold));
  }

  Widget buildSecondModelNameCountArea(
      JRKeywordFirstLevelViewModel keywordFirstLevelViewModel,
      JRKeywordFirstLevelModel keywordFirstLevelModel) {
    return Positioned(
        right: JRScreenFitTool.setPx(25),
        child: Offstage(
            offstage: keywordFirstLevelViewModel
                        .fetchSecondLevelModelNameList(keywordFirstLevelModel)
                        .toList()
                        .length >
                    0
                ? false
                : true,
            child: Container(
              width: JRScreenFitTool.setPx(20),
              height: JRScreenFitTool.setPx(20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(80, 169, 168, 1),
                  borderRadius:
                      BorderRadius.circular(JRScreenFitTool.setPx(15))),
              child: Text(
                  '${keywordFirstLevelViewModel.fetchSecondLevelModelNameList(keywordFirstLevelModel).toList().length}',
                  style: TextStyle(
                      fontSize: JRScreenFitTool.setPx(12),
                      color: Colors.white)),
            )));
  }

  void keywordSecondLevelItemClickAction(
      int index,
      JRKeywordFirstLevelViewModel keywordFirstLevelViewModel,
      JRKeywordFirstLevelModel keywordFirstLevelModel,
      JRKeywordSecondLevelModel keywordSecondLevelModel) {
    int count = 0;

    if (keywordFirstLevelViewModel.isSelectSecondLevelModelNameListContain(
        keywordFirstLevelModel.k_first_level_name,
        keywordSecondLevelModel.k_second_level_name)) {
      keywordFirstLevelViewModel.removeFromKeywordSecondLevelModelNameList(
          index,
          false,
          keywordFirstLevelModel.k_first_level_name,
          keywordSecondLevelModel.k_second_level_name);

      print(
          'keywordFirstLevelViewModel.mapList = ${keywordFirstLevelViewModel.mapList}');
    } else {
      int count = keywordFirstLevelViewModel.mapList.length;
      if (count == 5) {
        print('上限');
        _shouldDialogViewShow = false;
        setState(() {});
        return;
      }

      count += 1;
      print('count = $count');
      keywordFirstLevelViewModel.addToKeywordSecondLevelModelNameList(
          keywordFirstLevelModel,
          keywordFirstLevelModel.k_first_level_name,
          keywordSecondLevelModel.k_second_level_name);

      print(
          'keywordFirstLevelViewModel.mapList = ${keywordFirstLevelViewModel.mapList}');
    }
  }

  // 构建关键词底部滚动工具栏
  Widget buildKeywordBottomToolBarArea() {
    return Consumer<JRKeywordFirstLevelViewModel>(
        builder: (context, keywordFirstLevelVM, child) {
      return Positioned(
          bottom: JRScreenFitTool.statusBarHeight == 44
              ? JRScreenFitTool.setPx(99)
              : JRScreenFitTool.setPx(65),
          child: Offstage(
            offstage: keywordFirstLevelVM
                        .selectKeywordSecondLevelModelNameList.length >
                    0
                ? false
                : true,
            child: JRKeywordBottomToolBar(keywordFirstLevelVM),
          ));
    });
  }

  // 构建上限弹窗
  Widget buildDialogViewArea() {
    return Offstage(
      offstage: _shouldDialogViewShow,
      child: Container(
        width: JRScreenFitTool.screenWidth,
        height: JRScreenFitTool.screenHeight,
        color: Colors.black54,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(80),
              height: JRScreenFitTool.setPx(60),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: JRScreenFitTool.setPx(15)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(JRScreenFitTool.setPx(5)),
                      topRight: Radius.circular(JRScreenFitTool.setPx(5)))),
              child: Text(
                '最多选择5个关键词',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Container(
              width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(80),
              height: JRScreenFitTool.setPx(.5),
              color: Colors.grey[300],
            ),
            GestureDetector(
              child: Container(
                width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(80),
                height: JRScreenFitTool.setPx(40),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(JRScreenFitTool.setPx(5)),
                        bottomRight:
                            Radius.circular(JRScreenFitTool.setPx(5)))),
                child: Text('好',
                    style: TextStyle(
                        fontSize: JRScreenFitTool.setPx(16),
                        color: Color.fromRGBO(81, 168, 161, 1))),
              ),
              onTap: () {
                _shouldDialogViewShow = true;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  // 搜索弹窗相关
  Widget buildSearchContainer() {
    return Offstage(
      offstage: !_shouldMaskViewShow,
      child: Container(
        width: JRScreenFitTool.screenWidth,
        height: JRScreenFitTool.screenHeight,
        child: Column(
          children: <Widget>[buildTopSearchBar(), buildMaskArea()],
        ),
      ),
    );
  }

  Widget buildMaskArea() {
    return GestureDetector(
      child: Container(
        width: JRScreenFitTool.screenWidth,
        height: JRScreenFitTool.screenHeight -
            JRScreenFitTool.statusBarHeight -
            JRScreenFitTool.navBarHeight,
        color: Colors.black54,
        child: Consumer<JRKeywordFirstLevelViewModel>(
            builder: (context, keywordFirstLevelVM, child) {
          List<JRKeywordSecondLevelModel> secondLevelModelList =
              keywordFirstLevelVM.fetchSearchResult(_keyword);
          return Offstage(
            offstage: secondLevelModelList.length > 0 ? false : true,
            child: Container(
              width: JRScreenFitTool.screenWidth,
              height: JRScreenFitTool.screenHeight -
                  JRScreenFitTool.statusBarHeight -
                  JRScreenFitTool.navBarHeight,
              color: Colors.white,
              child: Listener(
                onPointerMove: (movePointEvent) {
                  _commentFocus.unfocus();
                },
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 0),
                    itemCount: secondLevelModelList.length,
                    itemBuilder: (context, index) {
                      JRKeywordSecondLevelModel keywordSecondLevelModel =
                          secondLevelModelList[index];
                      return GestureDetector(
                        child: JRSearchResultItem(keywordSecondLevelModel,
                            index: index),
                        onTap: () {
                          int count = keywordFirstLevelVM.mapList.length;
                          if (count == 5) {
                            print('上限');
                            dismissSearchArea();
                            _shouldDialogViewShow = false;
                            setState(() {});
                            return;
                          }

                          keywordFirstLevelVM
                              .addToKeywordSecondLevelModelNameList(
                                  null,
                                  keywordSecondLevelModel.type,
                                  keywordSecondLevelModel.k_second_level_name);
                          dismissSearchArea();
                        },
                      );
                    }),
              ),
            ),
          );
        }),
      ),
      onTap: () {
        dismissSearchArea();
      },
    );
  }

  Widget buildTopSearchBar() {
    return Stack(
      children: <Widget>[
        Container(
          width: JRScreenFitTool.screenWidth,
          height:
              JRScreenFitTool.statusBarHeight + JRScreenFitTool.navBarHeight,
          color: Colors.white,
        ),
        buildSearchTextField(),
        buildTopSearchBarRightArea()
      ],
    );
  }

  Widget buildSearchTextField() {
    return Positioned(
        bottom: 0,
        left: JRScreenFitTool.setPx(15),
        right: JRScreenFitTool.setPx(85),
        child: Container(
          // width: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(70),
          height: JRScreenFitTool.navBarHeight,
          color: Colors.white,
          child: buildTextField(),
        ));
  }

  Widget buildTextField() {
    return TextField(
      controller: searchController,
      focusNode: _commentFocus,
      onChanged: (value) {
        print(value);
        setState(() {
          _keyword = value;
        });
      },
      cursorColor: Color.fromRGBO(136, 198, 202, 1),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "搜索关键字",
          hintStyle: TextStyle(
              fontSize: JRScreenFitTool.setPx(14),
              color: Color.fromRGBO(195, 195, 195, 1))),
      style:
          TextStyle(fontSize: JRScreenFitTool.setPx(14), color: Colors.black),
    );
  }

  Widget buildTopSearchBarRightArea() {
    return Positioned(
        left: JRScreenFitTool.screenWidth - JRScreenFitTool.setPx(100),
        right: 0,
        bottom: 0,
        child: Container(
          height: JRScreenFitTool.navBarHeight,
          padding: EdgeInsets.fromLTRB(
              JRScreenFitTool.setPx(5), 0, JRScreenFitTool.setPx(5), 0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.highlight_off,
                  size: JRScreenFitTool.setPx(20),
                  color: Colors.grey[400],
                ),
                onTap: () {
                  _keyword = '';
                  searchController.clear();
                  setState(() {});
                },
              ),
              GestureDetector(
                child: Text('取消',
                    style: TextStyle(
                        fontSize: JRScreenFitTool.setPx(15),
                        color: Colors.grey[350])),
                onTap: () {
                  dismissSearchArea();
                },
              )
            ],
          ),
        ));
  }

  void dismissSearchArea() {
    _shouldMaskViewShow = false;
    _commentFocus.unfocus();
    scrollController.animateTo(JRScreenFitTool.setPx(0),
        duration: Duration(seconds: 1),
        curve: Interval(
          0.2,
          0.375,
          curve: Curves.fastOutSlowIn,
        ));
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    _commentFocus.dispose();
    super.dispose();
  }
}
