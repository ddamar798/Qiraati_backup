import 'package:flutter/material.dart';

class HurufScreen extends StatelessWidget {
  const HurufScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Huruf Hijaiyah")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.record_voice_over_rounded, size: 48),
            SizedBox(height: 12),
            Text(
              "Halaman Huruf Hijaiyah (Audio Offline)",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
