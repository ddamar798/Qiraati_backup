import 'package:shared_preferences/shared_preferences.dart';

class ProgressHelper {
  static const _keyJilid = 'last_jilid';
  static const _keyPage = 'last_page';

  /// Simpan progress jilid & halaman terakhir
  static Future<void> saveProgress(int jilid, int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyJilid, jilid);
    await prefs.setInt(_keyPage, page);
  }

  /// Ambil progress terakhir (return null kalau belum ada)
  static Future<Map<String, int>?> getProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final jilid = prefs.getInt(_keyJilid);
    final page = prefs.getInt(_keyPage);

    if (jilid != null && page != null) {
      return {'jilid': jilid, 'page': page};
    }
    return null;
  }

  /// Reset progress (kalau mau dihapus)
  static Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyJilid);
    await prefs.remove(_keyPage);
  }
}