import 'package:flutter/material.dart';

class Juz30Screen extends StatefulWidget {
  const Juz30Screen({super.key});
  @override
  State<Juz30Screen> createState() => _Juz30ScreenState();
}

class _Juz30ScreenState extends State<Juz30Screen> {
  final TextEditingController _cari = TextEditingController();

  static const List<Map<String, dynamic>> _surah = [
    {
      "nama":"An-Nas","nomor":114,
      "ayat":[
        {"arab":"قُلْ أَعُوذُ بِرَبِّ النَّاسِ","latin":"Qul a'ūdzu bi rabbin-nās"},
        {"arab":"مَلِكِ النَّاسِ","latin":"Malikin-nās"},
        {"arab":"إِلٰهِ النَّاسِ","latin":"Ilāhin-nās"},
        {"arab":"مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ","latin":"Min syarril waswāsil khannās"},
        {"arab":"الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ","latin":"Alladzī yuwaswisu fī shudūrin-nās"},
        {"arab":"مِنَ الْجِنَّةِ وَالنَّاسِ","latin":"Minal jinnati wan-nās"},
      ]
    },
    {
      "nama":"Al-Falaq","nomor":113,
      "ayat":[
        {"arab":"قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ","latin":"Qul a'ūdzu birabbil-falaq"},
        {"arab":"مِنْ شَرِّ مَا خَلَقَ","latin":"Min syarri mā khalaq"},
        {"arab":"وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ","latin":"Wa min syarri ghāsiqin idzā waqab"},
        {"arab":"وَمِنْ شَرِّ النَّفّٰثٰتِ فِي الْعُقَدِ","latin":"Wa min syarrin-naffāṡāti fil 'uqad"},
        {"arab":"وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ","latin":"Wa min syarri ḥāsidin idzā ḥasad"},
      ]
    },
    {
      "nama":"Al-Ikhlas","nomor":112,
      "ayat":[
        {"arab":"قُلْ هُوَ اللّٰهُ أَحَدٌ","latin":"Qul huwallāhu aḥad"},
        {"arab":"اللّٰهُ الصَّمَدُ","latin":"Allāhuṣ-Ṣamad"},
        {"arab":"لَمْ يَلِدْ وَلَمْ يُولَدْ","latin":"Lam yalid wa lam yūlad"},
        {"arab":"وَلَمْ يَكُنْ لَّهُ كُفُوًا أَحَدٌ","latin":"Wa lam yakun lahū kufuwan aḥad"},
      ]
    },
    {
      "nama":"Al-Lahab","nomor":111,
      "ayat":[
        {"arab":"تَبَّتْ يَدَا أَبِي لَهَبٍ وَتَبَّ","latin":"Tabbat yadā Abī Lahabin wa tab"},
        {"arab":"مَا أَغْنَىٰ عَنْهُ مَالُهُ وَمَا كَسَبَ","latin":"Mā aghnā 'anhu māluhū wa mā kasab"},
        {"arab":"سَيَصْلَىٰ نَارًا ذَاتَ لَهَبٍ","latin":"Sayashlā nāran dzāta lahab"},
        {"arab":"وَٱمْرَأَتُهُ حَمَّالَةَ ٱلْحَطَبِ","latin":"Wamra’atuhū ḥammālatal ḥaṭab"},
        {"arab":"فِي جِيدِهَا حَبْلٌ مِّن مَّسَدٍ","latin":"Fī jīdihā ḥablum mim masad"},
      ]
    },
    {
      "nama":"An-Nasr","nomor":110,
      "ayat":[
        {"arab":"إِذَا جَاءَ نَصْرُ اللّٰهِ وَالْفَتْحُ","latin":"Idzā jā’a naṣrullāhi wal-fatḥ"},
        {"arab":"وَرَأَيْتَ النَّاسَ يَدْخُلُونَ فِي دِينِ اللّٰهِ أَفْوَاجًا","latin":"Wa ra'aytan-nāsa yadkhulūna fī dīnillāhi afwājā"},
        {"arab":"فَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ","latin":"Fasabbih biḥamdi rabbika wastaghfirh"},
      ]
    },
  ];

  @override
  void dispose() {
    _cari.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _cari.text.toLowerCase();
    final list = _surah.where((s) => (s['nama'] as String).toLowerCase().contains(q)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Surah Pendek (Juz 30)')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(16,12,16,8), child: TextField(controller: _cari, onChanged: (_) => setState((){}), decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Cari surah...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))))),
        Expanded(child: ListView.builder(padding: const EdgeInsets.fromLTRB(12,0,12,12), itemCount: list.length, itemBuilder: (_,i){
          final s = list[i];
          final ayat = s['ayat'] as List<dynamic>;
          return Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
            Text('${s['nomor']}. ${s['nama']}', style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height:8),
            ...ayat.map((a){
              final m = a as Map<String,dynamic>;
              return Padding(padding: const EdgeInsets.only(bottom:12), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children:[
                Align(alignment: Alignment.centerRight, child: Text(m['arab'], textAlign: TextAlign.right, style: const TextStyle(fontSize:20))),
                const SizedBox(height:6),
                Text('Latin: ${m['latin']}', style: TextStyle(color: Colors.green.shade800)),
              ]));
            }),
          ])));
        })),
      ]),
    );
  }
}
