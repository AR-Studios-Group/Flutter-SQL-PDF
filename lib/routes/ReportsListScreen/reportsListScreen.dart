import 'package:database_pdf/controllers/reportDBController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/ReportCard.dart';
import 'NewReportScreen/NewReportScreen.dart';

class ReportListScreen extends StatelessWidget {
  final ReportDBController reportDBController = Get.find();

  ReportListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(NewReportScreen());
        },
      ),
      appBar: AppBar(
        title: const Text('Reports'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                reportDBController.readAll();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: reportDBController.reports.length,
                    itemBuilder: (context, index) {
                      return ReportCard(
                          report: reportDBController.reports[index]);
                    },
                  )))
        ],
      ),
    );
  }
}
