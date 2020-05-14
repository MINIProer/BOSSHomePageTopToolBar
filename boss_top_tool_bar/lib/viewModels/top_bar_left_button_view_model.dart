import 'package:flutter/material.dart';

class JRTopBarLeftActionButtonViewModel extends ChangeNotifier {
  String _selectLeftActionButtonName;
  String get selectLeftActionButtonName {
    return _selectLeftActionButtonName;
  }

  set setSelectLeftActionButtonName(String name) {
    _selectLeftActionButtonName = name;
    notifyListeners();
  }

  JRTopBarLeftActionButtonViewModel() {
    _selectLeftActionButtonName = '推荐';
    notifyListeners();
  }
}
