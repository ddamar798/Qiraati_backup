import 'package:flutter/material.dart';
import '../services/stats_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _questions = const [
    {
      'q': 'Huruf pertama dalam hijaiyah adalah?',
      'choices': ['ب', 'ت', 'ا', 'ث'],
      'answerIndex': 2,
    },
    {
      'q': 'Huruf setelah ر adalah?',
      'choices': ['ز', 'س', 'د', 'ش'],
      'answerIndex': 0,
    },
    {
      'q': 'Manakah yang dibaca "khaa"?',
      'choices': ['ح', 'خ', 'ج', 'غ'],
      'answerIndex': 1,
    },
  ];

  final Map<int, int> _picked = {}; // indexSoal -> indexJawaban
  bool _submitted = false;
  int _score = 0;

  void _submit() async {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      final ans = _picked[i];
      if (ans != null && ans == _questions[i]['answerIndex']) {
        score++;
      }
    }
    setState(() {
      _submitted = true;
      _score = score;
    });

    await StatsService.recordQuiz(score: score, max: _questions.length);

    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Hasil Quiz'),
          content: Text('Skor kamu: $score / ${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  void _reset() {
    setState(() {
      _picked.clear();
      _submitted = false;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Interaktif')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _questions.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == _questions.length) {
            return Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _submitted ? null : _submit,
                    icon: const Icon(Icons.check),
                    label: const Text('Kumpulkan'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                ),
              ],
            );
          }

          final q = _questions[index];
          final picked = _picked[index];

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Soal ${index + 1}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green)),
                  const SizedBox(height: 8),
                  Text(q['q'] as String,
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  ...List.generate((q['choices'] as List).length, (i) {
                    final choice = (q['choices'] as List)[i] as String;
                    final isCorrect = i == q['answerIndex'];
                    final isPicked = picked == i;

                    Color? tileColor;
                    if (_submitted) {
                      if (isCorrect) {
                        tileColor = Colors.green.shade50;
                      } else if (isPicked && !isCorrect) {
                        tileColor = Colors.red.shade50;
                      }
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isPicked ? Colors.green : Colors.grey.shade300,
                        ),
                      ),
                      child: RadioListTile<int>(
                        value: i,
                        groupValue: picked,
                        activeColor: Colors.green,
                        onChanged: _submitted
                            ? null
                            : (val) {
                                setState(() {
                                  _picked[index] = val!;
                                });
                              },
                        title: Text(choice),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
