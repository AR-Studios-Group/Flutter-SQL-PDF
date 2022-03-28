import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/companyDataController.dart';

class CompanySettings extends StatelessWidget {
  final CompanyDataController companyDataController = Get.find();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final logoController = TextEditingController();
  CompanySettings({Key? key}) : super(key: key);

  void _handleUpdate() {
    try {
      if (nameController.text != '') {
        companyDataController.writeString('@name', nameController.text);
      }

      if (addressController.text != '') {
        companyDataController.writeString('@address', addressController.text);
      }

      if (logoController.text != '') {
        companyDataController.writeString('@logo', logoController.text);
        companyDataController.writeString('@logo_photo', '');
      }

      nameController.text = '';
      addressController.text = '';
      logoController.text = '';
    } catch (err) {
      print(err);
    }
  }

  void _handlePickImageFromPhotos() {
    companyDataController.pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => Text('Name: ${companyDataController.name.value}')),
          Obx(() => Text('Address: ${companyDataController.address.value}')),
          Obx(() => companyDataController.logo.value.contains('jpg')
              ? Image.network(companyDataController.logo.value,
                  width: 50, height: 50)
              : Container()),
          Obx(() => SizedBox(
                width: 50,
                height: 50,
                child: companyDataController.logoStorage.value == File('')
                    ? Container()
                    : Image.file(companyDataController.logoStorage.value),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: companyDataController.name.value,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: companyDataController.address.value,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              controller: logoController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Logo URL',
              ),
            ),
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent)),
              onPressed: _handlePickImageFromPhotos,
              child: const Text(
                'Pick Image from Photos',
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent)),
              onPressed: _handleUpdate,
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }
}
