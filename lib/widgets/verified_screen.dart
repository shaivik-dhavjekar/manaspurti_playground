import 'package:flutter/material.dart';

class VerifiedScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? extraContent;

  const VerifiedScreen(
      {super.key,
        required this.title,
        required this.icon,
        this.extraContent});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: (mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width : mediaQueryData.size.height) * 0.11,
                    color: const Color(0xFF6A736B)),
              ),
              const SizedBox(height: 25),
              Icon(icon, size: (mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width : mediaQueryData.size.height) * 0.25),
              extraContent != null ? Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: extraContent!,
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
