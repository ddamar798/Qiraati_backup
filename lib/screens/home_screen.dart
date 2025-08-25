import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'iqro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? lastJilid;
  int? lastPage;

  @override
  void initState() {
    super.initState();
    _loadLastProgress();
  }

  /// Ambil progres terakhir dari SharedPreferences
  Future<void> _loadLastProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastJilid = prefs.getInt('last_jilid');
      lastPage = prefs.getInt('last_page');
    });
  }

  /// Navigasi ke layar Iqro dengan data progres terakhir
  void _lanjutkanBelajar() {
    if (lastJilid != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => IqroScreen(
            pdfAssetPath: 'assets/iqro/iqro_$lastJilid.pdf',
            jilid: lastJilid!,
          ),
        ),
      );
    }
  }

  /// Navigasi ke jilid tertentu (baru belajar)
  void _bukaJilid(int jilid) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IqroScreen(
          pdfAssetPath: 'assets/iqro/iqro_$jilid.pdf',
          jilid: jilid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qiraati - Belajar Iqro"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// 🔥 Tombol Lanjutkan Belajar
            if (lastJilid != null && lastPage != null)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.green.shade100,
                child: ListTile(
                  leading: const Icon(Icons.bookmark, color: Colors.green, size: 32),
                  title: Text("Lanjutkan Iqro Jilid $lastJilid"),
                  subtitle: Text("Halaman terakhir: $lastPage"),
                  trailing: ElevatedButton(
                    onPressed: _lanjutkanBelajar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Lanjutkan"),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            /// 🔥 Daftar jilid
            Expanded(
              child: GridView.builder(
                itemCount: 6, // Jilid 1–6
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final jilid = index + 1;
                  return GestureDetector(
                    onTap: () => _bukaJilid(jilid),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green.shade300, Colors.green.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            "Iqro Jilid $jilid",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
