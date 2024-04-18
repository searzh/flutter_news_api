import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '2_application/core/router/routes.dart';
import '2_application/core/storage/database_helper.dart';

import 'injection.dart' as di;
import '2_application/core/refresher/background_service.dart' as bs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await DatabaseHelper().database;

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  await bs.initializeService();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Headspace Challenge',
      routerConfig: routes,
    );
  }
}
