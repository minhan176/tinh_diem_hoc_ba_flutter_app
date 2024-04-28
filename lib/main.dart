import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tinh_diem_hoc_ba/ad_helper.dart';
import 'package:tinh_diem_hoc_ba/screen/ba_hk_screen.dart';
import 'package:tinh_diem_hoc_ba/screen/lop_1011_screen.dart';
import 'package:tinh_diem_hoc_ba/screen/lop_11_screen.dart';
import 'package:tinh_diem_hoc_ba/screen/lop_12_screen.dart';
import 'package:tinh_diem_hoc_ba/screen/nam_hk._screen.dart';
import 'package:tinh_diem_hoc_ba/screen/sau_hk_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
      )),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => _widgetList[1]));
                },
                onAdFailedToShowFullScreenContent: (ad, error) => ad.dispose());

            _interstitialAd = ad;
          },
          onAdFailedToLoad: (error) {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.headlineSmall!;
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('images/icon_launcher.png'),
        title: Text(
          'TÍNH ĐIỂM HỌC BẠ',
        ),
        titleTextStyle: titleTextStyle.copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(children: [
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(_titleList.length, (index) {
                      final title = _titleList[index];

                      final subTitle = _subTitleList[index];
                      if (index == 1) {
                        return ListItem(
                          isTitle: false,
                          title: title,
                          subTitle: subTitle,
                          onPressed: () {
                            _loadAd();
                            if (_interstitialAd != null) {
                              _interstitialAd!.show();
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => _widgetList[1]));
                            }
                          },
                        );
                      } else {
                        return ListItem(
                            isTitle: index == 3 || index == 5,
                            title: title,
                            subTitle: subTitle,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => _widgetList[index])));
                      }
                    }),
                  ),
                ),
              ),
            );
          }),
        )
      ]),
    );
  }
}

List<Widget> _widgetList = [
  NamHK(),
  BaHK(),
  Lop12(),
  Lop11(),
  SauHK(),
  Lop1011()
];

class ListItem extends StatelessWidget {
  ListItem(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onPressed,
      required this.isTitle});
  final String title;
  final String subTitle;
  final bool isTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.titleLarge!;
    final subTitleTextStyle = Theme.of(context).textTheme.bodyLarge!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Card(
        child: Ink(
          child: InkWell(
            onTap: onPressed,
            child: Column(children: [
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(title,
                    textAlign: TextAlign.center,
                    style:
                        titleTextStyle.copyWith(fontWeight: FontWeight.w400)),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: isTitle
                      ? titleTextStyle.copyWith(fontWeight: FontWeight.w400)
                      : subTitleTextStyle.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(height: 12),
            ]),
          ),
        ),
      ),
    );
  }
}

const _titleList = <String>[
  'Xét điểm 5 học kì',
  'Xét điểm 3 học kì',
  'Xét ĐTB cả năm lớp 12',
  'Xét ĐTB cả năm lớp 11 và học',
  'Xét điểm 6 học kì',
  'Xét ĐTB cả năm lớp 10, lớp 11'
];

const _subTitleList = <String>[
  '(Trừ học kì II lớp 12)',
  '(Học kì I,II lớp 11 và học kì I lớp 12)',
  '(ĐTB cả năm của 3 môn)',
  'kì I lớp 12',
  '(6 học kì của 3 năm học)',
  'và học kì I lớp 12'
];
