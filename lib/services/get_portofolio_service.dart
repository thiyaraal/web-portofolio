// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;

import 'package:web_portofolio/models/portofolio_models.dart';

// Fungsi untuk membaca file JSON
Future<MyPortofolioData> loadPortofolioData() async {
  // Membaca file JSON dari assets
  final jsonString = await rootBundle.rootBundle.loadString('assets/json/portofolio_data.json');

  // Mengonversi JSON string menjadi MyPortofolioData
  return myPortofolioDataFromMap(jsonString);
}
