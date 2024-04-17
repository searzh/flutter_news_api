import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../1_domain/entities/article_entity.dart';

class ArticleListTile extends StatelessWidget {
  const ArticleListTile({
    super.key,
    required this.article,
  });

  final ArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push(
        '/sources/articles/details',
        extra: article,
      ),
      title: Text(
        article.title,
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
            article.description,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          Text(
            article.url,
            style: const TextStyle(color: Colors.amber),
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}
