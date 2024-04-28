import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tinh_diem_hoc_ba/ad_helper.dart';
import 'package:tinh_diem_hoc_ba/screen/common_screen.dart';

class NamHK extends StatefulWidget {
  const NamHK({super.key});

  @override
  State<NamHK> createState() => _NamHKState();
}

class _NamHKState extends State<NamHK> {
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
    ];
    _loadAd();
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
          title: 'Tính điểm 5 học kì',
          key: SubjectKeys.commonKey,
          colList: controllerList,
          colKeyList: keyList,
          hasLop10: false,
        ));
  }
}
