import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content, {Color? color}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: color,
      content: Text(content),
    ));
}
