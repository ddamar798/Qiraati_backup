import 'package:flutter/material.dart';
import 'screens/iqro_screen.dart';
import 'screens/hijaiyah_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/badge_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QiraatiApp());
}

class QiraatiApp extends StatelessWidget {
  const QiraatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qiraati',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const _MainNav(),
    );
  }
}

class _MainNav extends StatefulWidget {
  const _MainNav({super.key});

  @override
  State<_MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<_MainNav> {
  int _index = 0;

  // Gunakan IndexedStack agar state tiap screen tidak reset saat pindah tab.
  late final List<Widget> _screens = [
    const IqroScreen(
      jilid: 1,
      pdfAssetPath: 'assets/pdf/iqro_jilid1.pdf',
    ),
    const HijaiyahScreen(),
    const QuizScreen(),
    const StatsScreen(),
    const BadgeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Iqro'),
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Hijaiyah'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistik'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Badge'),
        ],
      ),
    );
  }
}
