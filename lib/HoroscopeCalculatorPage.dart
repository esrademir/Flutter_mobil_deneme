import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:html/parser.dart' as parser;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:burc_yorumlari/ad_helper.dart';

enum Horoscope {
  Koc,
  Boga,
  Ikizler,
  Yengec,
  Aslan,
  Basak,
  Terazi,
  Akrep,
  Yay,
  Oglak,
  Kova,
  Balik,
}

String seciliSecenek = '';
String dogumTarihi = '';
String cinsiyet = '';
String dogumSaat = '';
String dogumDakika = '';
String dogumSehri = '';
String onunBurcuFinal = "";
String seninBurcunFinal = "";
int gender = 0;
String gun = "";
String ay = "";
String yil = "";
String lat = "";
String lon = "";
String place = "";
String yukselenBurc = "";
String alcalanBurc = "";
String horoscopeName = "";
List<String> sehirlereListesi = [
  'ADANA',
  'ADIYAMAN',
  'AFYON',
  'AĞRI',
  'AKSARAY',
  'AMASYA',
  'ANKARA',
  'ANTALYA',
  'ARDAHAN',
  'ARTVİN',
  'AYDIN',
  'BALIKESİR',
  'BARTIN',
  'BATMAN',
  'BAYBURT',
  'BİLECİK',
  'BİNGÖL',
  'BİTLİS',
  'BOLU',
  'BURDUR',
  'BURSA',
  'ÇANAKKALE',
  'ÇANKIRI',
  'ÇORUM',
  'DENİZLİ',
  'DİYARBAKIR',
  'DÜZCE',
  'EDİRNE',
  'ELAZIĞ',
  'ERZİNCAN',
  'ERZURUM',
  'ESKİŞEHİR',
  'GAZİANTEP',
  'GİRESUN',
  'GÜMÜŞHANE',
  'HAKKARİ',
  'HATAY',
  'IĞDIR',
  'ISPARTA',
  'İSTANBUL',
  'İZMİR',
  'KAHRAMANMARAŞ',
  'KARABüK',
  'KARAMAN',
  'KARS',
  'KASTAMONU',
  'KAYSERİ',
  'KIRIKKALE',
  'KIRKLARELİ',
  'KIRŞEHİR',
  'KİLİS',
  'KOCAELİ',
  'KONYA',
  'KÜTAHYA',
  'MALATYA',
  'MANİSA',
  'MARDİN',
  'MERSİN',
  'MUĞLA',
  'MUŞ',
  'NEVŞEHİR',
  'NİĞDE',
  'ORDU',
  'OSMANİYE',
  'RİZE',
  'SAKARYA',
  'SAMSUN',
  'SİİRT',
  'SİNOP',
  'SİVAS',
  'ŞANLIURFA',
  'ŞIRNAK',
  'TEKİRDAĞ',
  'TOKAT',
  'TRABZON',
  'TUNCELİ',
  'UŞAK',
  'VAN',
  'YALOVA',
  'YOZGAT',
  'ZONGULDAK'
];

List<String> burcListesi = [
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
Horoscope calculateHoroscope(DateTime birthDate) {
  if ((birthDate.month == 3 && birthDate.day >= 21) ||
      (birthDate.month == 4 && birthDate.day <= 19)) {
    return Horoscope.Koc;
  } else if ((birthDate.month == 4 && birthDate.day >= 20) ||
      (birthDate.month == 5 && birthDate.day <= 20)) {
    return Horoscope.Boga;
  } else if ((birthDate.month == 5 && birthDate.day >= 21) ||
      (birthDate.month == 6 && birthDate.day <= 20)) {
    return Horoscope.Ikizler;
  } else if ((birthDate.month == 6 && birthDate.day >= 21) ||
      (birthDate.month == 7 && birthDate.day <= 22)) {
    return Horoscope.Yengec;
  } else if ((birthDate.month == 7 && birthDate.day >= 23) ||
      (birthDate.month == 8 && birthDate.day <= 22)) {
    return Horoscope.Aslan;
  } else if ((birthDate.month == 8 && birthDate.day >= 23) ||
      (birthDate.month == 9 && birthDate.day <= 22)) {
    return Horoscope.Basak;
  } else if ((birthDate.month == 9 && birthDate.day >= 23) ||
      (birthDate.month == 10 && birthDate.day <= 22)) {
    return Horoscope.Terazi;
  } else if ((birthDate.month == 10 && birthDate.day >= 23) ||
      (birthDate.month == 11 && birthDate.day <= 21)) {
    return Horoscope.Akrep;
  } else if ((birthDate.month == 11 && birthDate.day >= 22) ||
      (birthDate.month == 12 && birthDate.day <= 21)) {
    return Horoscope.Yay;
  } else if ((birthDate.month == 12 && birthDate.day >= 22) ||
      (birthDate.month == 1 && birthDate.day <= 19)) {
    return Horoscope.Oglak;
  } else if ((birthDate.month == 1 && birthDate.day >= 20) ||
      (birthDate.month == 2 && birthDate.day <= 18)) {
    return Horoscope.Kova;
  } else {
    return Horoscope.Balik;
  }
}

String getHoroscopeName(Horoscope horoscope) {
  switch (horoscope) {
    case Horoscope.Koc:
      return 'Koç';
    case Horoscope.Boga:
      return 'Boğa';
    case Horoscope.Ikizler:
      return 'İkizler';
    case Horoscope.Yengec:
      return 'Yengeç';
    case Horoscope.Aslan:
      return 'Aslan';
    case Horoscope.Basak:
      return 'Başak';
    case Horoscope.Terazi:
      return 'Terazi';
    case Horoscope.Akrep:
      return 'Akrep';
    case Horoscope.Yay:
      return 'Yay';
    case Horoscope.Oglak:
      return 'Oğlak';
    case Horoscope.Kova:
      return 'Kova';
    case Horoscope.Balik:
      return 'Balık';
    default:
      return '';
  }
}

void main() {
  runApp(MaterialApp(
    home: BurcHesaplamaSayfasi(),
  ));
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

class BurcHesaplamaSayfasi extends StatefulWidget {
  @override
  _BurcHesaplamaSayfasiState createState() => _BurcHesaplamaSayfasiState();
}

Future<void> sendPostRequest() async {
  var url = Uri.parse('https://www.sabah.com.tr/yukselen-burc-hesaplama');

  var body = {
    'minute': dogumDakika,
    'gender': gender.toString(),
    'hour': dogumSaat,
    'day': gun,
    'month': ay,
    'year': yil,
    'place': place,
    'lat': lat,
    'lon': lon,
  };

  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // İstek başarıyla tamamlandı, burada yanıtı işleyebilirsiniz
    final data = json.decode(response.body);

    yukselenBurc = data['RisingSignName'].toString();
    alcalanBurc = data['DescendantName'].toString();
    horoscopeName = data['HoroscopeName'].toString();
  } else {
    // İstek başarısız oldu, hata durumunu işleyebilirsiniz
    print(
        'İstek gönderilirken bir hata oluştu. Status code: ${response.statusCode}');
  }
}

class _BurcHesaplamaSayfasiState extends State<BurcHesaplamaSayfasi> {
  String burcHesapla() {
    List<String> dateParts = dogumTarihi.split('.');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    DateTime birthDateObj = DateTime(year, month, day);

    Horoscope horoscope = calculateHoroscope(birthDateObj);
    return 'Burcunuz :${getHoroscopeName(horoscope)}';
  }

  Future<Map<String, dynamic>> yukselenHesapla() async {
    yukselenBurc = "";
    alcalanBurc = "";
    gender = cinsiyet == "Erkek" ? 1 : 0;
    await sendPostRequest();

    Map<String, dynamic> responseJson = {
      'yukselenBurc': yukselenBurc,
      'alcalanBurc': alcalanBurc,
      'horoscopeName': horoscopeName
    };
    return responseJson;
  }

  Widget burcHesaplamaSecenekleri() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          title: Text('Burç Hesaplama'),
          value: 'burcHesaplama',
          groupValue: seciliSecenek,
          onChanged: (value) {
            setState(() {
              seciliSecenek = value.toString();
              dogumTarihi = '';
              cinsiyet = '';
              dogumSaat = '';
              dogumDakika = '';
              dogumSehri = '';
              onunBurcuFinal = "";
              seninBurcunFinal = "";
            });
          },
        ),
        RadioListTile(
          title: Text('Yükselen Hesaplama'),
          value: 'yükselenHesaplama',
          groupValue: seciliSecenek,
          onChanged: (value) {
            setState(() {
              seciliSecenek = value.toString();
              dogumTarihi = '';
              cinsiyet = '';
              dogumSaat = '';
              dogumDakika = '';
              dogumSehri = '';
              onunBurcuFinal = "";
              seninBurcunFinal = "";
            });
          },
        ),
        RadioListTile(
          title: Text('Uyum Hesaplama'),
          value: 'uyumHesaplama',
          groupValue: seciliSecenek,
          onChanged: (value) {
            setState(() {
              seciliSecenek = value.toString();
              dogumTarihi = '';
              cinsiyet = '';
              dogumSaat = '';
              dogumDakika = '';
              dogumSehri = '';
              onunBurcuFinal = "";
              seninBurcunFinal = "";
            });
          },
        ),
      ],
    );
  }

  Widget dogumTarihiGirisAlani() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Doğum Tarihi (GG.AA.YYYY)',
      ),
      keyboardType: TextInputType.datetime,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        _DateInputFormatter(),
      ],
      onChanged: (value) {
        setState(() {
          dogumTarihi = value;
          List<String> tarihParcalari = dogumTarihi.split('.');
          if (tarihParcalari.length == 3) {
            gun = tarihParcalari[0];
            ay = tarihParcalari[1];
            yil = tarihParcalari[2];
          }
        });
      },
    );
  }

  Widget cinsiyetGirisAlani() {
    var cinsiyetSecimi;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Cinsiyet',
      ),
      value: cinsiyetSecimi,
      onChanged: (String? newValue) {
        setState(() {
          cinsiyetSecimi = newValue!;
          cinsiyet = newValue!;
        });
      },
      items: [
        DropdownMenuItem<String>(
          value: 'Erkek',
          child: Text('Erkek'),
        ),
        DropdownMenuItem<String>(
          value: 'Kadın',
          child: Text('Kadın'),
        ),
      ],
    );
  }

  Widget uyumHesaplaForm() {
    var onunBurcu;
    var seninBurcun;

    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Senin Burcun',
              ),
              value: seninBurcun,
              onChanged: (String? newValue) {
                setState(() {
                  seninBurcun = newValue;
                  seninBurcunFinal = newValue!;
                });
              },
              items: burcListesi.map((burc) {
                return DropdownMenuItem<String>(
                  value: burc,
                  child: Text(burc),
                );
              }).toList(),
            ),
          ),
          SingleChildScrollView(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Onun Burcu',
              ),
              value: onunBurcu,
              onChanged: (String? newValue) {
                setState(() {
                  onunBurcu = newValue;
                  onunBurcuFinal = newValue!;
                });
              },
              items: burcListesi.map((burc) {
                return DropdownMenuItem<String>(
                  value: burc,
                  child: Text(burc),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String turkceToIngilizce(String metin) {
    metin = metin
        .replaceAll("ü", "u")
        .replaceAll("Ü", "U")
        .replaceAll("ğ", "g")
        .replaceAll("Ğ", "G")
        .replaceAll("ş", "s")
        .replaceAll("Ş", "S")
        .replaceAll("ı", "i")
        .replaceAll("İ", "I")
        .replaceAll("ö", "o")
        .replaceAll("Ö", "O")
        .replaceAll("ç", "c")
        .replaceAll("Ç", "C");

    return metin;
  }

  Widget dogumSaatGirisAlani() {
    var saatSecimi;
    var dakikaSecimi;

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LimitRange(0, 23)
            ],
            decoration: InputDecoration(
              labelText: 'Saat',
            ),
            onChanged: (String newValue) {
              setState(() {
                saatSecimi = newValue;
                dogumSaat = newValue;
              });
            },
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LimitRange(0, 59)
            ],
            decoration: InputDecoration(
              labelText: 'Dakika',
            ),
            onChanged: (String newValue) {
              setState(() {
                dakikaSecimi = newValue;
                dogumDakika = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget burcHesaplaButonu() {
    return ElevatedButton(
      onPressed: () async {
        String sonuc = '';

        if (seciliSecenek == 'burcHesaplama') {
          if (dogumTarihi != "") {
            sonuc = burcHesapla();
          }
        } else if (seciliSecenek == 'yükselenHesaplama') {
          if (dogumTarihi != "" && dogumSaat != "" && dogumDakika != "") {
            Map<String, dynamic> response = await yukselenHesapla();
            sonuc = response != null
                ? "Burcunuz: " +
                    response['horoscopeName'] +
                    "\nYükselen Burcunuz: " +
                    response['yukselenBurc'] +
                    "\nAlçalan Burcunuz : " +
                    response['alcalanBurc']
                : '';
          }
        } else if (seciliSecenek == 'uyumHesaplama') {
          List<String> _bolParagraflara(String metin) {
            List<String> paragraflar = [];
            var cumleler = metin.split('.');

            for (int i = 0; i < cumleler.length - 1; i += 2) {
              var birinciCumle = cumleler[i].trim().replaceAll('&#8217;', "'");
              var ikinciCumle =
                  cumleler[i + 1].trim().replaceAll('&#8217;', "'");

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
                    ikinciCumle
                        .replaceAll('&#8220;', '“')
                        .replaceAll('&#8221;', '”');

                paragraflar.add(birlesikCumle);
              }
            }

            return paragraflar;
          }

          // URL'yi oluştur
          String url =
              'https://www.sabah.com.tr/astroloji/${turkceToIngilizce(onunBurcuFinal.toLowerCase())}-ve-${turkceToIngilizce(seninBurcunFinal.toLowerCase())}-burc-uyumu';

          // Veriyi çek ve işle
          http.Response response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
            var document = parser.parse(response.body);
            var yorumElement = document.getElementsByClassName('bYorum');

            if (yorumElement.isNotEmpty) {
              var yorumText = yorumElement[0]
                  .text
                  .trim(); // Başındaki ve sonundaki boşlukları temizle
              var paragraflar =
                  _bolParagraflara(yorumText); // Metni paragraflara böle

              sonuc = paragraflar.join('\n\n');
            } else {
              sonuc = 'Uyumluluk yorumu bulunamadı.';
            }
          } else {
            sonuc = 'Sayfa yüklenirken bir hata oluştu.';
          }
        }
        if (sonuc != "") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Text(sonuc),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Tamam'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Text('Hesapla'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burç Hesaplama'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BannerAdmob(),
                SizedBox(height: 20),
                burcHesaplamaSecenekleri(),
                if (seciliSecenek == 'burcHesaplama') ...[
                  SizedBox(height: 20),
                  dogumTarihiGirisAlani(),
                ],
                if (seciliSecenek == 'yükselenHesaplama') ...[
                  SizedBox(height: 20),
                  cinsiyetGirisAlani(),
                  SizedBox(height: 20),
                  dogumTarihiGirisAlani(),
                  SizedBox(height: 20),
                  dogumSaatGirisAlani(),
                  SizedBox(height: 20),
                  CitySelectionWidget(),
                ],
                if (seciliSecenek == 'uyumHesaplama') ...[
                  SizedBox(height: 20),
                  uyumHesaplaForm(),
                ],
                SizedBox(height: 20),
                burcHesaplaButonu(),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedText = newValue.text.replaceAll('.', '');

    if (formattedText.length > 2) {
      formattedText = formattedText.substring(0, 2) +
          '.' +
          formattedText.substring(2, formattedText.length);
    }
    if (formattedText.length > 5) {
      formattedText = formattedText.substring(0, 5) +
          '.' +
          formattedText.substring(5, formattedText.length);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class CitySelectionWidget extends StatefulWidget {
  @override
  _CitySelectionWidgetState createState() => _CitySelectionWidgetState();
}

String toLowerCaseTurkish(String input) {
  const turkishChars = 'ÇĞİÖŞÜçğıöşüI';
  const englishChars = 'çğiöşüçğıöşüı';

  for (int i = 0; i < turkishChars.length; i++) {
    input = input.replaceAll(turkishChars[i], englishChars[i]);
  }

  return input.toLowerCase();
}

class _CitySelectionWidgetState extends State<CitySelectionWidget> {
  String? selectedCity;
  double? latitude;
  double? longitude;

  Future<void> fetchCityCoordinates(String cityName) async {
    final lowercaseCityName = toLowerCaseTurkish(cityName);
    final url = Uri.parse(
        'https://www.sabah.com.tr/json/getcitywithlatitudeandlongitude?term=$lowercaseCityName');
    print(lowercaseCityName);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data != null && data.isNotEmpty) {
        final value = data[0]['value'].toString();
        lat = data[0]['lat'].toString();
        lon = data[0]['lon'].toString();

        setState(() {
          latitude = double.tryParse(lat);
          longitude = double.tryParse(lon);
          place = value;
        });
        print('Value: $value, Latitude: $latitude, Longitude: $longitude');
      } else {
        throw Exception('No city coordinates found');
      }
    } else {
      throw Exception('Failed to fetch city coordinates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Doğum Şehri',
          ),
          value: selectedCity,
          onChanged: (String? newValue) {
            setState(() {
              selectedCity = newValue;
              latitude = null;
              longitude = null;
              fetchCityCoordinates(newValue!);
            });
          },
          items: sehirlereListesi.map((sehir) {
            return DropdownMenuItem<String>(
              value: sehir,
              child: Text(sehir),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class LimitRange extends TextInputFormatter {
  LimitRange(
    this.minRange,
    this.maxRange,
  ) : assert(
          minRange < maxRange,
        );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return TextEditingValue.empty;
    }

    var value = int.tryParse(newValue.text);
    if (value == null) {
      // Geçersiz değer
      return oldValue;
    }

    if (value < minRange) {
      return TextEditingValue(text: minRange.toString());
    } else if (value > maxRange) {
      return TextEditingValue(text: maxRange.toString());
    }

    return newValue;
  }
}
