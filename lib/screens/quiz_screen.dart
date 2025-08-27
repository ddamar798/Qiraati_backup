import 'package:flutter/material.dart';
import '../services/stats_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [
  {"q": "Huruf pertama hijaiyah?", "choices": ["ب","ت","ا","ث"], "answer": 2},
  {"q": "Huruf setelah ر adalah?", "choices": ["ز","س","د","ش"], "answer": 0},
  {"q": "Huruf sebelum م adalah?", "choices": ["ك","ن","ل","ه"], "answer": 2},
  {"q": "Huruf ketiga hijaiyah adalah?", "choices": ["ا","ب","ت","ث"], "answer": 1},
  {"q": "Huruf setelah د adalah?", "choices": ["ذ","ر","ز","ح"], "answer": 0},
  {"q": "Huruf sebelum ط adalah?", "choices": ["ز","ض","ظ","خ"], "answer": 1},
  {"q": "Huruf terakhir hijaiyah adalah?", "choices": ["و","ي","ه","لا"], "answer": 1},
  {"q": "Huruf setelah س adalah?", "choices": ["ص","ش","ث","ز"], "answer": 0},
  {"q": "Huruf sebelum ف adalah?", "choices": ["ق","غ","ع","ك"], "answer": 2},
  {"q": "Huruf setelah ظ adalah?", "choices": ["ع","ط","غ","ق"], "answer": 0}
];
  final Map<int,int> _picked = {};
  bool _submitted = false;
  int _score = 0;

  void _submit() async {
    int score = 0;
    for (int i=0;i<_questions.length;i++) {
      if (_picked[i]==_questions[i]['answer']) score++;
    }
    setState((){ _submitted=true; _score=score; });
    await StatsService.recordQuiz(score, _questions.length);
    if (!mounted) return;
    showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Hasil Quiz'), content: Text('Skor: $score / ${_questions.length}'), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('OK'))]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Ayo Latihan ✍🏻')), body: ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: _questions.length+1,
      separatorBuilder: (_,__)=>const SizedBox(height:12),
      itemBuilder: (c,i){
        if (i==_questions.length) return Row(children: [
          Expanded(child: ElevatedButton(onPressed: _submitted?null:_submit, child: const Text('Kumpulkan'))),
          const SizedBox(width:12),
          Expanded(child: OutlinedButton(onPressed: ()=>setState(()=>{_picked.clear(),_submitted=false,_score=0}), child: const Text('Reset'))),
        ]);
        final q=_questions[i];
        final picked=_picked[i];
        return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Text('Soal ${i+1}', style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
          const SizedBox(height:6),
          Text(q['q']),
          const SizedBox(height:8),
          ...List.generate((q['choices'] as List).length,(j){
            return RadioListTile<int>(
              value: j, groupValue: picked, onChanged: _submitted?null:(val)=>setState(()=>_picked[i]=val!), title: Text(q['choices'][j]),
            );
          })
        ])));
      },
    ));
  }
}
