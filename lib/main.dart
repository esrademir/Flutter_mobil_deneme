import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'HoroscopeDetailPage.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart';
import 'HoroscopeCalculatorPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //bool showPopup = prefs.getBool('showPopup') ?? true;
  bool showPopup = true;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('Token bilgisi: ${fcmToken}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.notification!.body}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  print('User granted permission: ${settings.authorizationStatus}');

  if (showPopup) {
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //notif gösterme gerek yok. düzenli notif gönder
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      //Bildirim ayarlarında kapalı auth göster
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      //Bildirim ilk defa ayarlıyor mutlaka göster
    }
    await prefs.setBool('showPopup', false);
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Received background message!');
  print('Message data: ${message.notification!.body}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }

  // Bildirimi göstermek veya işlem yapmak için gerekli kodları buraya ekleyebilirsiniz
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burç Yorumları',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: HoroscopeHomePage(),
    );
  }
}

class HoroscopeHomePage extends StatefulWidget {
  @override
  _HoroscopeHomePageState createState() => _HoroscopeHomePageState();
}

class _HoroscopeHomePageState extends State<HoroscopeHomePage> {
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = HoroscopeHomePage();
  }

  int selectedIndex = 0;

  final List<String> _horoscopeNames = [
    "Koç",
    "Boğa",
    "İkizler",
    "Yengeç",
    "Aslan",
    "Başak",
    "Terazi",
    "Akrep",
    "Yay",
    "Oğlak",
    "Kova",
    "Balık"
  ];

  final List<String> _horoscopeDates = [
    "21 Mart – 20 Nisan",
    "21 Nisan – 20 Mayıs",
    "21 Mayıs – 20 Haziran",
    "21 Haziran – 22 Temmuz",
    "23 Temmuz – 22 Ağustos",
    "23 Ağustos – 22 Eylül",
    "23 Eylül – 22 Ekim",
    "23 Ekim – 22 Kasım",
    "23 Kasım – 21 Aralık",
    "22 Aralık – 19 Ocak",
    "20 Ocak – 18 Şubat",
    "19 Şubat – 20 Mart"
  ];

  Future<bool> _onWillPop() async {
    return false;
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BurcHesaplamaSayfasi()),
      ).then((_) {
        setState(() {
          selectedIndex = 0; // Ayarlardan dönüşte seçili indeksi sıfırla
        });
      });
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      ).then((_) {
        setState(() {
          selectedIndex = 0; // Ayarlardan dönüşte seçili indeksi sıfırla
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Burç Yorumları"),
        ),
        body: GridView.builder(
          itemCount: _horoscopeNames.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 2),
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HoroscopeDetailPage(
                      horoscopeName: _horoscopeNames[index],
                    ),
                  ),
                );
                // Burç kartına tıklandığında yapılacak işlemler
              },
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _horoscopeNames[index],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Image.asset(
                      "assests/images/${_horoscopeNames[index].toLowerCase()}.png",
                      height: 50.0,
                      width: 50.0,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      _horoscopeDates[index],
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Burç detaylarınızı keşfetmek için dokunun.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Anasayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Burç Hesaplama',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ayarlar',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onTabTapped,
        ),
      ),
    );
  }
}
