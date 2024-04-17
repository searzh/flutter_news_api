import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../1_domain/entities/source_entity.dart';

class SourceListTile extends StatelessWidget {
  const SourceListTile({
    super.key,
    required this.source,
  });

  final SourceEntity source;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push(
        '/sources/articles',
        extra: source.id,
      ),
      title: Text(
        source.name,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            source.description,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          Text(
            source.url,
            style: const TextStyle(color: Colors.amber),
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}
