import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'refresher_state.dart';

class RefresherCubit extends Cubit<RefresherState> {
  RefresherCubit() : super(const RefresherInitialState(value: false));

  final _toggleValue = ValueNotifier<bool>(false);

  ValueNotifier<bool> get toggleValue => _toggleValue;

  void loadInitialState() async {
    FlutterBackgroundService().invoke('SetAsBackground');

    final service = FlutterBackgroundService();

    bool isRunning = await service.isRunning();

    _toggleValue.value = isRunning;

    emit(RefresherInitialState(value: _toggleValue.value));
  }

  void toggleService() async {
    FlutterBackgroundService().invoke('SetAsBackground');

    final service = FlutterBackgroundService();

    bool isRunning = await service.isRunning();

    if (isRunning) {
      service.invoke('stopService');

      _toggleValue.value = false;

      emit(RefresherLoadedState(value: _toggleValue.value));
    } else {
      service.startService();

      _toggleValue.value = true;

      emit(RefresherLoadedState(value: _toggleValue.value));
    }
  }
}
