import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoading = true; // Yüklenme durumunu takip eden bir değişken
  bool notificationPermission = false;
  String selectedHoroscope = '';

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationPermission', notificationPermission);
    await prefs.setString('selectedHoroscope', selectedHoroscope);
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationPermission = prefs.getBool('notificationPermission') ?? false;
      selectedHoroscope = prefs.getString('selectedHoroscope') ?? '';
      _isLoading = false; // Yüklenme işlemi tamamlandı
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  final List<String> horoscopeList = [
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

  List<Widget> _buildHoroscopeListTiles() {
    return horoscopeList
        .map(
          (horoscope) => ListTile(
            title: Text(horoscope),
            onTap: () {
              Navigator.pop(context, horoscope);
            },
          ),
        )
        .toList();
  }

  Future<void> _showHoroscopeSelectionDialog() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Burç Seç'),
          content: SingleChildScrollView(
            child: Column(
              children: _buildHoroscopeListTiles(),
            ),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedHoroscope = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Yüklenme animasyonu
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bildirim İzni',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Bildirimlere İzin Ver'),
                    value: notificationPermission,
                    onChanged: (value) {
                      setState(() {
                        notificationPermission = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Seçilen Burç',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListTile(
                    title: const Text('Burç Seç'),
                    subtitle: Text(selectedHoroscope.isNotEmpty
                        ? 'Seçilen Burç: $selectedHoroscope'
                        : 'Bir Burç Seçilmedi'),
                    enabled: notificationPermission,
                    onTap: () {
                      if (notificationPermission) {
                        _showHoroscopeSelectionDialog();
                      }
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _saveSettings();
          Navigator.pop(context);
        },
        label: const Text('Kaydet'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
