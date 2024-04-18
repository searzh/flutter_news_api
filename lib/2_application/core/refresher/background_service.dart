import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import '../../../1_domain/usecases/sources_usecases.dart';
import '../../../injection.dart';
import '../../pages/sources/sources_cubit/sources_cubit.dart';

final sourcesCubit = SourcesCubit(sourcesUseCases: sl<SourcesUseCases>());

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIOSBackground,
      autoStart: false,
    ),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: false,
    ),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    Timer.periodic(const Duration(hours: 3), (timer) async {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
          title: 'Headspace Challenge',
          content: 'Auto refresh periodicity set to 3 hours',
        );

        sourcesCubit.sourcesRequest();

        service.invoke('Update');
      }
    });
  }
}

@pragma('vm:entry-point')
Future<bool> onIOSBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}
