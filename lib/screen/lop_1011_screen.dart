import 'package:flutter/material.dart';
import 'package:tinh_diem_hoc_ba/screen/common_screen.dart';

class Lop1011 extends StatefulWidget {
  const Lop1011({super.key});

  @override
  State<Lop1011> createState() => _Lop1011State();
}

class _Lop1011State extends State<Lop1011> {
  List<TextEditingController> controllerList = [];
  List<GlobalKey> keyList = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  @override
  void initState() {
    super.initState();
    controllerList = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(keyList);
    return PopScope(
        canPop: false,
        onPopInvoked: (_) {
          if (!_) {
            Navigator.pop(context);
          }
        },
        child: CommonScreen(
          title: 'ĐTB năm lớp 10,11 và HKI 12',
          key: SubjectKeys.commonKey,
          colList: controllerList,
          colKeyList: keyList,
          hasLop10: true,
        ));
  }
}
