import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';


// ======================= MAIN APP =======================
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
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainPage(),
    );
  }
}

// ======================= MAIN PAGE =======================
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    IqroPage(),
    HijaiyahPage(),
    StatistikPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Iqro"),
          BottomNavigationBarItem(icon: Icon(Icons.record_voice_over), label: "Hijaiyah"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Statistik"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Pengaturan"),
        ],
      ),
    );
  }
}

// ======================= IQRO VIEWER (dummy nav + progres) =======================
class IqroPage extends StatefulWidget {
  const IqroPage({super.key});

  @override
  State<IqroPage> createState() => _IqroPageState();
}

class _IqroPageState extends State<IqroPage> {
  int jilid = 1;
  int halaman = 1;
  static const int totalHalamanPerJilid = 120; // sesuaikan bila perlu

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jilid = prefs.getInt('jilid') ?? 1;
      halaman = prefs.getInt('halaman') ?? 1;
    });
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('jilid', jilid);
    await prefs.setInt('halaman', halaman);
  }

  void _nextPage() {
    setState(() {
      halaman++;
      if (halaman > totalHalamanPerJilid) {
        halaman = 1;
        if (jilid < 6) jilid++;
      }
    });
    _saveProgress();
  }

  void _prevPage() {
    setState(() {
      halaman--;
      if (halaman < 1) {
        if (jilid > 1) {
          jilid--;
          halaman = totalHalamanPerJilid;
        } else {
          halaman = 1;
        }
      }
    });
    _saveProgress();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (halaman / totalHalamanPerJilid).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text("Iqro")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Jilid $jilid — Halaman $halaman",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.green.shade100,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _prevPage,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text("Sebelumnya"),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _nextPage,
                  icon: const Icon(Icons.chevron_right),
                  label: const Text("Berikutnya"),
                ),
              ],
            ),
            const Spacer(),
            // Tombol Lanjutkan Belajar (simulasi lompat ke progres tersimpan)
            ElevatedButton.icon(
              onPressed: _loadProgress,
              icon: const Icon(Icons.bookmark_added),
              label: const Text("Lanjutkan Belajar"),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================= HIJAIYAH =======================

class HijaiyahPage extends StatelessWidget {
  const HijaiyahPage({super.key});

  // Mapping huruf ke nama file audio
  final List<Map<String, String>> huruf = const [
    {"teks": "ا", "audio": "alif.mp3"},
    {"teks": "ب", "audio": "ba.mp3"},
    {"teks": "ت", "audio": "taa.mp3"},
    {"teks": "ث", "audio": "tsa.mp3"},
    {"teks": "ج", "audio": "jim.mp3"},
    {"teks": "ح", "audio": "ha.mp3"},
    {"teks": "خ", "audio": "khaa.mp3"},
    {"teks": "د", "audio": "dal.mp3"},
    {"teks": "ذ", "audio": "dhal.mp3"},
    {"teks": "ر", "audio": "raa.mp3"},
    {"teks": "ز", "audio": "zaa.mp3"},
    {"teks": "س", "audio": "seen.mp3"},
    {"teks": "ش", "audio": "sheen.mp3"},
    {"teks": "ص", "audio": "saad.mp3"},
    {"teks": "ض", "audio": "dhaad.mp3"},
    {"teks": "ط", "audio": "taa.mp3"},
    {"teks": "ظ", "audio": "dhaa.mp3"},
    {"teks": "ع", "audio": "ain.mp3"},
    {"teks": "غ", "audio": "ghain.mp3"},
    {"teks": "ف", "audio": "faa.mp3"},
    {"teks": "ق", "audio": "qaaf.mp3"},
    {"teks": "ك", "audio": "kaaf.mp3"},
    {"teks": "ل", "audio": "laam.mp3"},
    {"teks": "م", "audio": "meem.mp3"},
    {"teks": "ن", "audio": "noon.mp3"},
    {"teks": "و", "audio": "waw.mp3"},
    {"teks": "ه", "audio": "hamza.mp3"},
    {"teks": "ي", "audio": "yaa.mp3"},
  ];

  @override
  Widget build(BuildContext context) {
    final AudioPlayer player = AudioPlayer();

    return Scaffold(
      appBar: AppBar(title: const Text("Huruf Hijaiyah")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: huruf.length,
        itemBuilder: (context, index) {
          final item = huruf[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade50,
              foregroundColor: Colors.green.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0.5,
            ),
            onPressed: () async {
              // Play audio dari assets
              await player.play(
                AssetSource("audio/${item['audio']}"),
              );

              // Tampilkan notifikasi kecil
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Memutar: ${item['teks']}")),
              );
            },
            child: Text(
              item['teks']!,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}


// ======================= STATISTIK =======================
class StatistikPage extends StatefulWidget {
  const StatistikPage({super.key});

  @override
  State<StatistikPage> createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  int xp = 0;
  int halaman = 1;
  static const int totalHalaman = 120;

  @override
  void initState() {
    super.initState();
    _loadXP();
  }

  Future<void> _loadXP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      xp = prefs.getInt('xp') ?? 0;
      halaman = prefs.getInt('halaman') ?? 1;
    });
  }

  String getBadge() {
    if (xp < 50) return "Pemula 🌱";
    if (xp < 100) return "Pembelajar 📘";
    if (xp < 200) return "Rajin ✨";
    return "Master 📚";
  }

  @override
  Widget build(BuildContext context) {
    final progress = (halaman / totalHalaman).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text("Statistik Belajar")),
      body: RefreshIndicator(
        onRefresh: _loadXP,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.star, color: Colors.amber),
                title: const Text("Total XP"),
                trailing: Text("$xp"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.emoji_events, color: Colors.orange),
                title: const Text("Badge Saat Ini"),
                subtitle: Text(getBadge()),
              ),
            ),
            const SizedBox(height: 12),
            const Text("Progres Iqro", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                backgroundColor: Colors.green.shade100,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            const SizedBox(height: 8),
            Text("Halaman $halaman dari $totalHalaman"),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const QuizPage()));
              },
              icon: const Icon(Icons.quiz),
              label: const Text("Mulai Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================= QUIZ PAGE =======================
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int score = 0;
  int currentQuestion = 0;

  final List<Map<String, dynamic>> questions = const [
    {
      "question": "Huruf pertama Hijaiyah?",
      "options": ["ا", "ب", "ت", "ث"],
      "answer": "ا"
    },
    {
      "question": "Setelah huruf ب adalah?",
      "options": ["ت", "ث", "ج", "ا"],
      "answer": "ت"
    }
  ];

  Future<void> _answerQuestion(String selected) async {
    if (selected == questions[currentQuestion]["answer"]) {
      score += 10;
      final prefs = await SharedPreferences.getInstance();
      final xpNow = prefs.getInt('xp') ?? 0;
      await prefs.setInt('xp', xpNow + 10);
    }
    if (!mounted) return;
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Selesai!"),
        content: Text("Skor kamu: $score"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentQuestion];
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Hijaiyah")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(q["question"] as String, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            ...(q["options"] as List<String>).map((opt) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(opt),
                  child: Text(opt),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ======================= SETTINGS PAGE =======================
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _resetProgress(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Progres direset!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _resetProgress(context),
              child: const Text("Reset Progres"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // placeholder notifikasi manual (akan kita ganti real local notification)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reminder belajar aktif (simulasi)!")),
                );
              },
              child: const Text("Aktifkan Pengingat Belajar"),
            ),
          ],
        ),
      ),
    );
  }
}
