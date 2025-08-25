import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../services/stats_service.dart';

class HijaiyahScreen extends StatelessWidget {
  const HijaiyahScreen({super.key});

  // Sesuaikan file audio dengan aset yang kamu punya.
  static const _huruf = [
    {"teks": "ا", "audio": "alif.mp3"},
    {"teks": "ب", "audio": "ba.mp3"},
    {"teks": "ت", "audio": "taa.mp3"},
    {"teks": "ث", "audio": "tsa.mp3"},
    {"teks": "ج", "audio": "jim.mp3"},
    {"teks": "ح", "audio": "ha.mp3"},
    {"teks": "خ", "audio": "khaa.mp3"},
    {"teks": "د", "audio": "dal.mp3"},
    {"teks": "ذ", "audio": "dhal.mp3"},
    {"teks": "ر", "audio": "raa.mp3"},
    {"teks": "ز", "audio": "zaa.mp3"},
    {"teks": "س", "audio": "seen.mp3"},
    {"teks": "ش", "audio": "sheen.mp3"},
    {"teks": "ص", "audio": "saad.mp3"},
    {"teks": "ض", "audio": "dhaad.mp3"},
    {"teks": "ط", "audio": "taa.mp3"},   // mengikuti penamaan file yang kamu kirim
    {"teks": "ظ", "audio": "dhaa.mp3"},
    {"teks": "ع", "audio": "ain.mp3"},
    {"teks": "غ", "audio": "ghain.mp3"},
    {"teks": "ف", "audio": "faa.mp3"},
    {"teks": "ق", "audio": "qaaf.mp3"},
    {"teks": "ك", "audio": "kaaf.mp3"},
    {"teks": "ل", "audio": "laam.mp3"},
    {"teks": "م", "audio": "meem.mp3"},
    {"teks": "ن", "audio": "noon.mp3"},
    {"teks": "و", "audio": "waw.mp3"},
    {"teks": "ه", "audio": "hamza.mp3"}, // sesuai list yang kamu kirim
    {"teks": "ي", "audio": "yaa.mp3"},
  ];

  @override
  Widget build(BuildContext context) {
    final audio = AudioService.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Huruf Hijaiyah')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _huruf.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (_, i) {
          final h = _huruf[i];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade50,
              foregroundColor: Colors.green.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0.5,
            ),
            onPressed: () async {
              await audio.playAsset(h['audio']!);
              await StatsService.incLetters();
            },
            child: Text(
              h['teks']!,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
