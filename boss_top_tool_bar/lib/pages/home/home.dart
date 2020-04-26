import 'package:boss_top_tool_bar/pages/home/home_content.dart';
import 'package:flutter/material.dart';

class JRHomePage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('仿Boss直聘筛选工具栏'),
        backgroundColor: Color.fromRGBO(99, 191, 184, 1),
      ),
      body: JRHomeContent(),
    );
  }
}
