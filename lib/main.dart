import 'package:flutter/material.dart';

// Screens
import 'screens/iqro_screen.dart';
import 'screens/hijaiyah_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/reminder_screen.dart';

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
        scaffoldBackgroundColor: Colors.green[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'LpmqisepMisbah', // font Islamik
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: const CardTheme(
          elevation: 4,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            fontFamily: 'LpmqisepMisbah',
          ),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // ✅ Lengkapkan dengan parameter yg benar
  final List<Widget> _screens = [
    IqroScreen(
      jilid: 1,
      pdfAssetPath: 'assets/pdf/iqro1.pdf',
    ),
    const HijaiyahScreen(),
    const QuizScreen(),
    const StatisticsScreen(),
    const ReminderScreen(), // sudah dibuat di screens/reminder_screen.dart
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Iqro",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: "Hijaiyah",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: "Quiz",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Statistik",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: "Pengingat",
          ),
        ],
      ),
    );
  }
}
