import 'package:flutter/material.dart';
import 'package:tinh_diem_hoc_ba/screen/common_screen.dart';

class BaHK extends StatefulWidget {
  const BaHK({super.key});

  @override
  State<BaHK> createState() => _BaHKState();
}

class _BaHKState extends State<BaHK> {
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
          title: 'Tính điểm 3 học kì',
          key: SubjectKeys.commonKey,
          colList: controllerList,
          colKeyList: keyList,
          hasLop10: false,
        ));
  }
}
