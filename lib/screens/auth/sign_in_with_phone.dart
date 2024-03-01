import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manaspurti_playground/providers/sign_in_with_phone_provider.dart';
import 'package:manaspurti_playground/screens/loading_screen.dart';
import 'package:provider/provider.dart';

class SignInWithPhoneScreen extends StatefulWidget {
  const SignInWithPhoneScreen({super.key});

  @override
  State<SignInWithPhoneScreen> createState() => _SignInWithPhoneScreenState();
}

class _SignInWithPhoneScreenState extends State<SignInWithPhoneScreen> {
  final _phoneNumberController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignInWithPhoneProvider>(context);
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
                  Text('Sign in with phone',
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<SignInWithPhoneProvider>(
                    builder: (context, phoneState, _) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!phoneState.isVerificationSent) ...[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.93,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFD0C8E2),
                                  borderRadius: BorderRadius.circular(42)),
                              child: TextFormField(
                                controller: _phoneNumberController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Phone number',
                                    prefixIcon: Icon(Icons.phone)),
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.83,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  provider.sendVerificationCode(context,
                                      phoneNumber: _phoneNumberController.text);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(42)),
                                  backgroundColor: const Color(0xFF674FA3),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Request OTP'),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/sign_in_with_email');
                              },
                              child: const Text(
                                'Don’t have a phone? Use email instead.',
                                style: TextStyle(color: Color(0xFF909891)),
                              ),
                            )
                          ],
                          if (phoneState.isVerificationSent) ...[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.93,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFD0C8E2),
                                  borderRadius: BorderRadius.circular(42)),
                              child: TextFormField(
                                controller: _otpController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'OTP',
                                    prefixIcon: Icon(Icons.key)),
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.83,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  provider.signInWithOTP(
                                      otp: _otpController.text.toString());
                                  if (provider.isVerified) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MobileNumberVerifiedScreen()));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(42)),
                                  backgroundColor: const Color(0xFF674FA3),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Verify OTP'),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                phoneState.cancelOTPVerification();
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Color(0xFF909891)),
                              ),
                            )
                          ],
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            Consumer<SignInWithPhoneProvider>(
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

class MobileNumberVerifiedScreen extends StatefulWidget {
  const MobileNumberVerifiedScreen({super.key});

  @override
  State<MobileNumberVerifiedScreen> createState() =>
      _MobileNumberVerifiedScreenState();
}

class _MobileNumberVerifiedScreenState
    extends State<MobileNumberVerifiedScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        Navigator.pushReplacementNamed(context, '/welcome');
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
              'Mobile number verified',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.11,
                  color: const Color(0xFF6A736B)),
            ),
            const SizedBox(height: 25),
            Icon(Icons.mobile_friendly,
                size: MediaQuery.of(context).size.width * 0.25),
          ],
        ),
      ),
    );
  }
}
