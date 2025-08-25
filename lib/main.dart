import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

// Import screens
import 'screens/iqro_screen.dart';
import 'screens/hijaiyah_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/quiz_screen.dart';
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
        primaryColor: const Color(0xFF388E3C),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.nunitoTextTheme().copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'LpmqisepMisbah', // Font Islamic
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
          bodyMedium: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF81C784),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'LpmqisepMisbah',
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF81C784),
          selectedItemColor: const Color(0xFF1B5E20),
          unselectedItemColor: Colors.white70,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFFE8F5E9),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const IqroScreen(
      jilid: 1,
      pdfAssetPath: 'assets/pdf/iqro_jilid1.pdf',
    ),
    const HijaiyahScreen(),
    const StatsScreen(),
    const QuizScreen(),
    const ReminderScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.book),
            label: 'Iqro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.text),
            label: 'Hijaiyah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.activity),
            label: 'Statistik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.document_text),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.clock),
            label: 'Pengingat',
          ),
        ],
      ),
    );
  }
}
