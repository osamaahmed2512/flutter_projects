 import 'package:flutter/material.dart';

void Showsnackbar(BuildContext context, String message) {
    if (context.mounted) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}
  }