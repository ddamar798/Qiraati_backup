import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static String keyJilidPage(int jilid) => 'jilid_${jilid}_page';
  static const lastJilidKey = 'last_jilid';
  static const lastPdfKey = 'last_pdf_path';

  static Future<void> savePage(int jilid, int page, String pdfPath) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(keyJilidPage(jilid), page);
    await sp.setInt(lastJilidKey, jilid);
    await sp.setString(lastPdfKey, pdfPath);
  }

  static Future<int> getPage(int jilid) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(keyJilidPage(jilid)) ?? 1;
  }

  static Future<int?> getLastJilid() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(lastJilidKey);
  }

  static Future<String?> getLastPdfPath() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(lastPdfKey);
  }
}
