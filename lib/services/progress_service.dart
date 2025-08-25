import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const _kLastJilid = 'last_jilid';
  static const _kLastPdfPath = 'last_pdf_path';
  static String keyForJilidPage(int jilid) => 'jilid_${jilid}_page';

  /// Simpan halaman terakhir untuk jilid tertentu + set "lanjutkan belajar".
  static Future<void> savePage(int jilid, int page, String pdfPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyForJilidPage(jilid), page);
    await prefs.setInt(_kLastJilid, jilid);
    await prefs.setString(_kLastPdfPath, pdfPath);
  }

  static Future<int> getPage(int jilid) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyForJilidPage(jilid)) ?? 1;
  }

  static Future<int?> getLastJilid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kLastJilid);
  }

  static Future<String?> getLastPdfPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLastPdfPath);
  }
}
