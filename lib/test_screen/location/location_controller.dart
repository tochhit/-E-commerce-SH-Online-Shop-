import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController extends GetxController {
  static LocationController get instance => Get.find();

  RxBool isLocationEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocationSetting();
  }

  void toggleLocation(bool value) {
    isLocationEnabled.value = value;
    _saveLocationSetting(value);
    // Add any additional logic for enabling/disabling location here
  }

  void _loadLocationSetting() async {
    final prefs = await SharedPreferences.getInstance();
    isLocationEnabled.value = prefs.getBool('isLocationEnabled') ?? false;
  }

  void _saveLocationSetting(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLocationEnabled', value);
  }
}
