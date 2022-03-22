import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/report.dart';

class ReportPDF extends StatelessWidget {
  final Report report;

  const ReportPDF({Key? key, required this.report}) : super(key: key);

  Future<void> _handleCreatePDF() async {
    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    page.graphics.drawString(
        report.create_date, PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 0, 150, 20));

    page.graphics.drawString(
        report.device_name, PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 0, 150, 20));

    List<int> bytes = document.save();
    document.dispose();

    final path = (await getApplicationSupportDirectory()).path;
    final file = File('$path/${report.userId}.pdf');
    await file.writeAsBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Report'),
        ),
        body: Center(
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent)),
              onPressed: _handleCreatePDF,
              child: const Text(
                'Create PDF Report',
                style: TextStyle(color: Colors.black),
              )),
        ));
  }
}
