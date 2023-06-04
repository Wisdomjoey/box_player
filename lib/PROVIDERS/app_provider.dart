import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  int _selected = 0;
  int get selected => _selected;

  String _view = 'folder';
  String get view => _view;

  List<bool> _selects = [];
  List<bool> get selects => _selects;

  increaseSelected() {
    _selected++;
    notifyListeners();
  }

  decreaseSelected() {
    _selected--;
    notifyListeners();
  }

  changeView(String next) {
    _view = next;
    notifyListeners();
  }

  setSelected(int numb) {
    _selected = numb;
    notifyListeners();
  }

  initializeSelects(int length) {
    _selects = List.generate(length, (index) => false);
  }

  resetSelects(int length) {
    _selects = List.generate(length, (index) => false);
    notifyListeners();
  }

  updateSelects(bool selected, int index) {
    _selects[index] = selected;
    notifyListeners();
  }
}
