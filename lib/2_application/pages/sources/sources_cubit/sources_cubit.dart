import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../1_domain/entities/source_entity.dart';
import '../../../../1_domain/usecases/sources_usecases.dart';
import '../../../core/utils/functions.dart';

part 'sources_state.dart';

class SourcesCubit extends Cubit<SourcesState> {
  SourcesCubit({required this.sourcesUseCases})
      : super(
          const SourcesInitialState(),
        );

  final SourcesUseCases sourcesUseCases;

  void sourcesRequest() async {
    emit(const SourcesLoadingState());

    final failureOrSources = await sourcesUseCases.getSources();

    failureOrSources.fold(
      (failure) => emit(
        SourcesErrorState(message: mapFailureToMessage(failure)),
      ),
      (sources) => emit(
        SourcesLoadedState(sources: sources.sources),
      ),
    );
  }
}
