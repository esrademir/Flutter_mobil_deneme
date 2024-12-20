import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:burc_yorumlari/ad_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class HoroscopeDetailPage extends StatefulWidget {
  final String horoscopeName;

  HoroscopeDetailPage({required this.horoscopeName});

  @override
  _HoroscopeDetailPageState createState() => _HoroscopeDetailPageState();
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
        ],
      ))),
    );
  }
}

String durum = 'Başladı';

late String _dailyHoroscope = '';
late String _weeklyHoroscope = '';
late String _monthlyHoroscope = '';

late String _loveHoroscopeTitle = '';
late String _loveHoroscopeComment = '';

late String _dietHoroscopeTitle = '';
late String _dietHoroscopeComment = '';

late String _careerHoroscopeTitle = '';
late String _careerHoroscopeComment = '';

late String _positiveHoroscopeTitle = '';
late String _positiveHoroscopeComment = '';

late String _negativeHoroscopeTitle = '';
late String _negativeHoroscopeComment = '';

late String _healthHoroscopeTitle = '';
late String _healthHoroscopeComment = '';

late String _styleHoroscopeTitle = '';
late String _styleHoroscopeComment = '';

bool isLoading = true;
BannerAd? _bannerAd;

class BurcGunluk extends StatefulWidget {
  final String horoscopeName;

  BurcGunluk({required this.horoscopeName});

  @override
  _BurcGunlukPageState createState() => _BurcGunlukPageState();
}

class BannerAdmob extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BannerAdmobState();
  }
}

class _BannerAdmobState extends State<BannerAdmob> {
  late BannerAd _bannerAd;
  bool _bannerReady = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _bannerReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          setState(() {
            _bannerReady = false;
          });
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerReady
        ? SizedBox(
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : Container();
  }
}

class _BurcGunlukPageState extends State<BurcGunluk> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: BannerAdmob(),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            widget.horoscopeName,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          Image.asset(
                            "assests/images/${widget.horoscopeName.toLowerCase()}.png",
                            height: 75,
                            width: 75,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "Burcunuzun günlük yorumunu okuyun.",
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "Günlük Yorum",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            _dailyHoroscope,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class BurcHaftalik extends StatefulWidget {
  final String horoscopeName;

  BurcHaftalik({required this.horoscopeName});

  @override
  _BurcHaftalikPageState createState() => _BurcHaftalikPageState();
}

class _BurcHaftalikPageState extends State<BurcHaftalik> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: BannerAdmob(),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            widget.horoscopeName,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          Image.asset(
                            "assests/images/${widget.horoscopeName.toLowerCase()}.png",
                            height: 75,
                            width: 75,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "Burcunuzun haftalık yorumunu okuyun.",
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "Haftalık Yorum",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            _weeklyHoroscope,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class BurcAylik extends StatefulWidget {
  final String horoscopeName;

  BurcAylik({required this.horoscopeName});

  @override
  _BurcAylikPageState createState() => _BurcAylikPageState();
}

class _BurcAylikPageState extends State<BurcAylik> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.0),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                            ),
                            height: 50,
                            width: double.infinity,
                            child: BannerAdmob(),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            widget.horoscopeName,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          Image.asset(
                            "assests/images/${widget.horoscopeName.toLowerCase()}.png",
                            height: 75,
                            width: 75,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "Burcunuzun aylık yorumunu okuyun.",
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "Aylık Yorum",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            _monthlyHoroscope,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class BurcOzellik extends StatefulWidget {
  final String horoscopeName;

  BurcOzellik({required this.horoscopeName});

  @override
  _BurcOzellikPageState createState() => _BurcOzellikPageState();
}

class _BurcOzellikPageState extends State<BurcOzellik> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 30.0),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                            ),
                            height: 50,
                            width: double.infinity,
                            child: BannerAdmob(),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            widget.horoscopeName,
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          Image.asset(
                            "assests/images/${widget.horoscopeName.toLowerCase()}.png",
                            height: 75,
                            width: 75,
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            "Burcunuzun özelliklerini keşfedin.",
                            style: TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20.0),
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 5),
                                            constraints: const BoxConstraints(
                                                minWidth: 25,
                                                minHeight: 15,
                                                maxHeight: 75),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0))),
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                      "${widget.horoscopeName} Burcu - Aşk Özellikleri"),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Container(
                                                              child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(_loveHoroscopeTitle,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                      const Text('\n'),
                                                      Text(
                                                          _loveHoroscopeComment)
                                                    ],
                                                  ))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Tamam'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: const Icon(
                                                        Icons.favorite,
                                                        color: Colors.white,
                                                        size: 14),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Text('AŞK ',
                                                        style: GoogleFonts.montserrat(
                                                            textStyle: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.5,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 5),
                                            constraints: const BoxConstraints(
                                                minWidth: 25,
                                                minHeight: 15,
                                                maxHeight: 75),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0))),
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                      '${widget.horoscopeName} Burcu - Kariyer Özellikleri'),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Container(
                                                              child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          _careerHoroscopeTitle,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                      const Text('\n'),
                                                      Text(
                                                          _careerHoroscopeComment)
                                                    ],
                                                  ))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Tamam'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: const Icon(
                                                        Icons.business_center,
                                                        color: Colors.white,
                                                        size: 14),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Text('KARİYER',
                                                        style: GoogleFonts.montserrat(
                                                            textStyle: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.5,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 5),
                                            constraints: const BoxConstraints(
                                                minWidth: 25,
                                                minHeight: 15,
                                                maxHeight: 75),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0))),
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                      '${widget.horoscopeName} Burcu - Diyet Özellikleri'),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Container(
                                                              child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(_dietHoroscopeTitle,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                      const Text('\n'),
                                                      Text(
                                                          _dietHoroscopeComment)
                                                    ],
                                                  ))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Tamam'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: const Icon(
                                                        Icons.restaurant,
                                                        color: Colors.white,
                                                        size: 14),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Text('DİYET',
                                                        style: GoogleFonts.montserrat(
                                                            textStyle: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.5,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 5),
                                            constraints: const BoxConstraints(
                                                minWidth: 25,
                                                minHeight: 15,
                                                maxHeight: 75),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0))),
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                      '${widget.horoscopeName} Burcu - Olumlu Yönleri'),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Container(
                                                              child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          _positiveHoroscopeTitle,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                      const Text('\n'),
                                                      Text(
                                                          _positiveHoroscopeComment)
                                                    ],
                                                  ))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Tamam'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: const Icon(
                                                        Icons.add_circle,
                                                        color: Colors.white,
                                                        size: 14),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Text('OLUMLU YÖNLER',
                                                        style: GoogleFonts.montserrat(
                                                            textStyle: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.5,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 5),
                                            constraints: const BoxConstraints(
                                                minWidth: 25,
                                                minHeight: 15,
                                                maxHeight: 75),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0))),
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                      '${widget.horoscopeName} Burcu - Sağlık Özellikleri'),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Container(
                                                              child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          _healthHoroscopeTitle,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                      const Text('\n'),
                                                      Text(
                                                          _healthHoroscopeComment)
                                                    ],
                                                  ))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Tamam'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: const Icon(
                                                        Icons.emergency,
                                                        color: Colors.white,
                                                        size: 14),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Text('SAĞLIK',
                                                        style: GoogleFonts.montserrat(
                                                            textStyle: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.5,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 5),
                                            constraints: const BoxConstraints(
                                                minWidth: 25,
                                                minHeight: 15,
                                                maxHeight: 75),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0))),
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                      '${widget.horoscopeName} Burcu - Olumsuz Yönleri'),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Container(
                                                              child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          _negativeHoroscopeTitle,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                      const Text('\n'),
                                                      Text(
                                                          _negativeHoroscopeComment)
                                                    ],
                                                  ))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Tamam'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: const Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.white,
                                                        size: 14),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Text(
                                                        'OLUMSUZ YÖNLER',
                                                        style: GoogleFonts.montserrat(
                                                            textStyle: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.5,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 5),
                                            constraints: const BoxConstraints(
                                                minWidth: 25,
                                                minHeight: 15,
                                                maxHeight: 75),
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0))),
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                      '${widget.horoscopeName} Burcu - Stil Özellikleri'),
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Container(
                                                              child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(_styleHoroscopeTitle,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  textStyle:
                                                                      const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ))),
                                                      const Text('\n'),
                                                      Text(
                                                          _styleHoroscopeComment)
                                                    ],
                                                  ))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Tamam'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: const Icon(
                                                        Icons.shopping_bag,
                                                        color: Colors.white,
                                                        size: 14),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: Text('STİL',
                                                        style: GoogleFonts.montserrat(
                                                            textStyle: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17.5,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _HoroscopeDetailPageState extends State<HoroscopeDetailPage> {
  @override
  void initState() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    super.initState();
    _getHoroscopes();
  }

  void _getHoroscopes() async {
    final db = await mongo.Db.create(
        'mongodb+srv://bozkitoski_admin:Batuhan54@burclarbozki.lof87jj.mongodb.net/Burclarbozki?retryWrites=true&w=majority');

    await db.open();

    String formatted = widget.horoscopeName
        .toLowerCase()
        .replaceAll("ç", "c")
        .replaceAll("ğ", "g")
        .replaceAll("ş", "s")
        .replaceAll("ı", "i");

    final collection = db.collection('${formatted}Burc');
    final result =
        await collection.findOne(mongo.where.eq('name', widget.horoscopeName));

    List<String> _bolParagraflara(String metin) {
      List<String> paragraflar = [];
      var cumleler = metin.split('.');

      for (int i = 0; i < cumleler.length - 1; i += 2) {
        var birinciCumle = cumleler[i].trim().replaceAll('&#8217;', "'");
        var ikinciCumle = cumleler[i + 1].trim().replaceAll('&#8217;', "'");

        if (birinciCumle.isNotEmpty &&
            ikinciCumle.isNotEmpty &&
            birinciCumle != "." &&
            ikinciCumle != ".") {
          if (!birinciCumle.endsWith(".")) {
            birinciCumle += ".";
          }

          if (!ikinciCumle.endsWith(".")) {
            ikinciCumle += ".";
          }

          var birlesikCumle = birinciCumle
                  .replaceAll('&#8220;', '“')
                  .replaceAll('&#8221;', '”') +
              " " +
              ikinciCumle.replaceAll('&#8220;', '“').replaceAll('&#8221;', '”');

          paragraflar.add(birlesikCumle);
        }
      }

      return paragraflar;
    }

    setState(() {
      _dailyHoroscope =
          _bolParagraflara(result?['${formatted}Gunluk'] ?? '').join('\n\n');
      _weeklyHoroscope =
          _bolParagraflara(result?['${formatted}Haftalik'] ?? '').join('\n\n');
      _monthlyHoroscope =
          _bolParagraflara(result?['${formatted}Aylik'] ?? '').join('\n\n');

      _loveHoroscopeTitle =
          _bolParagraflara(result?['${formatted}AskBaslik'] ?? '').join('\n\n');
      _loveHoroscopeComment =
          _bolParagraflara(result?['${formatted}AskYorum'] ?? '').join('\n\n');

      _dietHoroscopeTitle =
          _bolParagraflara(result?['${formatted}DiyetBaslik'] ?? '')
              .join('\n\n');
      _dietHoroscopeComment =
          _bolParagraflara(result?['${formatted}DiyetYorum'] ?? '')
              .join('\n\n');

      _careerHoroscopeTitle =
          _bolParagraflara(result?['${formatted}KariyerBaslik'] ?? '')
              .join('\n\n');
      _careerHoroscopeComment =
          _bolParagraflara(result?['${formatted}KariyerYorum'] ?? '')
              .join('\n\n');

      _positiveHoroscopeTitle =
          _bolParagraflara(result?['${formatted}OlumluYonBaslik'] ?? '')
              .join('\n\n');
      _positiveHoroscopeComment =
          _bolParagraflara(result?['${formatted}OlumluYonYorum'] ?? '')
              .join('\n\n');

      _negativeHoroscopeTitle =
          _bolParagraflara(result?['${formatted}OlumsuzYonBaslik'] ?? '')
              .join('\n\n');
      _negativeHoroscopeComment =
          _bolParagraflara(result?['${formatted}OlumsuzYonYorum'] ?? '')
              .join('\n\n');

      _healthHoroscopeTitle =
          _bolParagraflara(result?['${formatted}SaglikBaslik'] ?? '')
              .join('\n\n');
      _healthHoroscopeComment =
          _bolParagraflara(result?['${formatted}SaglikYorum'] ?? '')
              .join('\n\n');

      _styleHoroscopeTitle =
          _bolParagraflara(result?['${formatted}StilBaslik'] ?? '')
              .join('\n\n');
      _styleHoroscopeComment =
          _bolParagraflara(result?['${formatted}StilYorum'] ?? '').join('\n\n');
      isLoading = false;
    });
    await db.close();
  }

  Future<bool> _onWillPop() async {
    _dailyHoroscope = '';
    _weeklyHoroscope = '';
    _monthlyHoroscope = '';
    _loveHoroscopeTitle = '';
    _loveHoroscopeComment = '';
    _dietHoroscopeTitle = '';
    _dietHoroscopeComment = '';
    _careerHoroscopeTitle = '';
    _careerHoroscopeComment = '';
    _positiveHoroscopeTitle = '';
    _positiveHoroscopeComment = '';
    _negativeHoroscopeTitle = '';
    _negativeHoroscopeComment = '';
    _healthHoroscopeTitle = '';
    _healthHoroscopeComment = '';
    _styleHoroscopeTitle = '';
    _styleHoroscopeComment = '';
    isLoading = true;
    Navigator.of(context).pop();
    return true; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: isLoading
                ? LoadingIndicator()
                : Scaffold(
                    appBar: AppBar(
                      title: Text('${widget.horoscopeName} Burç Detayları'),
                      bottom: const TabBar(
                        tabs: [
                          Tab(text: 'Günlük'),
                          Tab(text: 'Haftalık'),
                          Tab(text: 'Aylık'),
                          Tab(
                            text: 'Özellikler',
                          ),
                        ],
                      ),
                      leading: BackButton(
                        onPressed: () {
                          _dailyHoroscope = '';
                          _weeklyHoroscope = '';
                          _monthlyHoroscope = '';
                          isLoading = true;
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        BurcGunluk(
                          horoscopeName: widget.horoscopeName,
                        ),
                        BurcHaftalik(horoscopeName: widget.horoscopeName),
                        BurcAylik(
                          horoscopeName: widget.horoscopeName,
                        ),
                        BurcOzellik(
                          horoscopeName: widget.horoscopeName,
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
