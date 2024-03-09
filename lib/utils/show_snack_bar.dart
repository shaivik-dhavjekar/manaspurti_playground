import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({required BuildContext context, required String errorMessage}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage, style: const TextStyle(
        color: Color(0xff5c1713)
      ),),
      backgroundColor: const Color(0xFFEFA39F),
    ),
  );
}