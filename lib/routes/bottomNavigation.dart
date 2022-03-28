import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/companyDataController.dart';
import '../controllers/reportDBController.dart';
import 'CompanySettings/companySettings.dart';
import 'ReportsListScreen/reportsListScreen.dart';

class BottomTabNavigation extends StatefulWidget {
  const BottomTabNavigation({Key? key}) : super(key: key);

  @override
  _BottomTabNavigationState createState() => _BottomTabNavigationState();
}

class _BottomTabNavigationState extends State<BottomTabNavigation> {
  final companyDataController = Get.put(CompanyDataController());
  final reportDBController = Get.put(ReportDBController());

  int _currentIndex = 0;

  void _handleOnTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _handleCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return ReportListScreen();
      case 1:
        return CompanySettings();
      default:
        return const Text('Invalid Index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Center(
        child: _handleCurrentScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.file_copy), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Company'),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _handleOnTap,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
      ),
    ));
  }
}
