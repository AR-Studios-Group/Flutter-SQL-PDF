import 'dart:io';
import 'package:database_pdf/controllers/globalController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import '../controllers/reportDBController.dart';
import '../models/report.dart';
import '../routes/ReportsListScreen/UpdateReport/updateReport.dart';
import '../utils/PDFGenerator.dart';

class ReportCard extends StatefulWidget {
  final Report report;

  ReportCard({Key? key, required this.report}) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  final ReportDBController reportDBController = Get.find();
  final GlobalStateController globalStateController = Get.find();
  bool isPDFBeingCreated = false;

  void handlePDFCreation() async {
    print('pressed');

    try {
      setState(() {
        isPDFBeingCreated = true;
      });

      final pdf = await createPDF(widget.report);
      bool res = await savePDF(pdf, widget.report.userId);

      setState(() {
        isPDFBeingCreated = false;
      });
    } catch (err) {
      print(err);
    }
  }

  void handleUpdate() {
    Get.to(UpdateReport(
      report: widget.report,
    ));
  }

  void handleDelete() async {
    reportDBController.delete(widget.report);
    try {
      final file =
          File('${globalStateController.path}/${widget.report.userId}.pdf');
      List<int> bytes = await file.readAsBytes();

      file.delete();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isPDFBeingCreated) {
      return Container(
        height: 110,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: const Center(
          child: Text('PDF is being created'),
        ),
      );
    }

    return Container(
        height: 110,
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
                child: const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: Colors.black,
                )),
            GestureDetector(
                onTap: handleUpdate,
                child: const Icon(
                  Icons.update,
                  color: Colors.black,
                )),
            GestureDetector(
              onTap: handleDelete,
              child: const Icon(Icons.delete),
            ),
          ],
        ));
  }
}
