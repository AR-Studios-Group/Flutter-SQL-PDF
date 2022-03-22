import 'package:database_pdf/routes/ReportsListScreen/reportsListScreen.dart';
import 'package:database_pdf/routes/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'SQL Database',
      home: BottomTabNavigation(),
    );
  }
}
