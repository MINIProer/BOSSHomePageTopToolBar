import 'package:boss_top_tool_bar/tools/json_parse.dart';
import 'package:boss_top_tool_bar/widgets/boss_top_tool_bar.dart';
import 'package:flutter/material.dart';

class JRHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JRJsonParse.getLevelsData();

    return JRBossTopToolBar();
  }
}
