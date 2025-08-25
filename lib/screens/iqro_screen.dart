import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../services/progress_service.dart';
import '../services/stats_service.dart';

class IqroScreen extends StatefulWidget {
  final int jilid; // 1..6
  final String pdfAssetPath;

  const IqroScreen({
    super.key,
    required this.jilid,
    required this.pdfAssetPath,
  });

  @override
  State<IqroScreen> createState() => _IqroScreenState();
}

class _IqroScreenState extends State<IqroScreen> {
  final GlobalKey<SfPdfViewerState> _pdfKey = GlobalKey();
  late final PdfViewerController _controller;
  int _currentPage = 1;
  bool _initialJumpDone = false;

  @override
  void initState() {
    super.initState();
    _controller = PdfViewerController();
    _restoreProgress();
  }

  Future<void> _restoreProgress() async {
    final saved = await ProgressService.getPage(widget.jilid);
    _currentPage = saved;
    // Tunggu frame agar controller siap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_initialJumpDone) {
        _controller.jumpToPage(saved);
        _initialJumpDone = true;
      }
    });
  }

  Future<void> _save(int page) async {
    await ProgressService.savePage(widget.jilid, page, widget.pdfAssetPath);
    await StatsService.addXp(1); // XP kecil tiap pindah halaman
  }

  void _prev() {
    if (_controller.pageNumber > 1) {
      _controller.previousPage();
    }
  }

  void _next() {
    _controller.nextPage();
  }

  void _lanjutkanBelajar() async {
    final lastJilid = await ProgressService.getLastJilid();
    final lastPath = await ProgressService.getLastPdfPath();
    if (lastJilid != null && lastPath != null) {
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => IqroScreen(jilid: lastJilid, pdfAssetPath: lastPath),
        ));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Belum ada progres tersimpan.'),
        ));
      }
    }
  }

  void _pilihJilid(int jilid) {
    final path = 'assets/pdf/iqro_jilid$jilid.pdf';
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => IqroScreen(jilid: jilid, pdfAssetPath: path),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iqro Jilid ${widget.jilid}'),
        actions: [
          IconButton(
            tooltip: 'Lanjutkan Belajar',
            icon: const Icon(Icons.bookmark_added),
            onPressed: _lanjutkanBelajar,
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.menu_book),
            tooltip: 'Pilih Jilid',
            onSelected: _pilihJilid,
            itemBuilder: (context) => List.generate(
              6,
              (i) => PopupMenuItem(
                value: i + 1,
                child: Text('Buka Iqro Jilid ${i + 1}'),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            widget.pdfAssetPath,
            key: _pdfKey,
            controller: _controller,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            onPageChanged: (d) {
              _currentPage = d.newPageNumber;
              _save(_currentPage);
            },
          ),
          // Tombol navigasi next/prev mengambang
          Positioned(
            left: 12,
            top: MediaQuery.of(context).size.height * 0.45,
            child: FloatingActionButton.small(
              heroTag: 'prev',
              backgroundColor: Colors.green,
              onPressed: _prev,
              child: const Icon(Icons.chevron_left),
            ),
          ),
          Positioned(
            right: 12,
            top: MediaQuery.of(context).size.height * 0.45,
            child: FloatingActionButton.small(
              heroTag: 'next',
              backgroundColor: Colors.green,
              onPressed: _next,
              child: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Halaman: $_currentPage',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _controller.jumpToPage(_currentPage);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Kembali ke halaman $_currentPage')),
                  );
                },
                icon: const Icon(Icons.bookmark),
                label: const Text('Ke Halaman Ini'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
