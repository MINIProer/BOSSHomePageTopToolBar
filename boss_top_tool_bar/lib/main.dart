import 'dart:ui';

import 'package:boss_top_tool_bar/routers/routes.dart';
import 'package:boss_top_tool_bar/tools/screen_fit_tool.dart';
import 'package:boss_top_tool_bar/viewModels/first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/k_first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/s_first_level_view_model.dart';
import 'package:boss_top_tool_bar/viewModels/top_bar_left_button_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => JRFirstLevelViewModel()),
    ChangeNotifierProvider(create: (ctx) => JRScreenFirstLevelViewModel()),
    ChangeNotifierProvider(create: (ctx) => JRKeywordFirstLevelViewModel()),
    ChangeNotifierProvider(create: (ctx) => JRTopBarLeftActionButtonViewModel()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JRScreenFitTool.initialize();
    JRScreenFitTool.setStatusBarHeight(
        MediaQueryData.fromWindow(window).padding.top);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: JRRouter.initialRoute,
      routes: JRRouter.routes,
      onGenerateRoute: JRRouter.generateRoute,
    );
  }
}
