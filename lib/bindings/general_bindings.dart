
import 'package:ecommerce/network_manager.dart';
import 'package:get/get.dart';

class GeneralBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}