import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/reportDBController.dart';
import '../models/report.dart';
import '../routes/ReportsListScreen/ReportPDF/reportPDF.dart';

class ReportCard extends StatelessWidget {
  final ReportDBController reportDBController = Get.find();
  final Report report;

  ReportCard({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ReportPDF(report: report));
      },
      child: Container(
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
                  Text(report.create_date),
                  Text(report.userId),
                  Text(report.device_name),
                  Text(report.phoneId),
                  Text(report.installation_result)
                ],
              ),
              GestureDetector(
                onTap: () {
                  reportDBController.delete(report);
                },
                child: const Icon(Icons.delete),
              ),
            ],
          )),
    );
  }
}
