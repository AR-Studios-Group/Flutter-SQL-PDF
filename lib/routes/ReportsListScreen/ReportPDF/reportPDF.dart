import 'package:flutter/material.dart';

import '../../../models/report.dart';
import 'PDFGenerator.dart';

class ReportPDF extends StatefulWidget {
  final Report report;
  const ReportPDF({Key? key, required this.report}) : super(key: key);

  @override
  State<ReportPDF> createState() => _ReportPDFState();
}

class _ReportPDFState extends State<ReportPDF> {
  bool isPDFCreated = false;

  void updateState(bool val) {
    setState(() {
      isPDFCreated = val;
    });
  }

  Future<void> _handleCreatePDF() async {
    createPDF(widget.report)
        .then((pdf) => savePDF(pdf, widget.report.userId))
        .then((value) => updateState(value));
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
                  backgroundColor: isPDFCreated
                      ? MaterialStateProperty.all(Colors.lightGreenAccent)
                      : MaterialStateProperty.all(Colors.lightBlueAccent)),
              onPressed: _handleCreatePDF,
              child: const Text(
                'Create PDF Report',
                style: TextStyle(color: Colors.black),
              )),
        ));
  }
}
