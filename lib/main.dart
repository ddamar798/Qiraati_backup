import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// screens
import 'screens/home_screen.dart';
import 'screens/iqro_screen.dart';
import 'screens/hijaiyah_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/stats_screen.dart';

// services
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.init();
  runApp(const QiraatiApp());
}

class QiraatiApp extends StatelessWidget {
  const QiraatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: const Color(0xFFF7FBF7),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 0.5,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qiraati',
      theme: baseTheme,
      home: const RootScreen(),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const IqroScreen(jilid: 1, pdfAssetPath: 'assets/pdf/iqro_jilid1.pdf'),
    const HijaiyahScreen(),
    const QuizScreen(),
    const StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Iqro'),
          BottomNavigationBarItem(icon: Icon(Icons.text_fields), label: 'Hijaiyah'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Statistik'),
        ],
      ),
    );
  }
}
