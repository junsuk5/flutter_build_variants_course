import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flavor_memo_app/core/di/di_setup.dart';
import 'package:flavor_memo_app/core/router/router.dart';
import 'package:flavor_memo_app/firebase_options.dart';
import 'package:flavor_memo_app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlavorConfig.appFlavor = Flavor.prod;
  setupDI();

  runApp(MyApp(router: router));
}
