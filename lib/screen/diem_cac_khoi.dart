import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tinh_diem_hoc_ba/ad_helper.dart';
import 'package:tinh_diem_hoc_ba/screen/diem_cac_mon.dart';
import 'package:tinh_diem_hoc_ba/widgets/adaptive_banner_ad.dart';

class DiemCacKhoi extends StatefulWidget {
  DiemCacKhoi({super.key});

  @override
  State<DiemCacKhoi> createState() => _DiemCacKhoiState();
}

class _DiemCacKhoiState extends State<DiemCacKhoi> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
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
                'Điểm các tổ hợp',
              ),
              backgroundColor: Colors.lightBlueAccent,
            ),
            backgroundColor: Colors.white,
            body: Column(children: [
              AdaptiveBannerAd(),
              Container(
                height: 30,
              ),
              Expanded(child: khoiKQTable()),
            ])));
  }
}

class khoiKQTable extends StatefulWidget {
  khoiKQTable({
    super.key,
  });

  @override
  State<khoiKQTable> createState() => _khoiKQTableState();
}

class _khoiKQTableState extends State<khoiKQTable> {
  late final ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final receivedDiemKhoi =
        ModalRoute.of(context)!.settings.arguments as Map<String, double?>?;
    print(receivedDiemKhoi);
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
                      horizontal: 8.0, vertical: 20.0),
                  child: Center(
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        border: TableBorder.all(color: Colors.black, width: 1),
                        children: [
                          TableRow(
                            children: [
                              StyledTitleCell(
                                title: 'TỔ HỢP',
                                fontWeight: FontWeight.bold,
                              ),
                              StyledTitleCell(
                                title: 'ĐIỂM',
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối A0'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['A0']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối A1'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['A1']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối B0'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['B0']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối C0'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['C0']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối C1'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['C1']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối D1'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['D1']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối D7'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['D7']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối D14'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['D14']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối D15'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['D15']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối B8'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['B8']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                          TableRow(
                            children: [
                              StyledTitleCell(title: 'Khối C19'),
                              StyledTitleCell(
                                  title: receivedDiemKhoi?['C19']
                                          ?.toStringAsFixed(2) ??
                                      '')
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            )));
  }
}
