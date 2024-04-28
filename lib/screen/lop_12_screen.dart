import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tinh_diem_hoc_ba/ad_helper.dart';
import 'package:tinh_diem_hoc_ba/screen/common_screen.dart';

class Lop12 extends StatefulWidget {
  const Lop12({super.key});

  @override
  State<Lop12> createState() => _Lop12State();
}

class _Lop12State extends State<Lop12> {
  InterstitialAd? _interstitialAd;

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

  List<TextEditingController> controllerList = [];
  List<GlobalKey> keyList = [
    GlobalKey(),
  ];
  @override
  void initState() {
    super.initState();
    _loadAd();
    controllerList = [
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
            if (_interstitialAd != null) {
              _interstitialAd!.show();
            } else {
              Navigator.pop(context);
            }
          }
        },
        child: CommonScreen(
          title: 'ĐTB cả năm lớp 12',
          key: SubjectKeys.commonKey,
          colList: controllerList,
          colKeyList: keyList,
          hasLop10: false,
        ));
  }
}
