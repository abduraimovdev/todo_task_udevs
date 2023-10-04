import 'package:flutter/material.dart';

class AppUtils {
  const AppUtils._();
  static ScaffoldFeatureController msg(BuildContext context, String message,
      {Color color = Colors.green}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}