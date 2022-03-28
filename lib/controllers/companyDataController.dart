import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class CompanyDataController extends GetxController {
  final storage = GetStorage();
  final ImagePicker picker = ImagePicker();

  var name = ''.obs;
  var address = ''.obs;
  var logo = ''.obs;
  var logoStorage = File('').obs;

  void pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      logoStorage.value = File(image!.path);
      writeString('@logo_photo', image.path);
      writeString('@logo', '');
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
        break;
      case '@logo_photo':
        logoStorage.value = File(value);
        break;
    }
  }

  void initialFetch() {
    var _name = readString('@name');
    var _address = readString('@address');
    var _logo = readString('@logo');
    var _logo_photo = readString('@logo_photo');

    name.value = _name;
    address.value = _address;
    logo.value = _logo;
    logoStorage.value = File(_logo_photo);
  }

  @override
  void onInit() {
    initialFetch();
    super.onInit();
  }
}
