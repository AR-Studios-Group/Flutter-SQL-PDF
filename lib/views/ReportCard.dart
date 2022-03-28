import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/reportDBController.dart';
import '../models/report.dart';
import '../utils/PDFGenerator.dart';

class ReportCard extends StatefulWidget {
  final Report report;
  const ReportCard({Key? key, required this.report}) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  final ReportDBController reportDBController = Get.find();

  bool isPDFCreated = false;

  void initalLoad() async {
    try {
      final path = (await getApplicationDocumentsDirectory()).path;
      final file = File('$path/${widget.report.userId}.pdf');
      List<int> bytes = await file.readAsBytes();
      if (bytes.isNotEmpty) {
        setState(() {
          isPDFCreated = true;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  void handlePDFCreation() async {
    try {
      if (!isPDFCreated) {
        final pdf = await createPDF(widget.report);
        await savePDF(pdf, widget.report.userId);
        setState(() {
          isPDFCreated = true;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  initState() {
    super.initState();
    initalLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.report.create_date),
                Text(widget.report.userId),
                Text(widget.report.device_name),
                Text(widget.report.phoneId),
                Text(widget.report.installation_result)
              ],
            ),
            GestureDetector(
                onTap: handlePDFCreation,
                child: Icon(
                  Icons.picture_as_pdf_rounded,
                  color: isPDFCreated ? Colors.green : Colors.black,
                )),
            GestureDetector(
              onTap: () {
                reportDBController.delete(widget.report);
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ));
  }
}
