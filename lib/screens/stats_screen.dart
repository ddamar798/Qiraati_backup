import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/progress_service.dart';
import '../services/stats_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final Map<int, int> _pages = {}; // jilid -> halaman
  int _xp = 0;
  int _letters = 0;
  int _quizTaken = 0;
  double _quizAvg = 0;
  int _lastScore = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    for (int j = 1; j <= 6; j++) {
      _pages[j] = await ProgressService.getPage(j);
    }
    _xp = await StatsService.getXp();
    _letters = await StatsService.getTotalLetters();
    final q = await StatsService.getQuizStats();
    _quizTaken = q['taken']!;
    _lastScore = q['last']!;
    final totalScore = q['total']!;
    _quizAvg = _quizTaken == 0 ? 0 : totalScore / _quizTaken;

    if (mounted) setState(() {});
  }

  Future<void> _resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua progres direset')),
      );
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Belajar')),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.star, color: Colors.orange),
                title: const Text('Total XP'),
                trailing: Text('$_xp'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.hearing, color: Colors.green),
                title: const Text('Huruf didengarkan'),
                trailing: Text('$_letters'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.quiz, color: Colors.blue),
                title: const Text('Quiz dikerjakan'),
                subtitle: Text('Rata-rata skor: ${_quizAvg.toStringAsFixed(1)}'),
                trailing: Text('Terakhir: $_lastScore'),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Progres Iqro per Jilid',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...List.generate(6, (i) {
              final jilid = i + 1;
              final page = _pages[jilid] ?? 1;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade700,
                    child: Text('$jilid', style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text('Iqro Jilid $jilid'),
                  subtitle: Text('Halaman terakhir: $page'),
                  trailing: const Icon(Icons.menu_book, color: Colors.green),
                ),
              );
            }),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _resetAll,
              icon: const Icon(Icons.delete_forever),
              label: const Text('Reset Semua Progres'),
            ),
          ],
        ),
      ),
    );
  }
}
