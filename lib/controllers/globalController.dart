import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class GlobalStateController extends GetxController {
  late String path;

  @override
  void onInit() async {
    path = (await getApplicationDocumentsDirectory()).path;
    super.onInit();
  }
}
