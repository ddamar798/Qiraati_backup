import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progres Belajar")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.insights_rounded, size: 48),
            SizedBox(height: 12),
            Text(
              "Ringkasan Progres & Statistik",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
