import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CompanyDataController extends GetxController {
  final storage = GetStorage();
  var name = ''.obs;
  var address = ''.obs;
  var logo = ''.obs;

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
    }
  }

  void initialFetch() {
    var _name = readString('@name');
    var _address = readString('@address');
    var _logo = readString('@logo');

    name.value = _name;
    address.value = _address;
    logo.value = _logo;
  }

  @override
  void onInit() {
    initialFetch();
    super.onInit();
  }
}
