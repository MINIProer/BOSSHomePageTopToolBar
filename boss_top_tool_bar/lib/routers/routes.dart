
import 'package:boss_top_tool_bar/pages/home/home.dart';
import 'package:boss_top_tool_bar/pages/location/location.dart';
import 'package:flutter/material.dart';

class JRRouter {
  static const String initialRoute = JRHomePage.routeName;

  static final Map<String, WidgetBuilder> routes = {
    JRHomePage.routeName: (ctx) => JRHomePage(),
  };

  // 钩子函数
  static final RouteFactory generateRoute = (setttings) {
    if (setttings.name == JRLocationPage.routeName) { // modal方式弹出页面
        return MaterialPageRoute(builder: (ctx) {
          return JRLocationPage();
        },
        fullscreenDialog: true
      );
    }

    return null;
  };
}
