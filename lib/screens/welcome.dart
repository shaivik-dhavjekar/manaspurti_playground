import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manaspurti_playground/screens/home/home.dart';
import 'package:manaspurti_playground/services/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final AuthService _authService = AuthService();
  late String? displayName;

  @override
  void initState() {
    super.initState();
    fetchDisplayName();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        Navigator.pushReplacement(context, PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                .animate(animation);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
        ),);
      });
    });
  }

  Future<void> fetchDisplayName() async {
    displayName = await _authService.fetchUserDisplayName();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height*0.1),
                Text(
                  'Hi ${displayName ?? 'Unknown'}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 24,
                      color: const Color(0xFF313532)),
                ),
              ],
            ),
          ),
          Center(
            child: IgnorePointer(
              ignoring: true,
              child: SizedBox(
                width: size.width * 0.15,
                height: size.width * 0.15,
                child: const CircularProgressIndicator(
                  strokeWidth: 8,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
