import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BelajarScreen extends StatefulWidget {
  final int jilid;
  const BelajarScreen({super.key, required this.jilid});

  @override
  State<BelajarScreen> createState() => _BelajarScreenState();
}

class _BelajarScreenState extends State<BelajarScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController? _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfViewerController();
    _loadLastPage();
  }

  Future<void> _loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPage = prefs.getInt("last_page_jilid_${widget.jilid}") ?? 1;
    _pdfController?.jumpToPage(lastPage);
  }

  Future<void> _saveLastPage(int pageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("last_page_jilid_${widget.jilid}", pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Iqro Jilid ${widget.jilid}"),
        backgroundColor: Colors.green,
      ),
      body: SfPdfViewer.asset(
        "assets/iqro/iqro${widget.jilid}.pdf",
        key: _pdfViewerKey,
        controller: _pdfController,
        onPageChanged: (PdfPageChangedDetails details) {
          _saveLastPage(details.newPageNumber);
        },
      ),
    );
  }
}
