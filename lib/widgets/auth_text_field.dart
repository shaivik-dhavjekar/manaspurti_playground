import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;

  const AuthTextField(
      {super.key,
        required this.textEditingController,
        required this.labelText,
        required this.prefixIcon,
        this.obscureText = false
      });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width * 0.93 : mediaQueryData.size.width * 0.5,
      decoration: BoxDecoration(
          color: const Color(0xFFD0C8E2),
          borderRadius: BorderRadius.circular(42)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
            controller: textEditingController,
            style: const TextStyle(fontSize: 20, color: Color(0xFF313532)),
            obscureText: obscureText,
            obscuringCharacter: '*',
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labelText,
                labelStyle: const TextStyle(fontSize: 20, color: Color(0xFF313532)),
                isDense: true,
                prefixIcon: Icon(prefixIcon, size: 24),
                prefixIconColor: Colors.black)
        ),
      ),
    );

  }
}
