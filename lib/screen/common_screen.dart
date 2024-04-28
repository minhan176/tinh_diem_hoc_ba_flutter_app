import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinh_diem_hoc_ba/ad_helper.dart';
import 'package:tinh_diem_hoc_ba/screen/diem_cac_khoi.dart';
import 'dart:math' as math;

import 'package:tinh_diem_hoc_ba/screen/diem_cac_mon.dart';
import 'package:tinh_diem_hoc_ba/widgets/adaptive_banner_ad.dart';
import 'package:tinh_diem_hoc_ba/widgets/header.dart';
import 'package:tinh_diem_hoc_ba/widgets/primary_button.dart';

class SubjectKeys {
  static final commonKey = GlobalKey(debugLabel: 'commonKey');

  static final toanKey = GlobalKey();
  static final vatLiKey = GlobalKey();
  static final hoaKey = GlobalKey();
  static final TAKey = GlobalKey();
  static final vanKey = GlobalKey();
  static final sinhKey = GlobalKey();
  static final suKey = GlobalKey();
  static final diaLiKey = GlobalKey();
  static final GdcdKey = GlobalKey();

  static final subjectKeyList = [
    toanKey,
    vatLiKey,
    hoaKey,
    TAKey,
    vanKey,
    sinhKey,
    suKey,
    diaLiKey,
    GdcdKey
  ];
}

final _subjectsList = [
  'toan',
  'vatli',
  'hoa',
  'TAnh',
  'van',
  'sinh',
  'su',
  'diali',
  'gdcd'
];

class CommonScreen extends StatefulWidget {
  CommonScreen({
    super.key,
    required this.colList,
    required this.colKeyList,
    required this.hasLop10,
    required this.title,
  });
  List<TextEditingController> colList;
  List<GlobalKey> colKeyList;
  bool hasLop10;
  final String title;

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  InterstitialAd? _interstitialAd;
  InterstitialAd? _interstitialAd2;

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _interstitialAd2?.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadAd();
    _loadAd2();
  }

  void _loadAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiemCacMon(),
                          settings: RouteSettings(arguments: diemTBMap)));
                },
                onAdFailedToShowFullScreenContent: (ad, error) => ad.dispose());

            _interstitialAd = ad;
          },
          onAdFailedToLoad: (error) {},
        ));
  }

  void _loadAd2() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiemCacKhoi(),
                          settings: RouteSettings(arguments: diemKhoiMap)));
                },
                onAdFailedToShowFullScreenContent: (ad, error) => ad.dispose());

            _interstitialAd2 = ad;
          },
          onAdFailedToLoad: (error) {},
        ));
  }

  Map<String, double?> diemTBMap = {};

  Map<String, double?> diemKhoiMap = {};

  bool upDateDiemTBMap() {
    diemTBMap['toan'] =
        (SubjectKeys.toanKey.currentState as _TableBodyState).submit();
    diemTBMap['vatli'] =
        (SubjectKeys.vatLiKey.currentState as _TableBodyState).submit();
    diemTBMap['hoa'] =
        (SubjectKeys.hoaKey.currentState as _TableBodyState).submit();
    diemTBMap['TAnh'] =
        (SubjectKeys.TAKey.currentState as _TableBodyState).submit();
    diemTBMap['van'] =
        (SubjectKeys.vanKey.currentState as _TableBodyState).submit();
    diemTBMap['sinh'] =
        (SubjectKeys.sinhKey.currentState as _TableBodyState).submit();
    diemTBMap['su'] =
        (SubjectKeys.suKey.currentState as _TableBodyState).submit();
    diemTBMap['diali'] =
        (SubjectKeys.diaLiKey.currentState as _TableBodyState).submit();
    diemTBMap['gdcd'] =
        (SubjectKeys.GdcdKey.currentState as _TableBodyState).submit();

    for (final i in diemTBMap.values) {
      if (i == -1) return false;
    }
    return true;
  }

  void upDateDiemKhoiMap() {
    final toan = diemTBMap['toan'] ?? -1;
    final vatLi = diemTBMap['vatli'] ?? -1;
    final hoa = diemTBMap['hoa'] ?? -1;
    final tAnh = diemTBMap['TAnh'] ?? -1;
    final van = diemTBMap['van'] ?? -1;
    final sinh = diemTBMap['sinh'] ?? -1;
    final su = diemTBMap['su'] ?? -1;
    final diaLi = diemTBMap['diali'] ?? -1;
    final gdcd = diemTBMap['gdcd'] ?? -1;

    // A0
    if (toan == -1 || vatLi == -1 || hoa == -1) {
      diemKhoiMap['A0'] = null;
    } else {
      diemKhoiMap['A0'] = toan + vatLi + hoa;
    }

    // A1
    if (toan == -1 || vatLi == -1 || tAnh == -1) {
      diemKhoiMap['A1'] = null;
    } else {
      diemKhoiMap['A1'] = toan + vatLi + tAnh;
    }

    // B0
    if (toan == -1 || hoa == -1 || sinh == -1) {
      diemKhoiMap['B0'] = null;
    } else {
      diemKhoiMap['B0'] = toan + hoa + sinh;
    }

    // C0
    if (van == -1 || su == -1 || diaLi == -1) {
      diemKhoiMap['C0'] = null;
    } else {
      diemKhoiMap['C0'] = van + su + diaLi;
    }

    // C1
    if (van == -1 || toan == -1 || vatLi == -1) {
      diemKhoiMap['C1'] = null;
    } else {
      diemKhoiMap['C1'] = van + toan + vatLi;
    }

    // D1
    if (van == -1 || toan == -1 || tAnh == -1) {
      diemKhoiMap['D1'] = null;
    } else {
      diemKhoiMap['D1'] = van + toan + tAnh;
    }

    // D7
    if (toan == -1 || hoa == -1 || tAnh == -1) {
      diemKhoiMap['D7'] = null;
    } else {
      diemKhoiMap['D7'] = toan + hoa + tAnh;
    }

    // D14
    if (van == -1 || su == -1 || tAnh == -1) {
      diemKhoiMap['D14'] = null;
    } else {
      diemKhoiMap['D14'] = van + su + tAnh;
    }

    // D15
    if (van == -1 || diaLi == -1 || tAnh == -1) {
      diemKhoiMap['D15'] = null;
    } else {
      diemKhoiMap['D15'] = van + diaLi + tAnh;
    }

    // B8
    if (toan == -1 || sinh == -1 || tAnh == -1) {
      diemKhoiMap['B8'] = null;
    } else {
      diemKhoiMap['B8'] = toan + sinh + tAnh;
    }

    // C19
    if (van == -1 || su == -1 || gdcd == -1) {
      diemKhoiMap['C19'] = null;
    } else {
      diemKhoiMap['C19'] = van + su + gdcd;
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.titleLarge!;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        appBar: orientation == Orientation.portrait
            ? AppBar(
                foregroundColor: Colors.white,
                title: Text(
                  widget.title,
                ),
                titleTextStyle: titleTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
                backgroundColor: Colors.lightBlueAccent,
              )
            : null,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              orientation == Orientation.portrait
                  ? AdaptiveBannerAd()
                  : Container(),
              SizedBox(
                height: 10,
              ),
              Expanded(child: ScoreTable()),
              orientation == Orientation.portrait
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  if (upDateDiemTBMap()) {
                                    _loadAd();
                                    if (_interstitialAd != null) {
                                      _interstitialAd!.show();
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiemCacMon(),
                                              settings: RouteSettings(
                                                  arguments: diemTBMap)));
                                    }
                                  }
                                },
                                label: 'Điểm các môn'),
                          ),
                          Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  if (upDateDiemTBMap()) {
                                    upDateDiemKhoiMap();
                                    _loadAd2();
                                    if (_interstitialAd2 != null) {
                                      _interstitialAd2!.show();
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DiemCacKhoi(),
                                              settings: RouteSettings(
                                                  arguments: diemKhoiMap)));
                                    }
                                  }
                                },
                                label: 'Điểm các khối'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}

class ScoreTable extends StatefulWidget {
  ScoreTable({
    super.key,
  });

  @override
  State<ScoreTable> createState() => _ScoreTableState();
}

class _ScoreTableState extends State<ScoreTable> {
  late final ScrollController _controller;
  @override
  void initState() {
    getScore();
    _controller = ScrollController();
    super.initState();
  }

  Future<void> getScore() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < SubjectKeys.subjectKeyList.length; i++) {
      final key = SubjectKeys.subjectKeyList[i];
      final controllerList =
          (key.currentState as _TableBodyState).controllerList;

      switch (i) {
        case 0:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('toan $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('toan1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('toan ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('toan12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('toan11 $i') ?? '';
                }
              }
            }
          }

        case 1:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('vatli $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('vatli1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('vatli ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('vatli12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('vatli11 $i') ?? '';
                }
              }
            }
          }
        case 2:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('hoa $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('hoa1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('hoa ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('hoa12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('hoa11 $i') ?? '';
                }
              }
            }
          }
        case 3:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('TAnh $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('TAnh1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('TAnh ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('TAnh12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('TAnh11 $i') ?? '';
                }
              }
            }
          }
        case 4:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('van $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('van1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('van ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('van12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('van11 $i') ?? '';
                }
              }
            }
          }
        case 5:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('sinh $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('sinh1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('sinh ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('sinh12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('sinh11 $i') ?? '';
                }
              }
            }
          }
        case 6:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('su $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('su1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('su ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('su12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('su11 $i') ?? '';
                }
              }
            }
          }
        case 7:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('diali $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('diali1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('diali ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('diali12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('diali11 $i') ?? '';
                }
              }
            }
          }
        case 8:
          {
            {
              for (int i = 0; i < controllerList.length; i++) {
                if (controllerList.length == 6 || controllerList.length == 5) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('gdcd $i') ?? '';
                } else if (controllerList.length == 3 &&
                    (SubjectKeys.commonKey.currentWidget as CommonScreen)
                        .hasLop10) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('gdcd1011 $i') ?? '';
                } else if (controllerList.length == 3) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('gdcd ${i + 2}') ?? '';
                } else if (controllerList.length == 1) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('gdcd12 $i') ?? '';
                } else if (controllerList.length == 2) {
                  (key.currentState as _TableBodyState).controllerList[i].text =
                      prefs.getString('gdcd11 $i') ?? '';
                }
              }
            }
          }
      }
      ;
    }
  }

  Future<void> saveScore() async {
    final prefs = await SharedPreferences.getInstance();

    List<List<String>> subjectsList = [];

    for (final key in SubjectKeys.subjectKeyList) {
      subjectsList.add((key.currentState as _TableBodyState).getText());
    }
    for (int i = 0; i < subjectsList.length; i++) {
      //toan
      if (i == 0) {
        var subject;
        subject = subjectsList[i];
        for (int i = 0; i < subject.length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('toan $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('toan1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('toan ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('toan12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('toan11 $i', subject[i]);
          }
        }
      }

      //vat li
      if (i == 1) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[1].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('vatli $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('vatli1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('vatli ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('vatli12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('vatli11 $i', subject[i]);
          }
        }
      }
      //hoa
      if (i == 2) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[2].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('hoa $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('hoa1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('hoa ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('hoa12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('hoa11 $i', subject[i]);
          }
        }
      }
      //tieng anh
      if (i == 3) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[3].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('TAnh $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('TAnh1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('TAnh ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('TAnh12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('TAnh11 $i', subject[i]);
          }
        }
      }
      //van
      if (i == 4) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[4].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('van $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('van1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('van ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('van12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('van11 $i', subject[i]);
          }
        }
      }
      //sinh
      if (i == 5) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[5].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('sinh $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('sinh1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('sinh ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('sinh12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('sinh11 $i', subject[i]);
          }
        }
      }
      //su
      if (i == 6) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[6].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('su $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('su1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('su ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('su12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('su11 $i', subject[i]);
          }
        }
      }
      //dia li
      if (i == 7) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[7].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('diali $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('diali1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('diali ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('diali12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('diali11 $i', subject[i]);
          }
        }
      }
      //gdcd
      if (i == 8) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[8].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('gdcd $i', subject[i]);
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('gdcd1011 $i', subject[i]);
          } else if (subject.length == 3) {
            prefs.setString('gdcd ${i + 2}', subject[i]);
          } else if (subject.length == 1) {
            prefs.setString('gdcd12 $i', subject[i]);
          } else if (subject.length == 2) {
            prefs.setString('gdcd11 $i', subject[i]);
          }
        }
      }
    }
    Fluttertoast.showToast(
      msg: 'Đã lưu',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey.shade700,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  Future<void> clearScore() async {
    final prefs = await SharedPreferences.getInstance();

    List<List<TextEditingController>> subjectsList = [];

    for (final key in SubjectKeys.subjectKeyList) {
      subjectsList.add((key.currentState as _TableBodyState).controllerList);
      final keyList = (key.currentState as _TableBodyState).keyList;
      for (final key in keyList) {
        (key.currentState as _TextFieldCellState)._isError = false;
      }
    }
    for (int i = 0; i < subjectsList.length; i++) {
      //toan
      if (i == 0) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subject.length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('toan $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('toan1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('toan ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('toan12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('toan11 $i', '');
          }
        }
      }

      //vat li
      if (i == 1) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[1].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('vatli $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('vatli1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('vatli ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('vatli12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('vatli11 $i', '');
          }
        }
      }
      //hoa
      if (i == 2) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[2].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('hoa $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('hoa1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('hoa ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('hoa12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('hoa11 $i', '');
          }
        }
      }
      //tieng anh
      if (i == 3) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[3].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('TAnh $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('TAnh1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('TAnh ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('TAnh12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('TAnh11 $i', '');
          }
        }
      }
      //van
      if (i == 4) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[4].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('van $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('van1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('van ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('van12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('van11 $i', '');
          }
        }
      }
      //sinh
      if (i == 5) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[5].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('sinh $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('sinh1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('sinh ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('sinh12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('sinh11 $i', '');
          }
        }
      }
      //su
      if (i == 6) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[6].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('su $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('su1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('su ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('su12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('su11 $i', '');
          }
        }
      }
      //dia li
      if (i == 7) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[7].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('diali $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('diali1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('diali ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('diali12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('diali11 $i', '');
          }
        }
      }
      //gdcd
      if (i == 8) {
        var subject;

        subject = subjectsList[i];
        for (int i = 0; i < subjectsList[8].length; i++) {
          if (subject.length == 6 || subject.length == 5) {
            prefs.setString('gdcd $i', '');
          } else if (subject.length == 3 &&
              (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
            prefs.setString('gdcd1011 $i', '');
          } else if (subject.length == 3) {
            prefs.setString('gdcd ${i + 2}', '');
          } else if (subject.length == 1) {
            prefs.setString('gdcd12 $i', '');
          } else if (subject.length == 2) {
            prefs.setString('gdcd11 $i', '');
          }
        }
      }
    }
    setState(
      () {
        getScore();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        controller: _controller,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 12.0),
                  child: Column(
                    children: [
                      Text('* Bạn có thể nhập một vài môn để tính điểm',
                          style: TextStyle(color: Colors.blue)),
                      SizedBox(height: 10),
                      Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: (SubjectKeys.commonKey.currentWidget
                                            as CommonScreen)
                                        .colList
                                        .length ==
                                    1
                                ? FlexColumnWidth(2)
                                : FlexColumnWidth(4),
                          },
                          border:
                              TableBorder.all(color: Colors.black, width: 1),
                          children: [
                            TableRow(
                              children: [
                                TitleCell(title: 'Môn học'),
                                TableHeader()
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'Toán'),
                                TableBody(key: SubjectKeys.toanKey),
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'Vật lí'),
                                TableBody(key: SubjectKeys.vatLiKey),
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'Hóa'),
                                TableBody(key: SubjectKeys.hoaKey),
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'T.Anh'),
                                TableBody(key: SubjectKeys.TAKey),
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'Văn'),
                                TableBody(key: SubjectKeys.vanKey),
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'Sinh'),
                                TableBody(key: SubjectKeys.sinhKey),
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'Sử'),
                                TableBody(key: SubjectKeys.suKey),
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'Địa lí'),
                                TableBody(key: SubjectKeys.diaLiKey),
                              ],
                            ),
                            TableRow(
                              children: [
                                TitleCell(title: 'GDCD'),
                                TableBody(key: SubjectKeys.GdcdKey),
                              ],
                            ),
                          ]),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            child: Text('Xóa hết'),
                            onPressed: () {
                              clearScore();
                            },
                          ),
                          OutlinedButton(
                              child: Text('Lưu điểm'),
                              onPressed: () {
                                saveScore();
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              orientation == Orientation.landscape
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  if ((SubjectKeys.commonKey.currentState
                                          as _CommonScreenState)
                                      .upDateDiemTBMap()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DiemCacMon(),
                                            settings: RouteSettings(
                                                arguments: (SubjectKeys
                                                            .commonKey
                                                            .currentState
                                                        as _CommonScreenState)
                                                    .diemTBMap)));
                                  }
                                },
                                label: 'Điểm các môn'),
                          ),
                          Expanded(
                            child: PrimaryButton(
                                onPressed: () {
                                  if ((SubjectKeys.commonKey.currentState
                                          as _CommonScreenState)
                                      .upDateDiemTBMap()) {
                                    (SubjectKeys.commonKey.currentState
                                            as _CommonScreenState)
                                        .upDateDiemKhoiMap();

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DiemCacKhoi(),
                                            settings: RouteSettings(
                                                arguments: (SubjectKeys
                                                            .commonKey
                                                            .currentState
                                                        as _CommonScreenState)
                                                    .diemKhoiMap)));
                                  }
                                },
                                label: 'Điểm các khối'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

List<TableRow> getHeader() {
  final controllerList =
      (SubjectKeys.commonKey.currentWidget as CommonScreen).colList;
  for (int i = 0; i < controllerList.length; i++) {
    if (controllerList.length == 6) {
      return sauHKHeader;
    } else if (controllerList.length == 5) {
      return namHKHeader;
    } else if (controllerList.length == 3 &&
        (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
      return lop1011Header;
    } else if (controllerList.length == 3) {
      return baHKHeader;
    } else if (controllerList.length == 1) {
      return lop12Header;
    } else if (controllerList.length == 2) {
      return lop11Header;
    }
  }
  return [];
}

Map<int, TableColumnWidth> getHeaderColumnWidth() {
  final controllerList =
      (SubjectKeys.commonKey.currentWidget as CommonScreen).colList;
  for (int i = 0; i < controllerList.length; i++) {
    if (controllerList.length == 6) {
      return {0: FlexColumnWidth()};
    } else if (controllerList.length == 5) {
      return {2: FlexColumnWidth(1 / 2)};
    } else if (controllerList.length == 3 &&
        (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
      return {1: FlexColumnWidth(1 / 2)};
    } else if (controllerList.length == 3) {
      return {1: FlexColumnWidth(1 / 2)};
    } else if (controllerList.length == 1) {
      return {0: FlexColumnWidth()};
    } else if (controllerList.length == 2) {
      return {0: FlexColumnWidth()};
    }
  }
  return {};
}

class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: getHeaderColumnWidth(),
        border: TableBorder.all(color: Colors.black, width: 1),
        children: getHeader());
  }
}

class TitleCell extends StatelessWidget {
  TitleCell({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(title,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
      )),
    );
  }
}

class TableBody extends StatefulWidget {
  TableBody({
    super.key,
  });

  @override
  State<TableBody> createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  @override
  void initState() {
    super.initState();
  }

  List<TextEditingController> controllerList = [
    for (int i = 0;
        i <
            (SubjectKeys.commonKey.currentWidget as CommonScreen)
                .colKeyList
                .length;
        i++)
      TextEditingController()
  ];

  List<GlobalKey> keyList = [
    for (int i = 0;
        i <
            (SubjectKeys.commonKey.currentWidget as CommonScreen)
                .colKeyList
                .length;
        i++)
      GlobalKey()
  ];

  double? submit() {
    double diemTB() {
      var diemTB = 0.0;
      for (final controller in controllerList) {
        diemTB += double.parse(controller.text);
      }

      diemTB = diemTB / controllerList.length * 100;
      var kq = diemTB.round() / 100;

      return kq;
    }

    bool hasNotMatch() {
      for (final controller in controllerList) {
        if (controller.text.isNotEmpty && !_reg.hasMatch(controller.text)) {
          if (_reg.hasMatch(controller.text)) {
            if (double.parse(controller.text) > 10) return true;
          }

          return true;
        }
      }
      return false;
    }

    int i = 0;
    for (final controller in controllerList) {
      if (controller.text.isEmpty) {
        i++;
      }
    }

    if (i != 0 && i < controllerList.length) {
      for (final key in keyList) {
        (key.currentState as _TextFieldCellState).submit();
      }

      return -1;
    } else if (hasNotMatch()) {
      return -1;
    } else if (controllerList[0].text.isNotEmpty) {
      return diemTB();
    }
    return null;
  }

  List<String> getText() {
    return [for (final controller in controllerList) controller.text];
  }

  @override
  Widget build(BuildContext context) {
    List<TextFieldCell> textFieldCellList() {
      var list = <TextFieldCell>[];
      for (int i = 0; i < keyList.length; i++) {
        list.add(TextFieldCell(
          key: keyList[i],
          controller: controllerList[i],
        ));
      }
      return list;
    }

    return Table(
        border: TableBorder.all(color: Colors.black, width: 1),
        children: [TableRow(children: textFieldCellList())]);
  }
}

final _reg = RegExp(r'^(10(\.0+)?|(\d|[1-9]\d)(\.\d+)?)$');

class TextFieldCell extends StatefulWidget {
  const TextFieldCell({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<TextFieldCell> createState() => _TextFieldCellState();
}

class _TextFieldCellState extends State<TextFieldCell> {
  bool _isError = false;

  void submit() {
    setState(() {
      _isError = !_reg.hasMatch(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = 0.0;
    if (!_isError && widget.controller.text.isNotEmpty) {
      value = double.parse(widget.controller.text);
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: (_isError || value > 10) ? Colors.red : Colors.white,
              width: 3)),
      child: TextField(
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: (_isError || value > 10) ? Colors.black : Colors.green),
          controller: widget.controller,
          onChanged: (_) => setState(() {
                if (widget.controller.text.isNotEmpty) {
                  _isError = !_reg.hasMatch(widget.controller.text);
                } else {
                  _isError = false;
                }
                for (final key in SubjectKeys.subjectKeyList) {
                  final cellKeyList =
                      (key.currentState as _TableBodyState).keyList;
                  final controllerList =
                      (key.currentState as _TableBodyState).controllerList;
                  int i = 0;
                  for (final controller in controllerList) {
                    if (controller.text.isEmpty) i++;
                  }
                  if (i == controllerList.length) {
                    for (final cellKey in cellKeyList) {
                      (cellKey.currentState as _TextFieldCellState)._isError =
                          false;
                    }
                  }
                }
              }),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center),
    );
  }
}
