import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../1_domain/entities/article_entity.dart';
import '../../pages/articles/articles_page.dart';
import '../../pages/details/details_page.dart';
import '../../pages/sources/sources_page.dart';
import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: [GoRouterObserver()],
  initialLocation: '/sources',
  routes: [
    GoRoute(
      path: '/sources',
      builder: (context, state) {
        return const SourcesPageWrapperProvider();
      },
    ),
    GoRoute(
      path: '/sources/articles',
      builder: (context, state) {
        return ArticlesPageWrapperProvider(
          extra: state.extra as String,
        );
      },
    ),
    GoRoute(
      path: '/sources/articles/details',
      builder: (context, state) {
        return DetailsPageWrapperProvider(
          extra: state.extra as ArticleEntity,
        );
      },
    ),
  ],
);
