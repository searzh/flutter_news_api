import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  GoRouterObserver();

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('[Router] didPop: ${route.settings.name}');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint(
      '[Router] didPush: ${route.settings.name} previousRoute: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint(
      '[Router] didRemove: ${route.settings.name} previousRoute: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    debugPrint(
      '[Router] didStartUserGesture: ${route.settings.name} previousRoute: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didStopUserGesture() {
    debugPrint(
      '[Router] didStopUserGesture',
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint(
      '[Router] didReplace: ${newRoute?.settings.name} previousRoute: ${oldRoute?.settings.name}',
    );
  }
}
