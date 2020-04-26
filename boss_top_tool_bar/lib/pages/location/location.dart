import 'package:boss_top_tool_bar/pages/location/location_content.dart';
import 'package:flutter/material.dart';

class JRLocationPage extends StatelessWidget {
  static const String routeName = '/location';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JRLocationContent(),
    );
  }
}
