
import 'package:flutter/widgets.dart';

class RouteItem {
  final String name;
  final String route;
  final WidgetBuilder builder;

  const RouteItem({required this.name, required this.route, required this.builder});
}