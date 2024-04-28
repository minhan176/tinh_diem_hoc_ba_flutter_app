import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tinh_diem_hoc_ba/ad_helper.dart';
import 'package:tinh_diem_hoc_ba/screen/common_screen.dart';
import 'package:tinh_diem_hoc_ba/widgets/adaptive_banner_ad.dart';

class DiemCacMon extends StatefulWidget {
  DiemCacMon({super.key});

  @override
  State<DiemCacMon> createState() => _DiemCacMonState();
}

class _DiemCacMonState extends State<DiemCacMon> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    _loadAd();
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
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
                  Navigator.pop(context);
                },
                onAdFailedToShowFullScreenContent: (ad, error) => ad.dispose());

            _interstitialAd = ad;
          },
          onAdFailedToLoad: (error) {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (_) {
          if (!_) {
            if (_interstitialAd != null) {
              _interstitialAd!.show();
            } else {
              Navigator.pop(context);
            }
          }
        },
        child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              title: Text(
                'Điểm các môn',
              ),
              backgroundColor: Colors.lightBlueAccent,
            ),
            backgroundColor: Colors.white,
            body: Column(children: [
              AdaptiveBannerAd(),
              Container(
                height: 50,
              ),
              Expanded(child: MonKQTable()),
            ])));
  }
}

class MonKQTable extends StatefulWidget {
  MonKQTable({
    super.key,
  });

  @override
  State<MonKQTable> createState() => _MonnKQTableState();
}

class _MonnKQTableState extends State<MonKQTable> {
  late final ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  String getTitle() {
    final controllerList =
        (SubjectKeys.commonKey.currentWidget as CommonScreen).colList;
    for (int i = 0; i < controllerList.length; i++) {
      if (controllerList.length == 6) {
        return 'TỔNG 6 CỘT / 6';
      } else if (controllerList.length == 5) {
        return 'TỔNG 5 CỘT / 5';
      } else if (controllerList.length == 3 &&
          (SubjectKeys.commonKey.currentWidget as CommonScreen).hasLop10) {
        return 'TỔNG 3 CỘT / 3';
      } else if (controllerList.length == 3) {
        return 'TỔNG 3 CỘT / 3';
      } else if (controllerList.length == 1) {
        return 'ĐTB CẢ NĂM 12';
      } else if (controllerList.length == 2) {
        return 'TỔNG 2 CỘT / 2';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final receivedDiemTB =
        ModalRoute.of(context)!.settings.arguments as Map<String, double?>?;
    print(receivedDiemTB);
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
            controller: _controller,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 40.0),
                  child: Center(
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1.3),
                          1: FlexColumnWidth(2),
                        },
                        border: TableBorder.all(color: Colors.black, width: 1),
                        children: [
                          TableRow(
                            children: [
                              StyledTitleCell(
                                title: 'MÔN HỌC',
                                fontWeight: FontWeight.bold,
                              ),
                              StyledTitleCell(
                                title: getTitle(),
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Toán'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['toan'] ?? ''}')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Vật lí'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['vatli'] ?? ''}')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Hóa'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['hoa'] ?? ''}')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'T.Anh'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['TAnh'] ?? ''}')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Văn'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['van'] ?? ''}')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Sinh'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['sinh'] ?? ''}')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Sử'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['su'] ?? ''}')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Địa lí'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['diali'] ?? ''}')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'GDCD'),
                              StyledTitleCell(
                                  title: '${receivedDiemTB?['gdcd'] ?? ''}')
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            )));
  }
}

class StyledTitleCell extends StatelessWidget {
  StyledTitleCell({super.key, required this.title, this.fontWeight});
  final String title;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontWeight: fontWeight ?? FontWeight.normal)),
      )),
    );
  }
}
