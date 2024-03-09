import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/forgot_password_provider.dart';
import '../../utils/get_scale_value.dart';
import '../../utils/show_snack_bar.dart';
import '../../utils/validators.dart';
import '../../widgets/auth_app_logo.dart';
import '../../widgets/auth_text_field.dart';
import '../../widgets/verified_screen.dart';
import '../loading_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              OrientationBuilder(builder: (context, orientation) {
                return SingleChildScrollView(
                  child: orientation == Orientation.portrait
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AuthAppLogo(),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text('Forgot Password',
                                style: GoogleFonts.roboto(
                                    fontSize: 16 * getScaleValue(context),
                                    fontWeight: FontWeight.w500)),
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
                      ForgotPasswordScreenForm()
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AuthAppLogo(),
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text('Forgot Password',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16 * getScaleValue(context),
                                      fontWeight: FontWeight.w500)),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.4),
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
                          const ForgotPasswordScreenForm(),
                        ],
                      ),
                    ],
                  ),
                );
              }),
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
      ),
    );
  }
}

class ForgotPasswordScreenForm extends StatefulWidget {
  const ForgotPasswordScreenForm({super.key});

  @override
  State<ForgotPasswordScreenForm> createState() => _ForgotPasswordScreenFormState();
}

class _ForgotPasswordScreenFormState extends State<ForgotPasswordScreenForm> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final provider = Provider.of<ForgotPasswordProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
              width: mediaQueryData.orientation == Orientation.portrait ? mediaQueryData.size.width * 0.83 : MediaQuery.of(context).size.width * 0.43,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final String? isValidEmail = validEmail(emailController: _emailController);
                  if (isValidEmail == null) {
                    await provider.resetPassword(
                      context: context,
                        email: _emailController.text);
                    if (provider.isResetEmailSent) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const PasswordResetLinkSentScreen()));
                    }
                  } else {
                    showSnackBar(context: context, errorMessage: isValidEmail);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42)),
                  backgroundColor: const Color(0xFF674FA3),
                  foregroundColor: Colors.white,
                ),
                child: Text('Reset Password', style: TextStyle(fontSize: 16 * getScaleValue(context), fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/sign_in_with_phone',
                      (Route<dynamic> route) => false),
              child: Text(
                'Already a member? Sign in here.',
                style: TextStyle(color: Color(0xFF909891), fontSize: 14 * getScaleValue(context)),
              ),
            ),
          ],
        ),
      ],
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
        Navigator.pushNamedAndRemoveUntil(
            context,
            '/sign_in_with_email',
                (Route<dynamic> route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const VerifiedScreen(title: 'Password reset link sent', icon: Icons.mark_email_unread, extraContent: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'We have sent a password reset link to your registered email address.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF6A736B)),
        ),
        SizedBox(height: 20),
        Text(
          'Please use the link to reset password.',
          textAlign: TextAlign.center,
          style: (TextStyle(color: Color(0xFF6A736B))),
        ),
      ],
    ),);
  }
}

