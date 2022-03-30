import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/reportDBController.dart';
import '../../../models/report.dart';

class NewReportScreen extends StatelessWidget {
  final ReportDBController reportDBController = Get.find();
  final userIdController = TextEditingController();
  final aliasController = TextEditingController();
  final statusController = TextEditingController();

  NewReportScreen({Key? key}) : super(key: key);

  void _handleNewEntry() async {
    try {
      DateTime _now = DateTime.now();
      var creationTime =
          '${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}';

      var userID = userIdController.text;
      var alias = aliasController.text;
      var status = statusController.text;

      var newReport =
          Report(creationTime, 'iPhone', userID, 'phone ID', alias, status);
      reportDBController.add(newReport);

      userIdController.text = '';
      aliasController.text = '';
      statusController.text = '';

      Get.back();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Report'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: userIdController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'User ID',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: aliasController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Alias',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: statusController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Status',
              ),
            ),
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent)),
              onPressed: _handleNewEntry,
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
