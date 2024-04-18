part of 'sources_cubit.dart';

sealed class SourcesState extends Equatable {
  const SourcesState();

  @override
  List<Object?> get props => [];
}

final class SourcesInitialState extends SourcesState {
  const SourcesInitialState();
}

final class SourcesLoadingState extends SourcesState {
  const SourcesLoadingState();
}

final class SourcesLoadedState extends SourcesState {
  const SourcesLoadedState({required this.sources});

  final List<SourceEntity> sources;

  @override
  List<Object?> get props => [sources];
}

final class SourcesErrorState extends SourcesState {
  const SourcesErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
