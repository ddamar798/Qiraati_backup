import 'package:flutter/material.dart';

// === Screens yang sudah ada di projectmu ===
import 'package:qiraati/screens/iqro_screen.dart';
import 'package:qiraati/screens/hijaiyah_screen.dart';
import 'package:qiraati/screens/quiz_screen.dart';
import 'package:qiraati/screens/asmaul_husna_screen.dart';
import 'package:qiraati/screens/juz30_screen.dart';
import 'package:qiraati/screens/doa_screen.dart';
import 'package:qiraati/screens/alarm_sholat_screen.dart';
import 'package:qiraati/screens/stats_screen.dart';
import 'package:qiraati/screens/about_screen.dart';

void main() {
  runApp(const QiraatiApp());
}

class QiraatiApp extends StatelessWidget {
  const QiraatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiraati',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF9F5F7),
        useMaterial3: false,
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  String _titleFor(int i) {
    switch (i) {
      case 0:
        return '𝐐𝐢𝐫𝐚𝐚𝐭𝐢';
      case 1:
        return 'Iqro';
      case 2:
        return 'Huruf Hijaiyah';
      case 3:
        return 'Alarm';
      case 4:
        return 'Statistik';
      default:
        return 'Qiraati';
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const _HomeTab(),
      const IqroScreen(jilid: 1, pdfAssetPath: 'assets/pdf/iqro_jilid1.pdf'),
      const HijaiyahScreen(),
      const AlarmSholatScreen(),
      const StatsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text(_titleFor(_currentIndex)),
        actions: [
            // Tampilkan titik tiga hanya di Home
            if (_currentIndex == 0)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (v) {
                  if (v == 'about') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()),
                    );
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem<String>(
                    value: 'about',
                    child: Text('About'),
                  ),
                ],
              ),
        ],
      ),

      body: pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Iqro'),
          BottomNavigationBarItem(icon: Icon(Icons.record_voice_over), label: 'Huruf Hijaiyah'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Alarm'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistik'),
        ],
      ),
    );
  }
}

/// ================= HOME TAB (LAYOUT TERKINI) =================
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Home'),
          const SizedBox(height: 12),

          // ======= GRID MENU UTAMA (2 kolom) =======
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _HomeCard(
                icon: Icons.record_voice_over,
                title: 'Hijaiyah',
                subtitle: 'Belajar huruf & suara',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HijaiyahScreen()),
                  );
                },
              ),
              _HomeCard(
                icon: Icons.menu_book,
                title: 'Iqro',
                subtitle: 'Belajar Iqro (PDF)',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const IqroScreen(
                        jilid: 1,
                        pdfAssetPath: 'assets/pdf/iqro_jilid1.pdf',
                      ),
                    ),
                  );
                },
              ),
              _HomeCard(
                icon: Icons.quiz,
                title: 'Quiz',
                subtitle: 'Uji pemahaman',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizScreen()),
                  );
                },
              ),
              _HomeCard(
                icon: Icons.star,
                title: 'Asmaul Husna',
                subtitle: '99 nama Allah',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AsmaulHusnaScreen()),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 24),
          const _SectionTitle('Tambah Hafalanmu'),
          const SizedBox(height: 8),

          // ======= LIST MENU TAMBAHAN DI BAWAH =======
          _quickItem(
            context,
            leading: Icons.menu_book_rounded,
            title: 'Surah Pendek (Juz 30)',
            subtitle: 'Teks Arab + latin',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Juz30Screen()),
              );
            },
          ),
          _quickItem(
            context,
            leading: Icons.menu_book,
            title: 'Doa Sehari-hari',
            subtitle: 'Doa aktivitas harian',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DoaScreen()),
              );
            },
          ),
          _quickItem
          (
            context,
            leading: Icons.alarm,
            title: 'Alarm Sholat',
            subtitle: 'Pengingat waktu sholat',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AlarmSholatScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _quickItem(
    BuildContext context, {
    required IconData leading,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(leading, color: Colors.green),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap, // <-- clickable
      ),
    );
  }
}

/// Kartu menu persegi panjang (2 kolom)
class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // <-- clickable
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.shade100),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.green.shade700),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.green.shade800,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.green.shade700),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }
}
