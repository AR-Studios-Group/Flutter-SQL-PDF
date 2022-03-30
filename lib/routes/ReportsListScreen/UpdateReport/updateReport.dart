import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/reportDBController.dart';
import '../../../models/report.dart';

class UpdateReport extends StatelessWidget {
  final ReportDBController reportDBController = Get.find();
  final Report report;

  UpdateReport({Key? key, required this.report}) : super(key: key);

  final deviceNameController = TextEditingController();
  final userIDController = TextEditingController();
  final phoneIDController = TextEditingController();
  final aliasController = TextEditingController();

  void _handleReportUpdate() {
    String _deviceName = report.device_name;
    String _userID = report.userId;
    String _phoneID = report.phoneId;
    String _alias = report.alias;

    if (deviceNameController.text != '') {
      _deviceName = deviceNameController.text;
    }

    if (userIDController.text != '') {
      _userID = userIDController.text;
    }

    if (phoneIDController.text != '') {
      _phoneID = phoneIDController.text;
    }

    if (aliasController.text != '') {
      _alias = aliasController.text;
    }

    Report newReport = Report(report.create_date, _deviceName, _userID,
        _phoneID, _alias, report.installation_result);

    reportDBController.updateItem(newReport);

    deviceNameController.text = '';
    userIDController.text = '';
    phoneIDController.text = '';
    aliasController.text = '';

    reportDBController.readAll();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Report')),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleReportUpdate,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.update),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: deviceNameController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Device Name - ${report.device_name}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: userIDController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'User ID - ${report.userId}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: phoneIDController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Phone ID - ${report.phoneId}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: aliasController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Alias - ${report.alias}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
