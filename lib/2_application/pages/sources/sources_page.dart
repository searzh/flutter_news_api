import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection.dart';
import '../../core/utils/sizes.dart';
import 'cubit/sources_cubit.dart';
import '../../core/widgets/hs_circular_progress_indicator.dart';
import '../../core/widgets/hs_error_message.dart';
import 'widgets/source_list_tile.dart';

class SourcesPageWrapperProvider extends StatelessWidget {
  const SourcesPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SourcesCubit>()..sourcesRequest(),
      child: const SourcesPage(),
    );
  }
}

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Sources',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: HSSizes.medium1),
        child: BlocBuilder<SourcesCubit, SourcesState>(
          builder: (context, state) {
            if (state is SourcesInitialState) {
              return const HSCircularProgressIndicator();
            }

            if (state is SourcesLoadingState) {
              return const HSCircularProgressIndicator();
            }

            if (state is SourcesLoadedState) {
              return ListView.builder(
                itemCount: max(1, state.sources.length - 1),
                itemBuilder: (context, index) {
                  return SourceListTile(
                    source: state.sources[index],
                  );
                },
              );
            }

            if (state is SourcesErrorState) {
              return Center(child: HSErrorMessage(message: state.message));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
