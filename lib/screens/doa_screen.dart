import 'package:flutter/material.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});
  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  final TextEditingController _cari = TextEditingController();

  static const List<Map<String,String>> _doa = [
    {
      "judul":"Doa Sebelum Makan",
      "arab":"اللَّهُمَّ بَارِكْ لَنَا فِيمَا رَزَقْتَنَا",
      "latin":"Allahumma barik lana fima razaqtana",
      "arti":"Ya Allah, berkahilah rezeki yang Engkau berikan."
    },
    {"judul":"Doa Sesudah Makan","arab":"الْحَمْدُ لِلَّهِ","latin":"Alhamdulillah","arti":"Segala puji bagi Allah."},
    {"judul":"Doa Sebelum Tidur","arab":"بِاسْمِكَ اللَّهُمَّ أَحْيَا وَأَمُوتُ","latin":"Bismikallahumma ahya wa amut","arti":"Dengan nama-Mu aku hidup dan mati."},
    {"judul":"Doa Bangun Tidur","arab":"الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا","latin":"Alhamdulillahilladzi ahyana","arti":"Segala puji bagi Allah yang menghidupkan kami."},
    {"judul":"Doa Masuk WC","arab":"اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْخُبُثِ","latin":"Allahumma inni a’udzu bika minal khubutsi","arti":"Ya Allah, aku berlindung kepada-Mu dari hal yang jahat."},
    {"judul":"Doa Keluar WC","arab":"غُفْرَانَكَ","latin":"Ghufranaka","arti":"Aku memohon ampunan-Mu."},
    {"judul":"Doa Sebelum Belajar","arab":"رَبِّ زِدْنِي عِلْمًا","latin":"Rabbi zidni ilma","arti":"Ya Tuhanku, tambahkanlah ilmunya."},
    {"judul":"Doa Sesudah Belajar","arab":"اللَّهُمَّ انْفَعْنِي بِمَا عَلَّمْتَنِي","latin":"Allahummanfa'ni bima 'allamtani","arti":"Ya Allah, beri manfaat dari yang Engkau ajarkan."},
    {"judul":"Doa Masuk Rumah","arab":"بِسْمِ اللَّهِ وَلَجْنَا","latin":"Bismillahi walajna","arti":"Dengan nama Allah kami masuk rumah."},
    {"judul":"Doa Keluar Rumah","arab":"بِسْمِ اللَّهِ تَوَكَّلْتُ","latin":"Bismillahi tawakkaltu","arti":"Dengan nama Allah, aku bertawakal."},
  ];

  @override
  void dispose() {
    _cari.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _cari.text.toLowerCase();
    final list = _doa.where((d){
      return d['judul']!.toLowerCase().contains(q) || d['latin']!.toLowerCase().contains(q) || d['arti']!.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Doa Sehari-hari')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(16,12,16,8), child: TextField(controller: _cari, onChanged: (_) => setState((){}), decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Cari doa...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))))),
        Expanded(child: ListView.builder(padding: const EdgeInsets.fromLTRB(12,0,12,12), itemCount: list.length, itemBuilder: (_,i){
          final d=list[i];
          return Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(d['judul']!, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height:8),
            Align(alignment: Alignment.centerRight, child: Text(d['arab']!, textAlign: TextAlign.right, style: const TextStyle(fontSize:20))),
            const SizedBox(height:8),
            Text('Latin: ${d['latin']!}', style: TextStyle(color: Colors.green.shade800)),
            const SizedBox(height:6),
            Text('Arti: ${d['arti']!}'),
          ])));
        })),
      ]),
    );
  }
}
