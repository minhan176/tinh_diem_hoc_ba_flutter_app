import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  List<TextEditingController> controllerList = [];
  List<GlobalKey> keyList = [];
  bool hasLop10 = false;

  List<TextEditingController> get colControllers => controllerList;
  List<GlobalKey> get colKeys => keyList;

  set colControllers(List<TextEditingController> list) => controllerList = list;
  set colKeys(List<GlobalKey> list) => keyList = list;
}
