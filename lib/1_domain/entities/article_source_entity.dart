import 'package:equatable/equatable.dart';

class ArticleSourceEntity extends Equatable {
  const ArticleSourceEntity({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
