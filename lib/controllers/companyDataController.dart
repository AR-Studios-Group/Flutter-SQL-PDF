import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class CompanyDataController extends GetxController {
  final storage = GetStorage();
  final ImagePicker picker = ImagePicker();

  var name = ''.obs;
  var address = ''.obs;
  var logo = ''.obs;
  var logoStorage = ''.obs; // Saved as base64

  void pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        List<int> imageByte = File(image.path).readAsBytesSync();
        String imageBase64 = base64Encode(imageByte);

        writeString('@logo_photo', imageBase64);
      } else {
        logoStorage.value = '';
      }
    } catch (err) {
      print(err);
    }
  }

  String readString(String key) {
    var storedStr = storage.read(key);
    if (storedStr == null) return '';
    return storedStr;
  }

  void writeString(String key, String value) {
    storage.write(key, value);
    switch (key) {
      case '@name':
        name.value = value;
        break;
      case '@address':
        address.value = value;
        break;
      case '@logo':
        logo.value = value;
        logoStorage.value = '';
        storage.write('@logo_photo', '');
        break;
      case '@logo_photo':
        logoStorage.value = value;
        logo.value = '';
        storage.write('@logo', '');
        break;
    }
  }

  void initialFetch() {
    name.value = readString('@name');
    address.value = readString('@address');
    logo.value = readString('@logo');
    logoStorage.value = readString('@logo_photo');
  }

  @override
  void onInit() {
    initialFetch();
    super.onInit();
  }
}
