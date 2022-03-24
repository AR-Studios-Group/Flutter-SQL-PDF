import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

import '../../../controllers/companyDataController.dart';
import '../../../models/report.dart';

Future<Widget> Header() async {
  final CompanyDataController companyDataController = Get.find();
  final logo = await networkImage(companyDataController.logo.value);
  final font = await PdfGoogleFonts.nunitoExtraLight();

  return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Image(logo, width: 50, height: 50)),
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
  return Table(children: [
    TableRow(children: [
      Text(
        'Created On',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Alias', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Device Name', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Phone ID', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('User ID', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Result', style: TextStyle(fontWeight: FontWeight.bold)),
    ]),
    TableRow(children: [
      Text(report.create_date),
      Text(report.alias),
      Text(report.device_name),
      Text(report.phoneId),
      Text(report.userId),
      Text(report.installation_result),
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

  return pdf;
}

Future<bool> savePDF(Document pdf, String fileName) async {
  try {
    List<int> bytes = await pdf.save();
    final path = (await getApplicationDocumentsDirectory()).path;
    print(path);
    final file = File('$path/$fileName.pdf');
    await file.writeAsBytes(bytes);
    return true;
  } catch (err) {
    return false;
  }
}
