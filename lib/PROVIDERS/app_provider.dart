import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _view = 'folder';
  String get view => _view;

  String _appbarTitle = 'Folders';
  String get appbarTitle => _appbarTitle;

  changeView(String next) {
    _view = next;
    notifyListeners();
  }

  changeTitle(String title) {
    _appbarTitle = title;
    notifyListeners();
  }
}
