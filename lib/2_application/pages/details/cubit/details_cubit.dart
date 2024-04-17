import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../1_domain/entities/article_entity.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(const DetailsInitialState());

  void loadDetails({required ArticleEntity article}) async {
    emit(const DetailsLoadingState());

    await Future.delayed(Durations.short1);

    emit(DetailsLoadedState(article: article));
  }
}
