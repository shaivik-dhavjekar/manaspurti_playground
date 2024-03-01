import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manaspurti_playground/providers/forgot_password_provider.dart';
import 'package:manaspurti_playground/utils/validators.dart';
import 'package:manaspurti_playground/widgets/auth_text_field.dart';
import 'package:manaspurti_playground/screens/loading_screen.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForgotPasswordProvider>(context);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/poker360Logo.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text('Forgot Password',
                            style: GoogleFonts.roboto(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.2,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthTextField(
                          textEditingController: _emailController,
                          labelText: 'Email',
                          prefixIcon: Icons.email),
                      const SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.83,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (validEmail(emailController: _emailController)) {
                              await provider.resetPassword(
                                  email: _emailController.text);
                              if (provider.isResetEmailSent) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PasswordResetLinkSentScreen()));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid email.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(42)),
                            backgroundColor: const Color(0xFF674FA3),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Reset Password'),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/sign_in_with_phone',
                            (Route<dynamic> route) => false),
                        child: const Text(
                          'Already a member? Sign in here.',
                          style: TextStyle(color: Color(0xFF909891)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<ForgotPasswordProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const LoadingScreen();
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

class PasswordResetLinkSentScreen extends StatefulWidget {
  const PasswordResetLinkSentScreen({super.key});

  @override
  State<PasswordResetLinkSentScreen> createState() =>
      _PasswordResetLinkSentScreenState();
}

class _PasswordResetLinkSentScreenState
    extends State<PasswordResetLinkSentScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Password reset link sent',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.11,
                  color: const Color(0xFF6A736B)),
            ),
            const SizedBox(height: 25),
            Icon(Icons.mark_email_unread,
                size: MediaQuery.of(context).size.width * 0.25),
            const SizedBox(height: 30),
            const Text(
              'We have sent a password reset link to your registered email address.',
              textAlign: TextAlign.center,
              style: TextStyle(color: const Color(0xFF6A736B)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please use the link to reset password.',
              textAlign: TextAlign.center,
              style: (TextStyle(color: const Color(0xFF6A736B))),
            ),
          ],
        ),
      ),
    );
  }
}
