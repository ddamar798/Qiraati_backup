import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const xpKey = 'xp';
  static const lettersKey = 'letters';
  static const quizzesTakenKey = 'quizzes_taken';
  static const totalQuizScoreKey = 'total_quiz_score';
  static const lastQuizKey = 'last_quiz_score';

  static Future<int> getXp() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(xpKey) ?? 0;
  }

  static Future<void> addXp(int n) async {
    final sp = await SharedPreferences.getInstance();
    final now = sp.getInt(xpKey) ?? 0;
    await sp.setInt(xpKey, now + n);
  }

  static Future<int> getLetters() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(lettersKey) ?? 0;
  }

  static Future<void> incLetter([int by = 1]) async {
    final sp = await SharedPreferences.getInstance();
    final now = sp.getInt(lettersKey) ?? 0;
    await sp.setInt(lettersKey, now + by);
    await addXp(2);
  }

  static Future<void> recordQuiz(int score, int max) async {
    final sp = await SharedPreferences.getInstance();
    final taken = sp.getInt(quizzesTakenKey) ?? 0;
    final total = sp.getInt(totalQuizScoreKey) ?? 0;
    await sp.setInt(quizzesTakenKey, taken + 1);
    await sp.setInt(totalQuizScoreKey, total + score);
    await sp.setInt(lastQuizKey, score);
    await addXp(score * 3);
  }

  static Future<Map<String, int>> getQuizStats() async {
    final sp = await SharedPreferences.getInstance();
    return {
      'taken': sp.getInt(quizzesTakenKey) ?? 0,
      'total': sp.getInt(totalQuizScoreKey) ?? 0,
      'last': sp.getInt(lastQuizKey) ?? 0,
    };
  }
}
