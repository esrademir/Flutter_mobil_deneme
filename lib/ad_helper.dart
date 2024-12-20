//HER DEPLOY ÖNCESİNDE REKLAM ID GÜNCELLE
//OLMASI GEREKEN ID : ca-app-pub-3273501846191708/5954941479
//TEST IDSI : ca-app-pub-3940256099942544/6300978111

import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3273501846191708/5954941479';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
