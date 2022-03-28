import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PDFViewer extends StatelessWidget {
  final String path;
  const PDFViewer({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      path: path,
    );
  }
}
