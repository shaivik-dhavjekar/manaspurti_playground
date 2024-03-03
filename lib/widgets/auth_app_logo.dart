import 'package:flutter/material.dart';

class AuthAppLogo extends StatelessWidget {
  const AuthAppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.orientation == Orientation.portrait) {
      return Image.asset(
        'assets/poker360Logo.png',
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
      );
    } else {
      return Image.asset(
        'assets/poker360Logo.png',
        width: MediaQuery.of(context).size.height * 0.6,
        height: MediaQuery.of(context).size.height * 0.6,
      );
    }
  }
}