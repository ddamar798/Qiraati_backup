import 'package:flutter/material.dart';

class SurahDetailScreen extends StatelessWidget {
  final Map<String, dynamic> surah;

  const SurahDetailScreen({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final verses = (surah['verse'] as Map<String, dynamic>).entries.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(surah['name']),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: verses.length,
        itemBuilder: (context, i) {
          final v = verses[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      v.value,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Ayat ${i}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
