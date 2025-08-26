import 'package:flutter/material.dart';
import 'doa_screen.dart';
import 'juz30_screen.dart';
import 'asmaul_husna_screen.dart';
import 'alarm_sholat_screen.dart';
import 'iqro_screen.dart';
import 'hijaiyah_screen.dart';
import 'quiz_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _card(BuildContext ctx, IconData icon, String title, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.shade100)),
        child: Padding(padding: const EdgeInsets.all(14), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 36, color: Colors.green.shade700), const SizedBox(height:8), Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w600))])),
      ),
    );
  }

  Widget _link(BuildContext ctx, IconData icon, String title, Widget page) {
    return Card(child: ListTile(leading: Icon(icon, color: Colors.green.shade700), title: Text(title), trailing: const Icon(Icons.chevron_right), onTap: ()=>Navigator.push(ctx, MaterialPageRoute(builder: (_) => page))));
  }

  @override
  Widget build(BuildContext context) {
    final grid = [
      (Icons.menu_book, 'Doa Sehari-hari', const DoaScreen()),
      (Icons.menu_book_rounded, 'Surah Pendek (Juz 30)', const Juz30Screen()),
      (Icons.star, 'Asmaul Husna', const AsmaulHusnaScreen()),
      (Icons.alarm, 'Alarm Sholat', const AlarmSholatScreen()),
    ];
    final quick = [
      (Icons.menu_book, 'Iqro', const IqroScreen(jilid: 1, pdfAssetPath: 'assets/pdf/iqro_jilid1.pdf')),
      (Icons.text_fields, 'Huruf Hijaiyah', const HijaiyahScreen()),
      (Icons.quiz, 'Quiz', const QuizScreen()),
      (Icons.bar_chart, 'Statistik', const StatsScreen()),
    ];

    return Scaffold(appBar: AppBar(title: const Text('Home')), body: CustomScrollView(slivers: [
      SliverPadding(padding: const EdgeInsets.fromLTRB(12,12,12,8), sliver: SliverGrid(delegate: SliverChildBuilderDelegate((ctx,i)=>_card(ctx, grid[i].$1, grid[i].$2, grid[i].$3), childCount: grid.length), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.4))),
      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(12), child: Text('Akses Cepat', style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.w700)))),
      SliverList(delegate: SliverChildBuilderDelegate((ctx,i)=>Padding(padding: const EdgeInsets.symmetric(horizontal:8), child: _link(ctx, quick[i].$1, quick[i].$2, quick[i].$3)), childCount: quick.length)),
      const SliverToBoxAdapter(child: SizedBox(height: 16))
    ]));
  }
}
