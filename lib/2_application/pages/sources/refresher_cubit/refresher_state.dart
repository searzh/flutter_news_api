part of 'refresher_cubit.dart';

abstract class RefresherState extends Equatable {
  const RefresherState();

  @override
  List<Object?> get props => [];
}

class RefresherInitialState extends RefresherState {
  const RefresherInitialState({required this.value});

  final bool value;

  @override
  List<Object?> get props => [value];
}

class RefresherLoadedState extends RefresherState {
  const RefresherLoadedState({required this.value});

  final bool value;

  @override
  List<Object?> get props => [value];
}
