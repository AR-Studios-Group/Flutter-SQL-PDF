import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

import '../controllers/companyDataController.dart';
import '../controllers/globalController.dart';
import '../models/report.dart';

Future<Widget> Header() async {
  final CompanyDataController companyDataController = Get.find();
  final font = await PdfGoogleFonts.nunitoExtraLight();

  late ImageProvider logo;
  if (companyDataController.logo.value == '') {
    logo = MemoryImage(base64Decode(companyDataController.logoStorage.value));
  } else {
    logo = await networkImage(companyDataController.logo.value);
  }

  return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(logo, height: 50, width: 50),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Container()),
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(companyDataController.name.value,
                  style: TextStyle(font: font, fontSize: 14)),
              Text(companyDataController.address.value,
                  style: TextStyle(font: font, fontSize: 10)),
            ]),
      ]);
}

Future<Widget> Body(Report report) async {
  final font = await PdfGoogleFonts.nunitoExtraLight();

  return Table(children: [
    TableRow(children: [
      Text('Created On',
          style: TextStyle(
            font: font,
            fontSize: 14,
          )),
      Text('Alias',
          style: TextStyle(
            font: font,
            fontSize: 14,
          )),
      Text('Device Name',
          style: TextStyle(
            font: font,
            fontSize: 14,
          )),
      Text('Phone ID',
          style: TextStyle(
            font: font,
            fontSize: 14,
          )),
      Text('User ID',
          style: TextStyle(
            font: font,
            fontSize: 14,
          )),
      Text('Result',
          style: TextStyle(
            font: font,
            fontSize: 14,
          )),
    ]),
    TableRow(children: [
      Text(report.create_date, style: TextStyle(font: font, fontSize: 14)),
      Text(report.alias, style: TextStyle(font: font, fontSize: 14)),
      Text(report.device_name, style: TextStyle(font: font, fontSize: 14)),
      Text(report.phoneId, style: TextStyle(font: font, fontSize: 14)),
      Text(report.userId, style: TextStyle(font: font, fontSize: 14)),
      Text(report.installation_result,
          style: TextStyle(font: font, fontSize: 14)),
    ])
  ]);
}

Future<Document> createPDF(Report report) async {
  final pdf = Document();

  final ReportHeader = await Header();
  final ReportBody = await Body(report);

  pdf.addPage(Page(
      margin: const EdgeInsets.all(20),
      pageFormat: PdfPageFormat.a4,
      build: (Context context) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ReportHeader,
          SizedBox(height: 5),
          Divider(),
          ReportBody,
        ]);
      }));

  print('PDF Created');

  return pdf;
}

Future<bool> savePDF(Document pdf, String fileName) async {
  final GlobalStateController globalStateController = Get.find();
  try {
    List<int> bytes = await pdf.save();
    final file = File('${globalStateController.path}/$fileName.pdf');
    await file.writeAsBytes(bytes);
    OpenFile.open('${globalStateController.path}/$fileName.pdf');
    return true;
  } catch (err) {
    print(err);
    return false;
  }
}
