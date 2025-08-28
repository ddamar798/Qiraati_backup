import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("About"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Foto Profil Lingkaran
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/profile/profile.png'),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 20),

            // Nama
            const Text(
              "Damar Prasetyo",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Kelas
            const Text(
              "XI PPLG2",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // Judul Media Sosial
            const Text(
              "Media Sosial",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Instagram
            _buildSocialItem(
              context,
              icon: Icons.photo_camera,
              label: "Instagram",
              url: "https://www.instagram.com/_ddamarr?igsh=ZTZ2dHh5dW80MXN4",
            ),

            // TikTok
            _buildSocialItem(
              context,
              icon: Icons.music_note,
              label: "TikTok",
              url: "https://www.tiktok.com/@dwamarr?_t=ZS-8zF0U5WKtap&_r=1",
            ),

            // GitHub
            _buildSocialItem(
              context,
              icon: Icons.code,
              label: "GitHub",
              url: "https://github.com/ddamar798",
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat item media sosial
  Widget _buildSocialItem(BuildContext context,
      {required IconData icon, required String label, required String url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          url,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () {
          // Di sini bisa ditambahkan fungsi untuk membuka link (jika pakai package url_launcher)
          // Contoh: launchUrl(Uri.parse(url));
        },
      ),
    );
  }
}