import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manaspurti_playground/providers/sign_in_with_phone_provider.dart';
import 'package:manaspurti_playground/screens/loading_screen.dart';
import 'package:manaspurti_playground/utils/validators.dart';
import 'package:manaspurti_playground/widgets/auth_app_logo.dart';
import 'package:manaspurti_playground/widgets/auth_text_field.dart';
import 'package:provider/provider.dart';

class SignInWithPhoneScreen extends StatelessWidget {
  const SignInWithPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            OrientationBuilder(
                builder: (context, orientation) {
                  return SingleChildScrollView(
                    child: orientation == Orientation.portrait ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AuthAppLogo(),
                        SizedBox(height: 40),
                        SignInWithPhoneScreenForm()
                      ],
                    ) : const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AuthAppLogo(),
                        SignInWithPhoneScreenForm(),
                      ],
                    ),
                  );
                }
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

class SignInWithPhoneScreenForm extends StatefulWidget {
  const SignInWithPhoneScreenForm({super.key});

  @override
  State<SignInWithPhoneScreenForm> createState() => _SignInWithPhoneScreenFormState();
}

class _SignInWithPhoneScreenFormState extends State<SignInWithPhoneScreenForm> {
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
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final provider = Provider.of<SignInWithPhoneProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                  AuthTextField(textEditingController: _phoneNumberController, labelText: 'Phone number', prefixIcon: Icons.phone),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width * 0.83 : MediaQuery.of(context).size.width * 0.43,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (validPhone(
                            phoneController: _phoneNumberController)) {
                          await provider.sendVerificationCode(context,
                              phoneNumber: _phoneNumberController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a valid phone number.'),
                              backgroundColor: Color(0xFFEFA39F),
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
                  AuthTextField(textEditingController: _otpController, labelText: 'OTP', prefixIcon: Icons.key),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width * 0.83 : MediaQuery.of(context).size.width * 0.43,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (validOTP(
                            otpController: _otpController)) {
                          await provider.signInWithOTP(
                              otp: _otpController.text.toString());
                          if (provider.isVerified) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const MobileNumberVerifiedScreen()));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a valid OTP.'),
                              backgroundColor: Color(0xFFEFA39F),
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
