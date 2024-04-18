import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection.dart';
import '../../core/utils/sizes.dart';
import 'refresher_cubit/refresher_cubit.dart';
import 'sources_cubit/sources_cubit.dart';
import '../../core/widgets/hs_circular_progress_indicator.dart';
import '../../core/widgets/hs_error_message.dart';
import 'widgets/source_list_tile.dart';

class SourcesPageWrapperProvider extends StatelessWidget {
  const SourcesPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SourcesCubit>()..sourcesRequest(),
        ),
        BlocProvider(
          create: (context) => sl<RefresherCubit>()..loadInitialState(),
        ),
      ],
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
        actions: [
          BlocBuilder<RefresherCubit, RefresherState>(
            builder: (context, state) {
              if (state is RefresherInitialState) {
                return Switch.adaptive(
                  value: context.read<RefresherCubit>().toggleValue.value,
                  onChanged: (value) {
                    context.read<RefresherCubit>().toggleService();
                  },
                );
              }

              if (state is RefresherLoadedState) {
                return Switch.adaptive(
                  value: state.value,
                  onChanged: (value) {
                    context.read<RefresherCubit>().toggleService();
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
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
