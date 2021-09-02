import 'package:flutter/material.dart';

class RouteHelper {
  RouteHelper._();
  static RouteHelper routeHelper = RouteHelper._();

  final navigatorKey = GlobalKey<NavigatorState>();

  pushNamed(String routeName) {
    navigatorKey.currentState.pushNamed(
      routeName,
    );
  }

  pushReplacementNamed(String routeName) {
    navigatorKey.currentState.pushReplacementNamed(
      routeName,
    );
  }

  pop() {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
    }
  }
}
