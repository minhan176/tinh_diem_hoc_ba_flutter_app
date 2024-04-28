import 'package:flutter/material.dart';
import 'package:tinh_diem_hoc_ba/screen/common_screen.dart';

class SauHK extends StatefulWidget {
  const SauHK({super.key});

  @override
  State<SauHK> createState() => _SauHKState();
}

class _SauHKState extends State<SauHK> {
  List<TextEditingController> controllerList = [];
  List<GlobalKey> keyList = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
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
          title: 'Tính điểm 6 học kì',
          key: SubjectKeys.commonKey,
          colList: controllerList,
          colKeyList: keyList,
          hasLop10: false,
        ));
  }
}
