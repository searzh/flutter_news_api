import 'package:flutter/material.dart';

import '../../../1_domain/failures/failures.dart';

class HSErrorMessage extends StatelessWidget {
  const HSErrorMessage({
    super.key,
    required this.message,
    this.failure,
  });

  final String message;
  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          failure is EmptyFailure ? Icons.crisis_alert_outlined : Icons.error,
          size: 40,
          color: Colors.red,
        ),
        const SizedBox(height: 24),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
