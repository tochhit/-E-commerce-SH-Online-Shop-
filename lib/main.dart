import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/test_screen/dark_mod/theme_controller.dart';
import 'package:ecommerce/test_screen/location/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

import 'app.dart';

Future<void> main() async {

  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Initialize ThemeController
  Get.put(ThemeController());
  /// Initialize LocationController
  Get.put(LocationController());

  /// GetX Local Storage
  await GetStorage.init();

  /// Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


  /// Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository())
  );

  runApp(const App());
}

