import 'package:flutter/material.dart';

import '../../../screens/create/add_event_screen.dart';
import '../../../screens/detail/details_event_screen.dart';
import '../../../screens/edit/edit_event_screen.dart';
import '../../../screens/home/home_screen.dart';
import '../../models/todo.dart';

sealed class AppRoute {



  static String get initialRoute => HomeScreen.id;
  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.id: (context) => const HomeScreen(),
    AddEventScreen.id: (context) => const AddEventScreen(),
  };

  // Push Page
  static void pushHome(BuildContext context) {
    Navigator.pushNamed(context, HomeScreen.id);
  }

  static Future<T?> pushAddEvent<T>(BuildContext context) {
    return Navigator.pushNamed(context, AddEventScreen.id);
  }

  static Future<T?> pushEditEvent<T>(BuildContext context, TodoModel todo) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEventScreen(todoModel: todo),
      ),
    );
  }

  static Future<T?> pushDetailsEvent<T>(BuildContext context, TodoModel todo) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsEventScreen(todoModel: todo),
      ),
    );
  }

  // Replacement Page
  static void repHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }

  static void repAddEvent(BuildContext context) {
    Navigator.pushReplacementNamed(context, AddEventScreen.id);
  }

  static void repEditEvent(BuildContext context) {
    Navigator.pushReplacementNamed(context, EditEventScreen.id);
  }

  static void repDetailsEvent(BuildContext context) {
    Navigator.pushReplacementNamed(context, DetailsEventScreen.id);
  }

  // Remove Until To Home
  static void removeToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.id,
      (route) => false,
    );
  }
}
