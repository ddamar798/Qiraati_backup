import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const _kXp = 'xp';
  static const _kTotalLetters = 'total_letters';
  static const _kQuizzesTaken = 'quizzes_taken';
  static const _kTotalQuizScore = 'total_quiz_score';
  static const _kLastQuizScore = 'last_quiz_score';

  static Future<int> getXp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kXp) ?? 0;
    }

  static Future<void> addXp(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_kXp) ?? 0;
    await prefs.setInt(_kXp, current + amount);
  }

  static Future<int> getTotalLetters() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kTotalLetters) ?? 0;
  }

  static Future<void> incLetters([int by = 1]) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_kTotalLetters) ?? 0;
    await prefs.setInt(_kTotalLetters, current + by);
    await addXp(2); // bonus kecil tiap dengar huruf
  }

  static Future<void> recordQuiz({required int score, required int max}) async {
    final prefs = await SharedPreferences.getInstance();
    final taken = prefs.getInt(_kQuizzesTaken) ?? 0;
    final totalScore = prefs.getInt(_kTotalQuizScore) ?? 0;
    await prefs.setInt(_kQuizzesTaken, taken + 1);
    await prefs.setInt(_kTotalQuizScore, totalScore + score);
    await prefs.setInt(_kLastQuizScore, score);
    // XP berdasarkan performa
    await addXp(score * 3);
  }

  static Future<Map<String, int>> getQuizStats() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'taken': prefs.getInt(_kQuizzesTaken) ?? 0,
      'total': prefs.getInt(_kTotalQuizScore) ?? 0,
      'last': prefs.getInt(_kLastQuizScore) ?? 0,
    };
  }
}
