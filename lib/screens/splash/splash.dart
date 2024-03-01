import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manaspurti_playground/screens/auth/sign_in_with_phone.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward().then((value) => {
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
        pageBuilder: (context, animation, secondaryAnimation) => const SignInWithPhoneScreen(),
      ),)
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        alignment: Alignment.center,
                        width: size.width*0.5,
                        height: size.width*0.5,
                        child: Image.asset('assets/poker360Logo.png',
                            width: _animation.value * size.width*0.5,
                            height: _animation.value * size.width*0.5),
                      );
                    }),
                // AnimatedContainer(duration: Duration(seconds: 2), curve: Curves.easeInOut, width: logoSize, height: logoSize, child: Image.asset('assets/poker360Logo.png'),),
                const SizedBox(height: 20),
                Text(
                  'POKER360',
                  style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 35, color: const Color(0xFF404541))),
                ),
              ],
            ),
            Positioned(
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Made in India \u{1F1EE}\u{1F1F3} blazing ahead', style: GoogleFonts.roboto(color: const Color(0xFF404541)),),
                        const Icon(
                          Icons.rocket_launch_outlined,
                          color: Colors.red,
                          size: 20,
                        ),
                      ],
                    ),
                    Text('\u{00A9} Gamesoft.tech', style: GoogleFonts.roboto(color: const Color(0xFF404541)),)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
