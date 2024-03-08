import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/sign_in_with_phone_provider.dart';
import '../../utils/get_scale_value.dart';
import '../../utils/show_snack_bar.dart';
import '../../utils/validators.dart';
import '../../widgets/auth_app_logo.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/verified_screen.dart';
import '../loading_screen.dart';

class SignInWithPhoneScreen extends StatelessWidget {
  const SignInWithPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                fontSize: 16 * getScaleValue(context), fontWeight: FontWeight.w500)),
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
                        final String? isValidPhone = validPhone(
                            phoneController: _phoneNumberController);
                        if (isValidPhone == null) {
                          await provider.sendVerificationCode(context,
                              phoneNumber: _phoneNumberController.text);
                        } else {
                          showSnackBar(context: context, errorMessage: isValidPhone);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(42)),
                        backgroundColor: const Color(0xFF674FA3),
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Request OTP', style: TextStyle(fontSize: 16 * getScaleValue(context), fontWeight: FontWeight.bold),),
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
                    child: Text(
                      'Don’t have a phone? Use email instead.',
                      style: TextStyle(color: Color(0xFF909891), fontSize: 14 * getScaleValue(context)),
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
                        final String? isValidOTP = validOTP(otpController: _otpController);
                        if (isValidOTP == null) {
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
                          showSnackBar(context: context, errorMessage: isValidOTP);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(42)),
                        backgroundColor: const Color(0xFF674FA3),
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Verify OTP', style: TextStyle(fontSize: 16 * getScaleValue(context), fontWeight: FontWeight.bold),),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      phoneState.cancelOTPVerification();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xFF909891), fontSize: 14 * getScaleValue(context)),
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
    return const VerifiedScreen(title: 'Mobile number verified', icon: Icons.mobile_friendly);
  }
}
