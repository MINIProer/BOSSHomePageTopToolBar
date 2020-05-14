import 'package:boss_top_tool_bar/pages/keyword/keyword_content.dart';
import 'package:flutter/material.dart';

class JRKeywordPage extends StatelessWidget {
  static const String routeName = '/keyword';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body: JRKeywordContent(),
    );
  }
}
