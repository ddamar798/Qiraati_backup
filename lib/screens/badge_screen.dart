import 'package:flutter/material.dart';
import '../services/stats_service.dart';

class BadgeScreen extends StatefulWidget {
  const BadgeScreen({super.key});

  @override
  State<BadgeScreen> createState() => _BadgeScreenState();
}

class _BadgeScreenState extends State<BadgeScreen> {
  int _xp = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _xp = await StatsService.getXp();
    if (mounted) setState(() {});
  }

  String _badgeName(int xp) {
    if (xp >= 300) return 'Mumtaz';
    if (xp >= 200) return 'Rajin';
    if (xp >= 100) return 'Pemula Hebat';
    return 'Pemula';
  }

  String _badgeDesc(String name) {
    switch (name) {
      case 'Mumtaz':
        return 'Level tertinggi! Terus pertahankan semangatmu 🎉';
      case 'Rajin':
        return 'Konsisten dan cepat berkembang 👏';
      case 'Pemula Hebat':
        return 'Awal yang bagus, lanjutkan! 🌟';
      default:
        return 'Mulai kumpulkan XP dari belajar dan quiz 💪';
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = _badgeName(_xp);
    final desc = _badgeDesc(name);

    return Scaffold(
      appBar: AppBar(title: const Text('Badge & Reward')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.emoji_events, size: 72, color: Colors.amber),
                const SizedBox(height: 12),
                Text(name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('XP: $_xp'),
                const SizedBox(height: 12),
                Text(desc, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
