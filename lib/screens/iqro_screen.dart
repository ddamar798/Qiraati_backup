import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../services/progress_service.dart';
import '../services/stats_service.dart';

class IqroScreen extends StatefulWidget {
  final int jilid;
  final String pdfAssetPath;
  const IqroScreen({super.key, required this.jilid, required this.pdfAssetPath});

  @override
  State<IqroScreen> createState() => _IqroScreenState();
}

class _IqroScreenState extends State<IqroScreen> {
  final GlobalKey<SfPdfViewerState> _pdfKey = GlobalKey();
  late final PdfViewerController _controller;
  int _currentPage = 1;
  bool _initialJump = false;

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
    _restore();
  }

  Future<void> _restore() async {
    final saved = await ProgressService.getPage(widget.jilid);
    setState(() => _currentPage = saved);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_initialJump) {
        _controller.jumpToPage(saved);
        _initialJump = true;
      }
    });
  }

  Future<void> _save(int page) async {
    await ProgressService.savePage(widget.jilid, page, widget.pdfAssetPath);
    await StatsService.addXp(1);
  }

  void _prev() {
    if (_controller.pageNumber > 1) _controller.previousPage();
  }

  void _next() {
    _controller.nextPage();
  }

  void _pilihJilid(int jilid) {
    final path = 'assets/pdf/iqro_jilid$jilid.pdf';
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => IqroScreen(jilid: jilid, pdfAssetPath: path)));
  }

  void _lanjutkan() async {
    final lastJilid = await ProgressService.getLastJilid();
    final lastPath = await ProgressService.getLastPdfPath();
    if (lastJilid != null && lastPath != null) {
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (_) => IqroScreen(jilid: lastJilid, pdfAssetPath: lastPath)));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Belum ada progres tersimpan')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iqro Jilid ${widget.jilid}'),
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_added), tooltip: 'Lanjutkan Belajar', onPressed: _lanjutkan),
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu_book),
            onSelected: _pilihJilid,
            itemBuilder: (c) => List.generate(6, (i) => PopupMenuItem(value: i + 1, child: Text('Buka Iqro Jilid ${i + 1}'))),
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            widget.pdfAssetPath,
            key: _pdfKey,
            controller: _controller,
            onPageChanged: (details) {
              _currentPage = details.newPageNumber;
              _save(_currentPage);
            },
          ),
          Positioned(
            left: 12,
            top: MediaQuery.of(context).size.height * 0.45,
            child: FloatingActionButton.small(heroTag: 'prev', backgroundColor: Colors.green, onPressed: _prev, child: const Icon(Icons.chevron_left)),
          ),
          Positioned(
            right: 12,
            top: MediaQuery.of(context).size.height * 0.45,
            child: FloatingActionButton.small(heroTag: 'next', backgroundColor: Colors.green, onPressed: _next, child: const Icon(Icons.chevron_right)),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Expanded(child: Text('Halaman: $_currentPage', style: const TextStyle(fontWeight: FontWeight.w600))),
            ElevatedButton.icon(onPressed: () { _controller.jumpToPage(_currentPage); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kembali ke halaman $_currentPage'))); }, icon: const Icon(Icons.bookmark), label: const Text('Ke Halaman Ini')),
          ]),
        ),
      ),
    );
  }
}
