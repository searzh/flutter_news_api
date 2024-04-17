import 'package:flutter/material.dart';

import '2_application/core/router/routes.dart';

import '2_application/core/storage/setup.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await DatabaseHelper().database;

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
