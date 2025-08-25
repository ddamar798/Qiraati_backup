import 'package:flutter/material.dart';
import 'belajar_screen.dart';

class BelajarMenuScreen extends StatelessWidget {
  const BelajarMenuScreen({super.key});

  void _openJilid(BuildContext context, int jilid) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BelajarScreen(jilid: jilid)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Iqro"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final jilid = index + 1;
            return GestureDetector(
              onTap: () => _openJilid(context, jilid),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "Iqro Jilid $jilid",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}