import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, Object error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(error.toString()),
    backgroundColor: Colors.red,
  ));
}
