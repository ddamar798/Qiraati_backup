import 'package:flutter/material.dart';
import '../services/stats_service.dart';
import '../services/progress_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});
  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _xp = 0;
  int _letters = 0;
  Map<int,int> _progress = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _xp = await StatsService.getXp();
    _letters = await StatsService.getLetters();
    for (int j=1;j<=6;j++) {
      _progress[j] = await ProgressService.getPage(j);
    }
    if (!mounted) return;
    setState((){});
  }

  String badgeName(int xp) {
    if (xp>=300) return 'Mumtaz';
    if (xp>=200) return 'Rajin';
    if (xp>=100) return 'Pemula Hebat';
    return 'Pemula';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Statistik')), body: RefreshIndicator(
      onRefresh: _load,
      child: ListView(padding: const EdgeInsets.all(12), children: [
        Card(child: ListTile(leading: const Icon(Icons.star, color: Colors.amber), title: const Text('Total XP'), trailing: Text('$_xp'))),
        Card(child: ListTile(leading: const Icon(Icons.hearing, color: Colors.green), title: const Text('Huruf didengarkan'), trailing: Text('$_letters'))),
        const SizedBox(height:12),
        const Text('Progres Iqro per Jilid', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height:8),
        ...List.generate(6,(i){
          final jilid=i+1;
          final page=_progress[jilid] ?? 1;
          return Card(child: ListTile(leading: CircleAvatar(backgroundColor: Colors.green.shade700, child: Text('$jilid', style: const TextStyle(color: Colors.white))), title: Text('Iqro Jilid $jilid'), subtitle: Text('Halaman terakhir: $page'), trailing: const Icon(Icons.menu_book, color: Colors.green)));
        }),
      ]),
    ));
  }
}
