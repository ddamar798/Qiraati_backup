import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/stats_service.dart';

class HijaiyahScreen extends StatelessWidget {
  const HijaiyahScreen({super.key});

  static const List<Map<String, String>> _huruf = [
    {"teks": "ا", "audio": "audio/alif.mp3"},
    {"teks": "ب", "audio": "audio/ba.mp3"},
    {"teks": "ت", "audio": "audio/taa.mp3"},
    {"teks": "ث", "audio": "audio/tsa.mp3"},
    {"teks": "ج", "audio": "audio/jim.mp3"},
    {"teks": "ح", "audio": "audio/ha.mp3"},
    {"teks": "خ", "audio": "audio/khaa.mp3"},
    {"teks": "د", "audio": "audio/dal.mp3"},
    {"teks": "ذ", "audio": "audio/dhal.mp3"},
    {"teks": "ر", "audio": "audio/raa.mp3"},
    {"teks": "ز", "audio": "audio/jaa.mp3"},
    {"teks": "س", "audio": "audio/seen.mp3"},
    {"teks": "ش", "audio": "audio/sheen.mp3"},
    {"teks": "ص", "audio": "audio/saad.mp3"},
    {"teks": "ض", "audio": "audio/dhaad.mp3"},
    {"teks": "ط", "audio": "audio/toa.mp3"},
    {"teks": "ظ", "audio": "audio/dhaa.mp3"},
    {"teks": "ع", "audio": "audio/ain.mp3"},
    {"teks": "غ", "audio": "audio/ghain.mp3"},
    {"teks": "ف", "audio": "audio/faa.mp3"},
    {"teks": "ق", "audio": "audio/qaaf.mp3"},
    {"teks": "ك", "audio": "audio/kaaf.mp3"},
    {"teks": "ل", "audio": "audio/laam.mp3"},
    {"teks": "م", "audio": "audio/meem.mp3"},
    {"teks": "ن", "audio": "audio/noon.mp3"},
    {"teks": "و", "audio": "audio/waw.mp3"},
    {"teks": "ه", "audio": "audio/hamza.mp3"},
    {"teks": "ي", "audio": "audio/yaa.mp3"},
  ];

  @override
  Widget build(BuildContext context) {
    final audio = AudioService.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('"Denggarkan Dan Tirukan 🔊"')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _huruf.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (_, i) {
          final h = _huruf[i];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade50, foregroundColor: Colors.green.shade900, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () async {
              await audio.playAsset(h['audio']!); // e.g. audio/alif.mp3
              await StatsService.incLetter();
            },
            child: Text(h['teks']!, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          );
        },
      ),
    );
  }
}
