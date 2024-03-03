import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.7)
        ),
        Center(
          child: IgnorePointer(
            ignoring: true,
            child: SizedBox(
              width: mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width * 0.15 : mediaQueryData.size.height * 0.15,
              height: mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width * 0.15 : mediaQueryData.size.height * 0.15,
              child: const CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }
}
