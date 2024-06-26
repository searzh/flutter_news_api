import 'package:equatable/equatable.dart';

abstract class Failure {}

class ServerFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class GeneralFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class EmptyFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}
