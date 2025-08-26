// lib/screens/asmaul_husna_screen.dart
import 'package:flutter/material.dart';

class AsmaulHusnaScreen extends StatelessWidget {
  const AsmaulHusnaScreen({super.key});

  final List<Map<String, String>> _asmaulHusna = const [
    {"arab": "الرَّحْمَنُ", "arti": "Yang Maha Pengasih"},
    {"arab": "الرَّحِيمُ", "arti": "Yang Maha Penyayang"},
    {"arab": "الْمَلِكُ", "arti": "Yang Maha Merajai"},
    {"arab": "الْقُدُّوسُ", "arti": "Yang Maha Suci"},
    {"arab": "السَّلاَمُ", "arti": "Yang Maha Pemberi Kedamaian"},
    {"arab": "الْمُؤْمِنُ", "arti": "Yang Maha Memberi Keamanan"},
    {"arab": "الْمُهَيْمِنُ", "arti": "Yang Maha Mengawasi"},
    {"arab": "الْعَزِيزُ", "arti": "Yang Maha Perkasa"},
    {"arab": "الْجَبَّارُ", "arti": "Yang Maha Kuasa"},
    {"arab": "الْمُتَكَبِّرُ", "arti": "Yang Maha Megah"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asmaul Husna")),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.3,
        ),
        itemCount: _asmaulHusna.length,
        itemBuilder: (_, i) {
          final item = _asmaulHusna[i];
          return InkWell(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item['arab']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 6),
                    Text(item['arti']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
