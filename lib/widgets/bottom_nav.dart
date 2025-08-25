import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Iqro"),
        BottomNavigationBarItem(icon: Icon(Icons.volume_up), label: "Hijaiyah"),
        BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "Quiz"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Statistik"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
      ],
    );
  }
}
