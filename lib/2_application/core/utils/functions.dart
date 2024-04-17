import 'strings.dart';
import '../../../1_domain/failures/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case == ServerFailure:
      return HSStrings.serverFailureMessage;
    case == EmptyFailure:
      return HSStrings.emptyFailureMessage;
    default:
      return HSStrings.generalFailureMessage;
  }
}

Map<String, dynamic> escapeQuotes(Map<String, dynamic> json) {
  return json.map((key, value) {
    if (value == null) {
      return MapEntry(key, '');
    } else if (value is String) {
      return MapEntry(key, value.replaceAll('"', '\\"'));
    } else if (value is Map<String, dynamic>) {
      return MapEntry(key, escapeQuotes(value));
    } else if (value is List) {
      return MapEntry(
          key,
          value.map((item) {
            if (item is Map<String, dynamic>) {
              return escapeQuotes(item);
            } else {
              return item;
            }
          }).toList());
    } else {
      return MapEntry(key, value);
    }
  });
}
